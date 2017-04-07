THEDIR=$1
TOSKIP=$2
THESCRIPT=$3
THEDATACARD=$4
THEPATTERN=$5

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
#cmsenv

bash $THESCRIPT $TOSKIP

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
DIR=$THEDIR

mkdir -p /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR
#cp Datacard_13TeV_differential_pT_moriond17_reminiaod_extrabin.txt CMS-HGG_*pT_moriond17_reminiaod_extrabin*root /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR
cp $THEDATACARD CMS-HGG_*$THEPATTERN*root /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR

cd /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
#cmsenv

bash multi_signal_model_fidxsec.sh $DIR $THEDATACARD | tee out_${DIR}.log

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scramv1 runtime -sh`
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np10.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${DIR}_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np10.MultiDimFit.mH125.root --scalex 73.8 --xlab "#sigma_{fid} [fb]" --mu --muExpr "r0" -o scanFidXsec_${DIR}_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np40.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${DIR}_40p_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np40.MultiDimFit.mH125.root --scalex 73.8 --xlab "#sigma_{fid} [fb]" --mu --muExpr "r0" -o scanFidXsec_${DIR}_40p_r0

mkdir -p /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${DIR}
cp scan*${DIR}* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${DIR}