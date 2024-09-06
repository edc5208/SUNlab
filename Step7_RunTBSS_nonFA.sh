#!/bin/bash
module load fsl/6.0.7.4

# I. Navigate to Directory and File Architecture
out_dir_DTI="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti" #where TBSS_non_FA is run from.
bids_dir="/storage/group/edc5208/default/mrn/behavregad/qsiprep/bids/" #BIDS directory

# II. TBSS ON MD IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/MD
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things needs to be rerun
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/MD
    cmd="mv ${out_dir_DTI}/MD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/MD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA MD"
echo ${cmd}
eval ${cmd}

# III. TBSS ON AD IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/AD
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things need to be rerun.
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/AD
    cmd="mv ${out_dir_DTI}/AD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/AD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA AD"
echo ${cmd}
eval ${cmd}

# IV. TBSS ON RD IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/RD
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things need to be rerun
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/RD
    cmd="mv ${out_dir_DTI}/RD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/RD/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA RD"
echo ${cmd}
eval ${cmd}

# V. TBSS ON ICVF/NDI IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/NODDI_ICVF
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things need to be rerun
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/NODDI_ICVF
    cmd="mv ${out_dir_DTI}/NODDI_ICVF/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/NODDI_ICVF/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA NODDI_ICVF"
echo ${cmd}
eval ${cmd}

# VI. TBSS ON ISOVF IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/NODDI_ISOVF
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things need to be rerun
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/NODDI_ISOVF
    cmd="mv ${out_dir_DTI}/NODDI_ISOVF/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/NODDI_ISOVF/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA NODDI_ISOVF"
echo ${cmd}
eval ${cmd}

# VII. TBSS ON ODI IMAGES.
#Running non-FA preparation
cd ${out_dir_DTI}/NODDI_ODI
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd} #in case things need to be rerun
for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/NODDI_ODI
    cmd="mv ${out_dir_DTI}/NODDI_ODI/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/NODDI_ODI/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz"
    echo ${cmd}
    eval ${cmd}
done
cd ${out_dir_DTI}
cmd="tbss_non_FA NODDI_ODI"
echo ${cmd}
eval ${cmd}

##--END--##

