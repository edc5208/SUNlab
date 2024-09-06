#!/bin/bash
script_dir="/storage/group/edc5208/default/sunderland/TBSS/UpdatedScripts"
bids_dir="/storage/group/edc5208/default/mrn/behavregad/dtiprep/bids/"

for subj in `ls -d ${bids_dir}/sub*`; do
    subject=`echo $subj | cut -d '-' -f2` #just get the subject ID
    cd /storage/group/edc5208/default/scripts/ #where my new fn is
    cmd="${script_dir}/filearchsetup.sh sub-${subject}"
    echo ${cmd}
    eval ${cmd}
done
