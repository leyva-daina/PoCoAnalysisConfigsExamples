source /cvmfs/cms.cern.ch/cmsset_default.sh
micromamba activate pocket-coffea 

# go to your folder, where you want to run the analysis

git clone https://github.com/PocketCoffea/AnalysisConfigs.git
cd AnalysisConfigs/configs/zmumu

# change your dataset files, to use those in https://github.com/leyva-daina/PoCoAnalysisConfigsExamples/tree/main/configs/zmumu/datasets

# first run local test
pocket-coffea run --test --cfg example_config.py --ignore-grid-certificate --custom-run-options my_run_options.yaml  -o output_local_test 

# Now, before submitting to condor, you will have to change the NAF executor python configuration from Pocket-Coffea
# This is mainly because a few changes are needed to be able to work without a GRID certificate
# You can use the one here https://github.com/leyva-daina/PocketCoffea/blob/Summies25/pocket_coffea/executors/executors_DESY_NAF.py
# Copy also these custom run options from https://github.com/leyva-daina/PoCoAnalysisConfigsExamples/blob/main/configs/zmumu/my_run_options.yaml

# Submit to condor a test
pocket-coffea run --test --cfg example_config.py  --ignore-grid-certificate --process-separately --executor parsl-condor@DESY_NAF --custom-run-options my_run_options.yaml  -o output_dask_test2

#Proceed submitting the jobs
pocket-coffea run --cfg example_config.py --ignore-grid-certificate --process-separately --executor parsl-condor@DESY_NAF --custom-run-options my_run_options.yaml  -o output_dask
