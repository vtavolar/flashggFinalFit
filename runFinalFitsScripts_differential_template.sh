#!/bin/bash
##These are the files we will use for the signal and background model building

usage(){
    echo "The script runs background scripts:"
    echo "options:"
    echo "-h|--help)" 
    echo "--obs, observable to run, name in tree)" 
    echo "--ext, extension name for this run)" 
    echo "--inputDir, path to input directory )" 
    echo "--procs, names of processes )" 
    echo "--cats, names of categories )" 
    echo "--range, range for POIs scan )" 
    echo "--shiftOffDiag, correct for bias in off-diag elements when using diag replacement )" 
    echo "--refTagDiff, reference replacement tag for differentials )" 
    echo "--refTagWV, reference replacement tag for WV datasets )" 
    echo "--refProc, reference replacement process )" 
    echo "--refProcDiff, reference replacement process for differentials )" 
    echo "--refProcWV, reference replacement process for WV datasets )" 
    echo "--sigModOpt, more options to be propagated to signal model scripts )" 
    echo "--bkgModOpt, more options to be propagated to bkg model scripts )"     
    echo "--DatacardOpt, more options to be propagated to datacard scripts )"     


}

if ! options=$(getopt -u -o hi:p:f: -l help,obs:,ext:,inputDir:,procs:,cats:,range:,shiftOffDiag:,refTagDiff:,refTagWV:,refProc:,refProcDiff:,refProcWV:,sigModOpt::,bkgModOpt::,DatacardOpt:: -- "$@")
then
# something went wrong, getopt will put out an error message for us
    exit 1
fi
set -- $options

OBS="obs"
EXT="ext"
INPUTPATH="input/path/"
PROCS="ggh"
CATS="cat0"
range="[1,-1.0,3.0]"
SHIFTOFFDIAG=1
REFTAGDIFF="cat0"
REFTAGWV="cat0"
REFPROC="ggh"
REFPROCDIFF="ggh"
REFPROCWV="ggh"
SIGMODOPT=""
BKGMODOPT=""
DATACARDOPT=""

while [ $# -gt 0 ]
do
    case $1 in
	-h|--help) usage; exit 0;;
	--obs) OBS=$2; shift;;
	--ext) EXT=$2; shift;;
	--inputDir) INPUTPATH=$2; shift;;
	--procs) PROCS=$2; shift;;
	--cats) CATS=$2; shift;;
	--range) RANGE=$2; shift;;
	--shiftOffDiag) SHIFTOFFDIAG=$2; shift;;
	--refTagDiff) REFTAGDIFF=$2; shift;;
	--refTagWV) REFTAGWV=$2; shift;;
	--refProc) REFPROC=$2; shift;;
	--refProcDiff) REFPROCDIFF=$2; shift;;
	--refProcWV) REFPROCWV=$2; shift;;
	--sigModOpt) SIGMODOPT=$2; shift;;
	--bkgModOpt) BKGMODOPT=$2; shift;;
	--DatacardOpt) DATACARDOPT=$2; shift;;

	(--) shift; break;;
	(-*) usage; echo "$0: error - unrecognized option $1" 1>&2; usage >> /dev/stderr; exit 1;;
	(*) break;;
    esac
    shift
done




#shortcut for path where the files are stored
###INPUTPATH=/mnt/t3nfs01/data01/shome/vtavolar/FinalFits_74_wip/CMSSW_7_4_7/src/flashggFinalFit/Signal/

#files usef for teh signal model: each process has three mass points 120, 125 and 130 geV.  
FILE=$INPUTPATH/m120_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root,$INPUTPATH/m125_${EXT}/reduced${OBS}IA.root,$INPUTPATH/m130_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root,$INPUTPATH/m120_OA_${EXT}/reduced${OBS}OA__nominal.root,$INPUTPATH/m125_OA_${EXT}/reduced${OBS}OA.root,$INPUTPATH/m130_OA_${EXT}/reduced${OBS}OA__nominal.root

#the real data, for background model and final results
DATA=$INPUTPATH/data_${EXT}/reduced${OBS}Data__nominal.root


#shortcut for just the 125 GeV files.
FILE125=$INPUTPATH/m125_${EXT}/reduced${OBS}IA.root
FILE125_IAOA=$INPUTPATH/m125_${EXT}/reduced${OBS}IAOA.root

