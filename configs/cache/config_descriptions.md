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
