*For purposes of bookkeeping, all updated .sh files are saved at “storage/group/edc5208/default/sunderland/TBSS/UpdatedScripts”. These files and .Rmd files are also copied over into my secure Penn State University OneDrive for shareability, as well as all necessary data files should those be shared as part of a data/code availability agreement.

I. The first script to run is Step1_RunQSIPrep_Loop.sh. At the top of this file, you will find directory variables that you will need to swap out with your individualized directories; no other alterations down the line should need to be made in terms of defining file paths. This script loops through your BIDS directory and executes the QSIPrep pipeline on each participant.
•	Before running the script in red, refer to run_qsiprep.sh (what the script is iteratively looping through) and ensure your file directories are accurate for your computer. You will need to know where QSIPrep output is/should be stored, your FreeSurfer output file path, your FreeSurfer license, your BIDS directory to be referred to in QSIPrep, and respective derivatives and work directories therein.
•	Evaluation (eval) are currently commented out and need to be uncommented to run. Step 1 should only need to be run once, ever. Must be run with SBATCH; takes about 12hrs.

II. The second script to run is Step2_TBSSFileArch_Setup.sh. This scripts iteratively loops through the complementary script filearchsetup.sh. This command is simply preparing the file architecture/structure setup for tract-based spatial statistics (TBSS) to run smoothly. It will also reorient the DTI and NODDI images to standard space to avoid nonlinear registration errors.
•	Before running the Step 2 script, refer to filearchsetup.sh (what the script it iteratively looping through) and ensure your file directories are accurate for your computer. You will need the file paths to your BIDS directory, raw DWI output, raw NODDI output, where you want TBSS output to be stored (and, ultimately, establish the file architecture necessary for TBSS), and the file path at which these .sh files are saved.
•	Step 2 should only need to be run once, ever. Can be run with or without SBATCH; takes 10min to run.

III. The third script to run is Step3_RunTBSS_Pt1.sh. This should be run once your determine your output directory, named out_dir_DTI herein, is compliant with TBSS file architecture. You only need to change the file directory to your TBSS output location. This command does some final touch-ups on the DTI-fit FA data and then runs tbss_1_preproc which is part of FSL version 6.0.7.4; takes a few seconds to run.

IV. The fourth script to run is Step4_RunTBSS_Pt2.sh. This performs the second step of the TBSS processing pipeline on the FA data, tbss_2_reg -T, which applies nonlinear registration to all of the FA images. You only need to change the file directory to your TBSS output location.
•	This step can be the source of wonky/unacceptable output. This should be resolved by steps taken in part II but ensure to visually check your output using fsleyes before continuing. Takes 15-30 minutes to run.

V. The fifth script to run is Step5_RunTBSS_Pt3.sh. This performs the third step of the TBSS processing pipeline on the FA data, tbss_3_postreg -T, which creates the mean FA and skeletonized images. You only need to change the file directory to your TBSS output location.
•	This step can be the source of wonky/unacceptable output. This should be resolved by steps taken in part II but ensure to visually check your output using fsleyes before continuing. Takes 5 minutes to run.

VI. The sixth script to run is Step6_RunTBSS_Pt4.sh. This performs the fourth and final step of the TBSS processing pipeline on the FA data, tbss_4_prestats 0.2, which simply thresholds the skeletonized images as is standard in the field. You only need to change the file directory to your TBSS output location. Should run within a few seconds.

VII. The seventh script to run is Step7_RunTBSS_nonFA.sh. This performs the aforementioned TBSS commands on non-FA data (i.e., MD, AD, RD, NDI, ODI), which requires the output from TBSS run on FA data. You only need to change the file directory to your TBSS output location, as well as the file directory pointing to your BIDS folder.
•	In order for this to run successfully, you will firstly need to migrate all files within ~/FA/stats to an stats folder at the same level of your FA, MD, etc. folders as is required for tbss_non_FA. This function will then be run at the level of your out_DTI_dir variable.
•	This script takes 45 minutes to an hour to run with a parallel processing setup. Ensure to visually check all output files named “all_{metric}_skeletonised.nii.gz” for errors.

VIII. The eighth script to run is Step8_DesignMatCon.Rmd. This is a preparatory step for FSL’s randomise, wherein this generates the basic architecture for the GLM setup (i.e., specific files that will make it easier just to copy and paste into the GLM setup GUI than manually enter). You will need origdata_list.txt, which is simply a list of all the subjects by ID number, as well as final_data.txt, which includes all subjects’ demographic and psychometrics information, both in an easily-accessible file location defined on line 24 of chunk I.
•	Chunk I is run first, which loads these data files and performs minor data wrangling.
•	Chunk II is run second, which produces the .mat and .con files needed for GLM setup.
•	This script should run within a few seconds.


IX. The ninth step/script is the GLM setup in preparation for FSL’s randomise. This step is easier to perform using FSL’s GUI as it will automatically format the contrast files appropriately for randomise. Alternatively, there is a Text2Vest function that does similar, but it is not as surefire as this approach, detailed below:
•	Run the FSL GUI by simply typing and entering fsl in your terminal command window.
•	Select Misc in the bottom lefthand corner, which gives a dropdown box wherein you need to select GLM Setup.
•	It first prompts you to select the number of Inputs, or the sample size (in our case N = 58). Then, it opens a pane as seen to the right, and on the EVs tab, select 8 main EVs and 0 voxel-dependent EVs. Naming of each EV is not required but helpful, which has been done in the picture provided.
•	Within this pane on the upper lefthand side, there is a Paste button. Click, and therein, copy and paste all content from the design_mat.txt file produced in Step VIII.
•	Navigate to the Contrasts & F-tests pane and fill in the contrasts as seen to the left. Instead of manually selecting each number, you may choose to select the Paste button and copy and paste content from the design_con.txt file produced in Step VII.
•	Save these files with the base name “2x2_ancova_design”. If you choose a different name, know you will have to briefly modify the following script.

X. The tenth script to run is Step10_Randomise.sh. This script performs FSL’s randomise, which essentially conducts thousands of permutation tests with threshold-free cluster enhancement to garner a robust snapshot of differences between groups (i.e., AUD and social drinkers in the context of this manuscript). You only need to specify the directory at which your FA-based TBSS output is (i.e., the all_FA.nii.gz, mean_FA.nii.gz files from Steps V-VI) and the directory at which you want the randomise output stored.
•	Takes about 12-16 hours to run with parallel processing (part of the script already).

XI. The eleventh script to run is Step11_ROIMeans.sh, which creates averaged metric values per subject as well as generates cluster-wise averages which are featured in select tables in the manuscript. Herein, you only need to specify the directory at which your randomise output is stored; output from this step (for Figure 1D-F) is stored at CORRP_MASKS folder therein.
•	This script should take about one hour to run given use of fslmeants and cluster.


XII. The twelfth and final script to run is Step12_StatisticalAnalysis.Rmd. The first thing to do is save the output from Step XI at the same location as specified on line 24 of this script. Thereafter the first chunk simply loads in all necessary data and libraries similar to the Step 8 script.
•	Chunk II provides the descriptive and inferential statistics necessary to fill tables 1 and 2.
•	Chunk III provides the descriptive and inferential statistic necessary to fill table 3, as well as the charts shown in Figure 1 panel, D-F.
•	In its entirety, this script should run within 30-45 seconds.
![image](https://github.com/user-attachments/assets/c5663814-1f6e-45f9-9470-ed159f675fbf)
