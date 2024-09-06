#!/bin/bash
module load fsl/6.0.7.4

# Ia. Navigate to Directory and File Architecture
out_dir_DTI="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti"

# II. TBSS
#Final preparation step for randomise.
cd "${out_dir_DTI}/FA"
cmd="tbss_4_prestats 0.2" #common threshold used. Confirmed with above command.
echo ${cmd}
eval ${cmd}

##--END--##
