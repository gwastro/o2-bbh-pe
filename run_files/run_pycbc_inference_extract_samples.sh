#! /bin/bash -v

# The following shows the process of thinning the chains of posterior samples stored in the output file obtained from running pycbc_inference. The chains can then be thinned to eliminate correlations along the chains and extracting independent samples.

# For example the output file from running pycbc_inference using the sample script o2-bbh-pe/run_files/GW170104/run_pycbc_inference_gw170104.sh is gw170104_posteriors.hdf . We then thin the samples and store them in gw170104_posteriors_thinned.hdf .

input_file=gw170104_posteriors.hdf

pycbc_inference_extract_samples --verbose \
    --output-file gw170104_posteriors_thinned.hdf \
    --input-file ${input_file} \
    --posterior-only
