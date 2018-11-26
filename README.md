# Posterior samples of the parameters of black hole mergers released to date in the second Advanced LIGO--Virgo observing run

**Soumi De<sup>1</sup>, Collin D. Capano<sup>2,3</sup>, Christopher M. Biwer<sup>4</sup>, Alexander H. Nitz<sup>2,3</sup>, Duncan A. Brown<sup>1</sup>**

**<sup>1</sup>Department of Physics, Syracuse University, Syracuse, NY 13244, USA**

**<sup>2</sup>Albert-Einstein-Institut, Max-Planck-Institut for Gravitationsphysik, D-30167 Hannover, Germany**

**<sup>3</sup>Leibniz Universit{\"a}t Hannover, D-30167, Hannover, Germany**

**<sup>4</sup>Los Alamos National Laboratory, Los Alamos, NM 87545, USA**

## License

![Creative Commons License](https://i.creativecommons.org/l/by-sa/3.0/us/88x31.png "Creative Commons License")

This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 United States License](http://creativecommons.org/licenses/by-sa/3.0/us/).

## Introduction

This is the first public data release of samples from the posterior probability density function for the three binary black hole mergers---GW170104, GW170608, and GW170814---detected during the second observing run of the Advanced LIGO and Virgo observatories. The analysis to generate the data is presented in the paper posted at [arxiv:1811.09232](https://arxiv.org/abs/1811.09232). We provide a notebook to demonstrate how to read the files containing the posterior samples, handle the data, tools for visualizing the data, and commands for reconstructing figures 1, 2 and 3 in the paper. We also provide the configuration files and sample scripts with command lines to replicate our analyses for the three events to generate these data.

We encourage use of these data in derivative works. If you use the material provided here, please cite the companion paper using the following reference for describing the data.
```
@article{De:2018,
      author         = "De, Soumi and Capano, Collin D. and Biwer, C. M. and Nitz, Alexander H. and Brown, Duncan A.",
      title          = "{Posterior samples of the parameters of black hole mergers released to date in the second Advanced LIGO--Virgo observing run}",
      year           = "2018",
      eprint         = "1811.09232",
      archivePrefix  = "arXiv",
      primaryClass   = "astro-ph.IM",
      SLACcitation   = "%%CITATION = ARXIV:1811.09232;%%"
}
```

Please also cite the paper [arxiv:1807.10312](https://arxiv.org/abs/1807.10312) using the following reference for the process of generating the data in this work:
```
@article{Biwer:2018,
      author         = "Biwer, C. M. and Capano, Collin D. and De, Soumi and
                        Cabero, Miriam and Brown, Duncan A. and Nitz, Alexander H. and Raymond, V.",
      title          = "{PyCBC Inference: A Python-based parameter estimation toolkit for compact-object merger signals}",
      year           = "2018",
      eprint         = "1807.10312",
      archivePrefix  = "arXiv",
      primaryClass   = "astro-ph.IM",
      SLACcitation   = "%%CITATION = ARXIV:1807.10312;%%"
}
```

The parameter estimation analyses to generate the posterior samples and construction of the figures to visualize the results have been performed with **PyCBC v1.12.3**.

The contents in the repository are organized as follows :

- ``data_release_o2_bbh_pe.ipynb`` : Notebook demonstrating tools to handle the released posteriors, visualize them, and reconstruct Figures in the paper arxiv:1811.09232

- ``posteriors`` : Directory having the posterior files
    - ``GW170104`` : Directory for GW170104
        - [gw170104_posteriors_thinned.hdf](https://github.com/gwastro/o2-bbh-pe/blob/master/posteriors/GW170104/gw170104_posteriors_thinned.hdf) : File containing posterior samples from the MCMC for measuring properties of GW170104.
    - ``GW170608`` : Directory for GW170608
        - [gw170608_posteriors_thinned.hdf](https://github.com/gwastro/o2-bbh-pe/blob/master/posteriors/GW170608/gw170608_posteriors_thinned.hdf) : File containing posterior samples from the MCMC for measuring properties of GW170608.
    - ``GW170814`` : Directory for GW170814
        - [gw170814_posteriors_thinned.hdf](https://github.com/gwastro/o2-bbh-pe/blob/master/posteriors/GW170814/gw170814_posteriors_thinned.hdf) : File containing posterior samples from the MCMC for measuring properties of GW170814.

- ``run_files`` : Directory having run scripts and configuration files to replicate the analyses
    - ``GW170104`` : Directory for GW170104
        - ``gw170104_inference.ini`` : Configuration file for GW170104 analysis
        - ``run_pycbc_inference_gw170104.sh`` : Run script for GW170104 analysis
    - ``GW170608`` : Directory for GW170608
        - ``gw170608_inference.ini`` : Configuration file for GW170608 analysis
        - ``run_pycbc_inference_gw170608.sh`` : Run script for GW170608 analysis
    - ``GW170814`` : Directory for GW170814 :
        - ``gw170814_inference.ini`` : Configuration file for GW170814 analysis
        - ``run_pycbc_inference_gw170814.sh`` : Run script for GW170814 analysis
    - ``run_pycbc_inference_extract_samples.sh`` : Contains command for extracting independent samples from the full chains obtained from the MCMC runs.

## Running the notebook in a Docker container

This notebook can be run from a PyCBC Docker container, or a machine with PyCBC installed. Instructions for [downloading the docker container](http://gwastro.github.io/pycbc/latest/html/docker.html) are available from the [PyCBC home page.](https://pycbc.org/) To start a container with instance of Jupyter notebook, run the commands
```sh
docker pull pycbc/pycbc-el7:v1.12.3
docker run -p 8888:8888 --name pycbc_notebook -it pycbc/pycbc-el7:v1.12.3 /bin/bash -l
```
Once the container has started, this git repository can be downloaded with the command:
```sh
git clone https://github.com/gwastro/o2-bbh-pe.git
```
The notebook server can be started inside the container with the command:
```sh
jupyter notebook --ip 0.0.0.0 --no-browser
```
You can then connect to the notebook server at the URL printed by ``jupyter``. Navigate to the directory `o2-bbh-pe` in the cloned git repository and open [data_release_o2_bbh_pe.ipynb](https://github.com/gwastro/o2-bbh-pe/blob/master/data_release_o2_bbh_pe.ipynb) (this notebook).

## Acknowledgements
This research has made use of data from the Gravitational Wave Open Science Center [https://www.gw-openscience.org](https://www.gw-openscience.org). Computations were performed in the Syracuse University SUGWG cluster.

**Funding:** This work was supported by NSF awards PHY-1707954 (DAB, SD), and PHY-1607169 (SD). SD was also supported by the Inaugural Kathy '73 and Stan '72 Walters Endowed Fund for Science Research Graduate Fellowship at Syracuse University. Computations were supported by Syracuse University and NSF award OAC-1541396.

**Authors' contributions:** Conceptualization: DAB, Methodology: SD, CMB, CDC, AHN; Software: CMB, CDC, SD, AHN, DAB; Validation: CDC, CMB, AHN; Formal Analysis: SD; Investigation: SD, CMB, CDC, AHN; Resources: DAB; Data Curation: DAB, CDC, CMB, AHN and SD; Writing: SD, CMB, CDC, DAB, and AHN; Visualization: SD, CMB, CDC, AHN; Supervision: DAB; Project Administration: DAB; Funding Acquisition: DAB.
