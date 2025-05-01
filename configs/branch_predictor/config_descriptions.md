# Branch Prediction Configuration Folder Descriptions
This document details the different configuration files that were used to test branch predictor performance on LLM workloads. Unless otherwise specified, all of these configuration files were tested on both the selected AI benchmarks and the LLM workload.

## 20241028-example_config
This configuration is a simple example configuration to model future configuration files off of.

## 20241029-bp_bimodal-c_def-p_def
Builds ChampSim with the **bimodal** branch prediction model. Cache and prefetcher contain a default build. 

## 20241029-bp_gshare-c_def-p_def
Builds ChampSim with the **gshare** branch prediction model. Cache and prefetcher contain a default build. 

## 20241030-bp_perceptron-c_def-p_def
Builds ChampSim with the **perceptron** branch prediction model. Cache and prefetcher contain a default build. 

## 20241030-bp_hashed_perceptron-c_def-p_def
Builds ChampSim with the **hashed_perceptron** branch prediction model. Cache and prefetcher contain a default build. 

## 20241103-bp_bimodal-c_def-p_def
Builds ChampSim with the **bimodal** branch prediction model. Cache contains a default build, while the prefetcher was built using the **next_line** prefetcher.

This configuration was created to ensure that the branch predictor statistics did not change with the addition of a prefetcher. 

## 20241103-bp_gshare-c_def-p_def
Builds ChampSim with the **gshare** branch prediction model. Cache contains a default build, while the prefetcher was built using the **next_line** prefetcher.

This configuration was created to ensure that the branch predictor statistics did not change with the addition of a prefetcher. 

## 20241103-bp_perceptron-c_def-p_def
Builds ChampSim with the **perceptron** branch prediction model. Cache contains a default build, while the prefetcher was built using the **next_line** prefetcher.

This configuration was created to ensure that the branch predictor statistics did not change with the addition of a prefetcher. 

## 20241103-bp_hashed_perceptron-c_def-p_def
Builds ChampSim with the **hashed_perceptron** branch prediction model. Cache contains a default build, while the prefetcher was built using the **next_line** prefetcher.

This configuration was created to ensure that the branch predictor statistics did not change with the addition of a prefetcher. 

## 20250116-bp_local-c_def-p_def
Builds ChampSim with the **local** branch prediction model. Cache and prefetcher contain a default build. 

The **local** branch predictor model was created to see how a local branch predictor would perform on the LLM workload. The local branch predictor has a size 1KB for its local history register (LHR) and uses a 3 bit saturating counter for each entry in the LHR. 

## 20250117-bp_multi_level_local-c_def-p_def
Builds ChampSim with the **multi_level_local** branch prediction model (this predictor is also known as a tournament predictor). Cache and prefetcher contain a default build. 

The **multi_level_local** branch predictor model was created to see how a tournament branch predictor would perform on the LLM workload. This tournament predictor was based on the Alpha 21264 microprocessor branch predictor.

## 20250117-bp_multi_level_local_32k-c_def-p_def
Builds ChampSim with the **multi_level_local_32k** branch prediction model (this predictor is also known as a tournament predictor). Cache and prefetcher contain a default build. 

The **multi_level_local_32k** branch predictor model is the same as the **multi_level_local** branch predictor above, but uses a larger storage budget than the Alpha 21264 microprocessor.

## 20250204-bp_tage-c_def-p_def
Builds ChampSim with the **tage** branch prediction model. Cache and prefetcher contain a default build. 

The **tage** branch predictor is based off the TAgged GEometric branch predictor proposed by Dr. Andre Seznec.

## 20250204-bp_ltage-c_def-p_def
Builds ChampSim with the **ltage** branch prediction model. Cache and prefetcher contain a default build. 

The **ltage** branch predictor is based off the TAgged GEometric + Loop branch predictor proposed by Dr. Andre Seznec.



