#!/bin/bash
module load fsl/6.0.6.5

# I. ESTABLISHING FILE DIRECTORIES AND PERTINENT VARIABLES
metrics=("MD" "AD" "NODDI_ODI") #only need metrics whose contrasts yielded significant differences.
corrp_name=("tbss_tfce_corrp_fstat1.nii.gz") #only the contrasts that yielded significant differences (using f-stat)
stats_dir="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti/stats_misc/ANALYSIS" #where randomise output was stored.
tbss_dir="/storage/group/edc5208/default/sunderland/TBSS/OutputPrelim/tbss_dti/stats" #where skeletonised maps are

# II. SIGNIFICANT CLUSTER ROI MASKS
cmd="mkdir ${stats_dir}/CORRP_MASKS"
echo ${cmd}
eval ${cmd}
for met in "${metrics[@]}"; do
    tmpdir="${stats_dir}/${met}/Analysis"
    for file in "${corrp_name[@]}"; do
        cmd="cluster --in=${tmpdir}/${file} --thresh=0.95 --othresh=${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh --oindex=${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_idx --verbose"
        echo ${cmd}
        eval ${cmd}
    done
done
for met in "${metrics[@]}"; do
    tmpdir="${stats_dir}/${met}/Analysis"
    for file in "${corrp_name[@]}"; do
        cmd="cluster --in=${tmpdir}/${file} --thresh=0.993 --othresh=${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh --oindex=${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_idx --verbose"
        echo ${cmd}
        eval ${cmd}
    done
done

# III. Extracting the largest cluster for visualization
mdstr="MD"
adstr="AD"
odistr="NODDI_ODI"
for met in "${metrics[@]}"; do
    if [[ "${met}" == "${mdstr}" ]]; then
        cmd="fslmaths -dt int ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_idx.nii.gz -thr 2 -uthr 2 -bin ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz" #2nd cluster is largest
        echo ${cmd}
        eval ${cmd}
    elif [[ "${met}" == "${adstr}" ]]; then
        cmd="fslmaths -dt int ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_idx.nii.gz -thr 1 -uthr 1 -bin ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz" #1st cluster is largest
        echo ${cmd}
        eval ${cmd}
    elif [[ "${met}" == "${odistr}" ]]; then
        cmd="fslmaths -dt int ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_idx.nii.gz -thr 6 -uthr 6 -bin ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz" #6th cluster is largest
        echo ${cmd}
        eval ${cmd}
    fi
done
for met in "${metrics[@]}"; do
    if [[ "${met}" == "${adstr}" ]]; then
        cmd="fslmaths -dt int ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_idx.nii.gz -thr 1 -uthr 1 -bin ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_maxclustersz.nii.gz" #1st cluster is largest
        echo ${cmd}
        eval ${cmd}
    elif [[ "${met}" == "${odistr}" ]]; then
        cmd="fslmaths -dt int ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_idx.nii.gz -thr 1 -uthr 1 -bin ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_maxclustersz.nii.gz" #1st cluster is largest
        echo ${cmd}
        eval ${cmd}
    fi
done

cd ${stats_dir}/CORRP_MASKS
for idx in {0..57}; do #will change depending on number of subjects. Recall in Bash indexing starts at zero.
    for met in "${metrics[@]}"; do
        #mkdir "${stats_dir}/CORRP_MASKS/${met}"
        tmpdir="${stats_dir}/CORRP_MASKS/${met}"
        cmd="fslroi ${tbss_dir}/all_${met}_skeletonised.nii.gz ${tmpdir}/${met}_skeletonised_${idx}.nii.gz ${idx} 1" #breaks down 4D image into 3D image
        echo ${cmd}
        eval ${cmd}
    done
done

for idx in {0..57}; do
    for met in "${metrics[@]}"; do
        if [[ "${met}" == "${mdstr}" ]]; then
            tmpdir="${stats_dir}/CORRP_MASKS/${met}"
            cmd="fslmeants -i ${tmpdir}/${met}_skeletonised_${idx}.nii.gz -m ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz -o ${tmpdir}/${met}_${file}_95cluster_${idx}.txt --verbose" #computing avg
            echo ${cmd}
            eval ${cmd}
        elif [[ "${met}" == "${adstr}" ]]; then
            tmpdir="${stats_dir}/CORRP_MASKS/${met}"
            cmd="fslmeants -i ${tmpdir}/${met}_skeletonised_${idx}.nii.gz -m ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz -o ${tmpdir}/${met}_${file}_95cluster_${idx}.txt --verbose" #computing avg
            echo ${cmd}
            eval ${cmd}
            cmd="fslmeants -i ${tmpdir}/${met}_skeletonised_${idx}.nii.gz -m ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_maxclustersz.nii.gz -o ${tmpdir}/${met}_${file}_993cluster_${idx}.txt --verbose" #computing avg
            echo ${cmd}
            eval ${cmd}
        elif [[ "${met}" == "${odistr}" ]]; then
            tmpdir="${stats_dir}/CORRP_MASKS/${met}"
            cmd="fslmeants -i ${tmpdir}/${met}_skeletonised_${idx}.nii.gz -m ${stats_dir}/CORRP_MASKS/${met}_${file}_95thresh_maxclustersz.nii.gz -o ${tmpdir}/${met}_${file}_95cluster_${idx}.txt --verbose" #computing avg
            echo ${cmd}
            eval ${cmd}
            cmd="fslmeants -i ${tmpdir}/${met}_skeletonised_${idx}.nii.gz -m ${stats_dir}/CORRP_MASKS/${met}_${file}_993thresh_maxclustersz.nii.gz -o ${tmpdir}/${met}_${file}_993cluster_${idx}.txt --verbose" #computing avg
            echo ${cmd}
            eval ${cmd}
        fi
    done
done

# IV. Aggregating All Together in Text Files for R Statistical Analysis
for met in "${metrics[@]}"; do
    for file in "${corrp_name[@]}"; do
        tmpdir="${stats_dir}/CORRP_MASKS"
        cd ${tmpdir}
        cmd="touch Average_${met}_${file}_95thresh_Agg.txt"
        echo ${cmd}
        eval ${cmd}
        cmd="touch Average_${met}_${file}_993thresh_Agg.txt"
        echo ${cmd}
        eval ${cmd}
    done
done

for met in "${metrics[@]}"; do
    for file in "${corrp_name[@]}"; do
        cd ${stats_dir}/CORRP_MASKS/${met} #navigating to where each subject's values are
        for txt in ${met}_${file}_95cluster*.txt; do #all text files with a looped prefix
            echo "${txt}" >> ${tmpdir}/Average_${met}_${file}_95thresh_Agg.txt #print file name for indexing in R
            cat "${txt}" >> ${tmpdir}/Average_${met}_${file}_95thresh_Agg.txt  #paste contents
        done
        for txt in ${met}_${file}_993cluster*.txt; do #all text files with a looped prefix
            echo "${txt}" >> ${tmpdir}/Average_${met}_${file}_993thresh_Agg.txt #print file name for indexing in R
            cat "${txt}" >> ${tmpdir}/Average_${met}_${file}_993thresh_Agg.txt  #paste contents
        done
    done
done
