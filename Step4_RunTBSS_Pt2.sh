#!/bin/bash
module load fsl/6.0.7.4

# I. Navigate to Directory and File Architecture
out_dir_DTI="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti" #where your TBSS directory is (i.e., where DTI/NODDI data have been copied into)

#Nonlinear registration to FMIRB58
cd "${out_dir_DTI}/FA"
cmd="sbatch -N 1 -n 10 --mem=48GB -t 12:00:00 -p open tbss_2_reg -T" #scales to FMRIRB
echo ${cmd}
eval ${cmd}
