#!/bin/bash

bids_dir="/storage/group/edc5208/default/mrn/behavregad/qsiprep/bids" #BIDS directory here.
qsiprep_derivatives_dir="/storage/group/edc5208/default/mrn/behavregad/qsiprep/derivatives/qsiprep" #QSIPrep output directory.

for i in `ls -d ${bids_dir}/sub* | awk -F'/' '{print $NF}' | awk 'NR>1'`
do
	if [ ! -f ${qsiprep_derivatives_dir}/${i}.html ]
	then
		cmd="sbatch -N 1 -n 10 --mem=48GB -t 48:00:00 -p open `pwd`/run_qsiprep.sh $i"
		echo $cmd
		eval $cmd
	fi
done

#--END--#
