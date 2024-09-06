#!/bin/bash
module load fsl/6.0.7.4

# I. Navigate to Directory and File Architecture
out_dir_DTI="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti"

# II. TBSS
cd ${out_dir_DTI}/FA
cmd="rm -r *FA.nii.gz"
echo ${cmd}
#eval ${cmd}
for subj in `ls -d /storage/group/edc5208/default/mrn/behavregad/qsiprep/bids/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd ${out_dir_DTI}/FA
    cmd="mv ${out_dir_DTI}/FA/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA_reorient.nii.gz ${out_dir_DTI}/FA/sub-${subject}_ses-day2_space-desc-preproc-dtifit_FA.nii.gz" #TBSS compliance
    echo ${cmd}
    eval ${cmd}
done

cd "${out_dir_DTI}/FA"
cmd="tbss_1_preproc *.nii.gz"
echo ${cmd}
eval ${cmd}

#--END--#
