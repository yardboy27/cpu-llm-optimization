
#include <algorithm>
#include <array>
#include <map>
#include <optional>

#include "cache.h"
#include "msl/lru_table.h"

namespace
{
struct tracker {
  struct tracker_entry {
    uint64_t ip = 0;           // The instruction pointer (IP) we're tracking
    uint64_t last_cl_addr = 0; // Last accessed cache-line address by this IP
    std::array<int64_t, 3> strides = {0, 0, 0}; // History of last 3 strides (adjustable)

    auto index() const { return ip; }
    auto tag() const { return ip; }
  };

  struct lookahead_entry {
    uint64_t address = 0;
    std::array<int64_t, 3> strides = {0, 0, 0}; // Track multiple strides
    int degree = 0; // Remaining lookahead depth
  };

  constexpr static std::size_t TRACKER_SETS = 256;
  constexpr static std::size_t TRACKER_WAYS = 4;
  constexpr static int PREFETCH_DEGREE = 3;
  constexpr static int STRIDE_HISTORY_SIZE = 3; // Number of past strides to consider

  std::optional<lookahead_entry> active_lookahead;

  champsim::msl::lru_table<tracker_entry> table{TRACKER_SETS, TRACKER_WAYS};

public:
  void initiate_lookahead(uint64_t ip, uint64_t cl_addr)
  {
    std::array<int64_t, STRIDE_HISTORY_SIZE> new_strides = {0, 0, 0};

    auto found = table.check_hit({ip, cl_addr, new_strides});

    if (found.has_value()) {
      // Compute the new stride
      int64_t new_stride = static_cast<int64_t>(cl_addr) - static_cast<int64_t>(found->last_cl_addr);

      // Shift old strides and insert the new one
      new_strides = found->strides;
      for (int i = STRIDE_HISTORY_SIZE - 1; i > 0; --i) {
        new_strides[i] = new_strides[i - 1];
      }
      new_strides[0] = new_stride;

      // Start prefetching if there's a repeating stride pattern
      if (std::count(new_strides.begin(), new_strides.end(), new_stride) > 1) {
        active_lookahead = {cl_addr << LOG2_BLOCK_SIZE, new_strides, PREFETCH_DEGREE};
      }
    }

    // Update tracking table
    table.fill({ip, cl_addr, new_strides});
  }

  void advance_lookahead(CACHE* cache)
  {
    if (active_lookahead.has_value()) {
      auto [old_pf_address, strides, degree] = active_lookahead.value();
      assert(degree > 0);

      for (int64_t stride : strides) {
        if (stride == 0) continue; // Skip empty strides

        auto addr_delta = stride * BLOCK_SIZE;
        auto pf_address = static_cast<uint64_t>(static_cast<int64_t>(old_pf_address) + addr_delta);

        // Stop if the next step exceeds the page boundary
        if (cache->virtual_prefetch || (pf_address >> LOG2_PAGE_SIZE) == (old_pf_address >> LOG2_PAGE_SIZE)) {
          bool success = cache->prefetch_line(pf_address, (cache->get_mshr_occupancy_ratio() < 0.5), 0);
          if (success) {
            active_lookahead = {pf_address, strides, degree - 1};
          }
        } else {
          active_lookahead.reset();
        }
      }

      // Stop prefetching if we reached the prefetch limit
      if (active_lookahead->degree == 0) {
        active_lookahead.reset();
      }
    }
  }
};

std::map<CACHE*, tracker> trackers;
} // namespace

void CACHE::prefetcher_initialize() {}

void CACHE::prefetcher_cycle_operate() { ::trackers[this].advance_lookahead(this); }

uint32_t CACHE::prefetcher_cache_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, bool useful_prefetch, uint8_t type, uint32_t metadata_in)
{
  ::trackers[this].initiate_lookahead(ip, addr >> LOG2_BLOCK_SIZE);
  return metadata_in;
}

uint32_t CACHE::prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr, uint32_t metadata_in)
{
  return metadata_in;
}

void CACHE::prefetcher_final_stats() {}

