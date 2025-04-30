# Cache Configuration Folder Descriptions

## 20241028-example_config_files
This folder contains all the example configuration files, .slurm, and .sh files.

##20241107-bp_def-c_2L1-p_sppL2C
This folder contains the json config file in which only the L1 cache size (instruction and data) is doubled to 64KB and 96KB respectively and a             
prefetcher of spp_dev is set in only L2C. The replacement policy was the default of Least Recently Used (lru) for all cache levels.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241107-bp_def-c_2L2-p_sppL2C
This folder contains the json config file in which only the L2 cache size is doubled to 1MB and a prefetcher of spp_dev is set in only L2C.                 
The default bimodal branch predictor was used. The replacement policy was the default of Least Recently Used (lru) for all cache levels.
This was run on the LLM workloads.

##20241107-bp_def-c_2LLC-p_sppL2C
This folder contains the json config file in which only the LLC cache size is doubled to 4MB and a prefetcher of spp_dev is set in only L2C.
The default bimodal branch predictor was used. The replacement policy was the default of Least Recently Used (lru) for all cache levels. 
This was run on the LLM workloads.

##20241108-bp_def-c_2L1-p_def
This folder contains the json config file in which only the L1 cache size (instruction and data) is doubled to 64KB and 96KB respectively.
The replacement policy was the default of Least Recently Used (lru) for all cache levels.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241108-bp_def-c_2L2-p_def
This folder contains the json config file in which only the L2 cache size is doubled to 1MB.
The replacement policy was the default of Least Recently Used (lru) for all cache levels.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241108-bp_def-c_2LLC-p_def
This folder contains the json config file in which only the LLC cache size is doubled to 4MB. 
The replacement policy was the default of Least Recently Used (lru) for all cache levels.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241108-bp_def-c_drrip_all-p_def
This folder contains the json config file in which all caches (L1I, L1D, L2C, and LLC) used the Dynamic Re-reference Interval Prediction (drrip)
replacement policy. All cache sizes were default.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241111-bp_def-c_ship_all-p_def
This folder contains the json config file in which all caches (L1I, L1D, L2C, and LLC) used the Signature-based Hit Predictor (ship)            
replacement policy. All cache sizes were default.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241111-bp_def-c_srrip_all-p_def
This folder contains the json config file in which all caches (L1I, L1D, L2C, and LLC) used the Static Re-reference Interval Prediction (srrip)
replacement policy. All cache sizes were default.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20241203-bp_def-c_LLCfreq2GHz-p_def
This folder contains the json config file in which the LLC frequency is set to 2GHz while L1, L2, and the CPU clock frequencies are at 4GHz.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250102-bp_def-c_2L1_1.5L2-p_def
This folder contains the json config file in which the L1D and L1I cache sizes were doubled to 64KB and 96KB respectively and L2 cache size was 1.5x from the default at 768KB.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250107-bp_def-c_2L1_2L2-p_def
This folder contains the json config file in which the L1D and L1I cache sizes were doubled to 64KB and 96KB respectively and L2 cache size was doubled to 1MB.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250107-bp_def-c_LLCfreq6GHz-p_def
This folder contains the json config file in which the LLC frequency was set to 6GHz while L1, L2, and the CPU clock frequencies were at 4GHz.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250121-bp_def-c_def-p_def
This folder contains the json config file in which the Champsim's default configuration was run.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250121-bp_def-c_DRAM_2.4GHz-p_def
This folder contains the json config file in which the DDR speed was set to 2.4 GT/s.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250121-bp_def-c_DRAM_4GHz-p_def
This folder contains the json config file in which the DDR speed was set to 4 GT/s.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250211-bp_def-c_2L1_LRU_LLC6GHz_DRAM4GHz-p_def
This folder contains the json config file in which the L1C was doubled in size, LRU was implemented in all caches, LLC frequency was set to 6 GHz, and the DDR speed was set to 4 GT/s.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250228-bp_def-c_L1srrip_L2LLClru-p_def
This folder contains the json config file in which the L1C was set to use SRRIP and the rest of the caches were configured with LRU.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250307-bp_def-c_2*L1_L1srrip_L2LLClru_DDR4GTs
This folder contains the json config file in which the L1C was doubled in size, L1C was set with SRRIP, the rest of the caches were implemented with LRU, and the DDR speed was set to 4 GT/s.
No prefetcher was used.
The default bimodal branch predictor was used.
This was run on the LLM workloads.

##20250325-integrated3run2
This folder contains the json config file in which the Integrated 3 trial was run. L1C was doubled in size, L1C was set with SRRIP, the rest of the caches were implemented with LRU, and DDR speed was set to 4 GT/s.
The next_line prefetcher was implemented in L2C.
The hashed_perceptron branch predictor was used.
This was run on the LLM workloads.

##20250325-integrated3run2bms
This folder contains the json config file in which the Integrated 3 trial was run on the benchmarks. L1C was doubled in size, L1C was set with SRRIP, the rest of the caches were implemented with LRU, and DDR speed was set to 4 GT/s.
The next_line prefetcher was implemented in L2C.
The hashed_perceptron branch predictor was used.
This was run on the AI benchmark workloads.
