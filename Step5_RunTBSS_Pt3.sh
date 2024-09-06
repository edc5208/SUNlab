#!/bin/bash
module load fsl/6.0.7.4

# I. Navigate to Directory and File Architecture
out_dir_DTI="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti"

#Warping all subjects to this FMRIB58 space as recommended by FSL creators for better alignment.
cd "${out_dir_DTI}/FA"
cmd="sbatch -N 1 -n 10 --mem=48GB -t 12:00:00 -p open tbss_3_postreg -T" 
echo ${cmd}
eval ${cmd}
echo "Finished registration of each image. Check all_FA thresholding."

##--END--##
