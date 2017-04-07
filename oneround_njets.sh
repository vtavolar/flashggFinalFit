THEDIR=$1
TOSKIP=$2
THESCRIPT=$3
THEDATACARD=$4
THEPATTERN=$5

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`


###bash $THESCRIPT $TOSKIP

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
DIR=$THEDIR

mkdir -p /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR
cp $THEDATACARD CMS-HGG_*$THEPATTERN*root /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR

cd /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`

bash multi_signal_model.sh $DIR $THEDATACARD | tee out_${DIR}.log

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np10.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${DIR}_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_np10.MultiDimFit.mH125.root --mu --muExpr "r1" -o scan_${DIR}_r1
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_np10.MultiDimFit.mH125.root --mu --muExpr "r2" -o scan_${DIR}_r2
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_np10.MultiDimFit.mH125.root --mu --muExpr "r3" -o scan_${DIR}_r3 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_np10.MultiDimFit.mH125.root --mu --muExpr "r4" -o scan_${DIR}_r4 --xaxis "-0.5,2.5"

python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np20.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${DIR}_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_np20.MultiDimFit.mH125.root --mu --muExpr "r1" -o scan_${DIR}_r1
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_np20.MultiDimFit.mH125.root --mu --muExpr "r2" -o scan_${DIR}_r2
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_np20.MultiDimFit.mH125.root --mu --muExpr "r3" -o scan_${DIR}_r3 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_np20.MultiDimFit.mH125.root --mu --muExpr "r4" -o scan_${DIR}_r4 --xaxis "-0.5,2.5"

#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np40.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${DIR}_40p_r0
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_np40.MultiDimFit.mH125.root --mu --muExpr "r1" -o scan_${DIR}_40p_r1
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_np40.MultiDimFit.mH125.root --mu --muExpr "r2" -o scan_${DIR}_40p_r2
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_np40.MultiDimFit.mH125.root --mu --muExpr "r3" -o scan_${DIR}_40p_r3
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_np40.MultiDimFit.mH125.root --mu --muExpr "r4" -o scan_${DIR}_40p_r4

mkdir -p /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${DIR}
cp scan*${DIR}* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${DIR}