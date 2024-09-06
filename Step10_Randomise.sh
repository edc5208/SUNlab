#!/bin/bash
module load fsl/6.0.7.4

# I. Navigate to Directory and File Architecture
analysis_dir="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti/stats_misc/ANALYSIS" #where you want randomise output stored, separate folders therein per metric.
meanFA_dir="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti/stats" #where the original TBSS (on FA images) output is.

# II. RANDOMISE ON FA IMAGES
mkdir ${analysis_dir}/FA/
cd ${analysis_dir}/FA/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_FA_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# III. RANDOMISE ON MD IMAGES
mkdir ${analysis_dir}/MD/
cd ${analysis_dir}/MD/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_MD_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# IV. RANDOMISE ON AD IMAGES
mkdir ${analysis_dir}/AD/
cd ${analysis_dir}/AD/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_AD_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# V. RANDOMISE ON RD IMAGES
mkdir ${analysis_dir}/RD/
cd ${analysis_dir}/RD/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_RD_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# VI. RANDOMISE ON ICVF IMAGES
mkdir ${analysis_dir}/NODDI_ICVF/
cd ${analysis_dir}/NODDI_ICVF/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_NODDI_ICVF_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# VII. RANDOMISE ON ISOVF IMAGES
mkdir ${analysis_dir}/NODDI_ISOVF/
cd ${analysis_dir}/NODDI_ISOVF/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_NODDI_ISOVF_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

# VIII. RANDOMISE ON ODI IMAGES
mkdir ${analysis_dir}/NODDI_ODI/
cd ${analysis_dir}/NODDI_ODI/
cmd="sbatch -N 1 -n 1 --mem=64GB -t 48:00:00 -p open randomise -i ${meanFA_dir}/all_NODDI_ODI_skeletonised.nii.gz -o tbss -m ${meanFA_dir}/mean_FA_skeleton_mask.nii.gz -d ${analysis_dir}/2x2_ancova_design.mat -t ${analysis_dir}/2x2_ancova_design.con -f ${analysis_dir}/2x2_ancova_design.fts -n 5000 --T2" #--T2 is TFCE
echo ${cmd}
eval ${cmd}

##--END--##
