#! /bin/bash -v

# The frame files can be downloaded from the Gravitational Wave Open Science Center (GWOSC) with the following commands
#wget https://www.gw-openscience.org/catalog/GWTC-1-confident/data/GW170608/H-H1_GWOSC_16KHZ_R1-1180920447-4096.gwf
#wget https://www.gw-openscience.org/catalog/GWTC-1-confident/data/GW170608/L-L1_GWOSC_16KHZ_R1-1180920447-4096.gwf

# pycbc_inference can also be run on multiple machines using MPI for which add --use-mpi to the command line below

pycbc_config_file=gw170608_inference.ini
pycbc_output_file=gw170608_posteriors.hdf

# data
FRAMES="H1:H-H1_GWOSC_16KHZ_R1-1180920447-4096.gwf L1:L-L1_GWOSC_16KHZ_R1-1180920447-4096.gwf"
CHANNELS="H1:GWOSC-16KHZ_R1_STRAIN L1:GWOSC-16KHZ_R1_STRAIN"

# trigger parameters
TRIGGER_TIME=1180922494.49

# data to use
# the longest waveform covered by the prior must fit in these times
SEARCH_BEFORE=46
SEARCH_AFTER=2

# use an extra number of seconds of data in addition to the data specified
PAD_DATA=8

# get coalescence time as an integer
TRIGGER_TIME_INT=${TRIGGER_TIME%.*}

# PSD estimation options
PSD_ESTIMATION="H1:median L1:median"
PSD_INVLEN=4
PSD_SEG_LEN=8
PSD_STRIDE=4
PSD_DATA_LEN=1024  # The data files are 512 s long. So I leave 8s from the beginning and the end of the frame files plus 8 s on each side for pad-data. 
PSD_GATE="H1:1180922489.0:7.0:0.5 L1:1180922489.0:7.0:0.5"

# start and end time of data to read in
GPS_START_TIME=$((${TRIGGER_TIME_INT} - ${SEARCH_BEFORE} - ${PSD_INVLEN}))
GPS_END_TIME=$((${TRIGGER_TIME_INT} + ${SEARCH_AFTER} + ${PSD_INVLEN}))
echo $GPS_START_TIME
echo $GPS_END_TIME

# start and end time of data to read in for PSD estimation
PSD_START_TIME=$((${TRIGGER_TIME_INT} - ${PSD_DATA_LEN}/2))
PSD_END_TIME=$((${TRIGGER_TIME_INT} + ${PSD_DATA_LEN}/2))
echo ${PSD_START_TIME}
echo ${PSD_END_TIME}


# sampler parameters
IFOS="H1 L1"
SAMPLE_RATE=2048
F_HIGHPASS=15
F_MIN="H1:30 L1:20"
N_WALKERS=200
N_TEMPS=20
N_SAMPLES=8000
N_CHECKPOINT=2000
PROCESSING_SCHEME=mkl

# the following sets the number of cores to use; adjust as needed to
# your computer's capabilities
N_PROCS=190

SEED=12

export OMP_NUM_THREADS=1
pycbc_inference --verbose \
    --seed ${SEED} \
    --instruments ${IFOS} \
    --gps-start-time ${GPS_START_TIME} \
    --gps-end-time ${GPS_END_TIME} \
    --frame-files ${FRAMES} \
    --channel-name ${CHANNELS} \
    --strain-high-pass ${F_HIGHPASS} \
    --pad-data ${PAD_DATA} \
    --psd-start-time ${PSD_START_TIME} \
    --psd-end-time ${PSD_END_TIME} \
    --psd-estimation ${PSD_ESTIMATION} \
    --psd-segment-length ${PSD_SEG_LEN} \
    --psd-gate ${PSD_GATE} \
    --psd-segment-stride ${PSD_STRIDE} \
    --psd-inverse-length ${PSD_INVLEN} \
    --sample-rate ${SAMPLE_RATE} \
    --low-frequency-cutoff ${F_MIN} \
    --config-file ${pycbc_config_file} \
    --output-file ${pycbc_output_file} \
    --processing-scheme ${PROCESSING_SCHEME} \
    --sampler emcee_pt \
    --ntemps ${N_TEMPS} \
    --likelihood-evaluator marginalized_phase \
    --burn-in-function n_acl \
    --nwalkers ${N_WALKERS} \
    --n-independent-samples ${N_SAMPLES} \
    --checkpoint-interval ${N_CHECKPOINT} \
    --nprocesses ${N_PROCS}