#same as $FILE but where the heaviest file (VBF 125) has been reduced. this is simply for memory management puproses.
FILEEFFACC=$INPUTPATH/sig_jobs_fiducial_IAOA_002/m120/allSig120IAOA.root,$INPUTPATH/sig_jobs_fiducial_IAOA_002/m125/allSig125IAOA.root,$INPUTPATH/sig_jobs_fiducial_IAOA_002/m130/allSig130IAOA.root

##define the other options 
#name of this run
EXT=differential_${EXT}

#processes to consider
###PROCS=$3
echo "PROCS"
echo $PROCS

#categories
####CATS=$4


#output dir
OUTDIR=outdir_$EXT
#photon energy scale and smear categories
SCALES="HighR9EB,HighR9EE,LowR9EB,LowR9EE,Gain6EB,Gain1EB"
SMEARS="HighR9EBPhi,HighR9EBRho,HighR9EEPhi,HighR9EERho,LowR9EBPhi,LowR9EBRho,LowR9EEPhi,LowR9EERho"

#amount of data
INTLUMI=35.9
BATCH=T3CH
BS=3.5


if [ $SHIFTOFFDIAG == 1 ]; then
    SIGMODOPT="${SIGMODOPT} --shiftOffDiag"
fi

##signal model preparation
#The first tiem you run this command, it will run the signal f-test to determine the number of gaussians to use for each tag/process. You'll be prompted to use the output of this to fill in the required config file. Then re-run to build the signal model.
##./runFinalFitsScripts.sh -i $FILE -p $PROCS -f $CATS --ext $EXT --batch $BATCH --intLumi $INTLUMI --smears $SMEARS --scales $SCALES --signalOnly --bs 3.5 --shiftOffDiag --refTagDiff $5 --refTagWV $6 --refProcWV $7 --refProcDiff $8 --refProc $9 ## --normalisationCut "processIndex==11"
######./runFinalFitsScripts.sh -i $FILE -p $PROCS -f $CATS --ext $EXT --batch $BATCH --intLumi $INTLUMI --smears $SMEARS --scales $SCALES --signalOnly --bs 3.5 --refTagDiff $REFTAGDIFF --refTagWV $REFTAGWV --refProcWV $REFPROCWV --refProcDiff $REFPROCDIFF --refProc $REFPROC $SIGMODOPT ## --normalisationCut "processIndex==11"

##background model preparations
#by default this produces blinded plots... use option --unblind to unblind.
#############./runFinalFitsScripts.sh -i $FILE -p $PROCS -f $CATS --ext $EXT --intLumi $INTLUMI --backgroundOnly --dataFile $DATA --isData --batch $BATCH $BKGMODOPT ##--noBkgPlots OR --monitorDataPlots
#####./runFinalFitsScripts.sh -i $FILE -p $PROCS -f $CATS --ext $EXT --intLumi $INTLUMI --backgroundOnly --dataFile $DATA --isData --batch $BATCH  --unblind


##making the datacard
# this step generates the datacard using the signal model as input.
./runFinalFitsScripts.sh -i $FILE125_IAOA -p $PROCS -f $CATS --ext $EXT  --intLumi $INTLUMI --datacardOnly --dataFile $DATA --isData --batch $BATCH --datacardDifferential --multiPdf $DATACARDOPT ##--noSysts

MYPWD=${PWD}
cd /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/AfterMoriond17
mkdir ${EXT}
cp ${MYPWD}/Signal/outdir_${EXT}/CMS-HGG_sigfit_${EXT}_*root ${EXT}
cp ${MYPWD}/Background/CMS-HGG_multipdf_${EXT}.root ${EXT}
cp ${MYPWD}/Datacard/Datacard_13TeV_${EXT}.txt ${EXT}
cd ${EXT}
python ../mergeWorkspaces.py  CMS-HGG_sigfit_${EXT}.root CMS-HGG_sigfit_${EXT}_*root
set -x
sed -i "s/CMS-HGG_sigfit_${EXT}_.*root/CMS-HGG_sigfit_${EXT}.root/" Datacard_13TeV_${EXT}.txt
sed -i "s/CMS-HGG_${EXT}_13TeV_multipdf.root/CMS-HGG_multipdf_${EXT}.root/" Datacard_13TeV_${EXT}.txt

POIS=${PROCS%",OutsideAcceptance"}
cd ..
bash multi_signal_model_MjjEta2p5_template.sh ${EXT} Datacard_13TeV_${EXT}.txt ${POIS} ${RANGE} | tee ${EXT}/multi_signal_model.log