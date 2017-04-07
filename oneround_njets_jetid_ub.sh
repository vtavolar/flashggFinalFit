THEDIR=$1
TOSKIP=$2
THESCRIPT=$3
THEDATACARD=$4
THEPATTERN=$5

#cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scramv1 runtime -sh`
#
#
#bash $THESCRIPT $TOSKIP
#
#cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
DIR=$THEDIR
#
#mkdir -p /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR
#cp $THEDATACARD CMS-HGG_*$THEPATTERN*root /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR
#
#cd /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scramv1 runtime -sh`
#
#bash multi_signal_model_njets_jetid.sh $DIR $THEDATACARD | tee out_${DIR}.log

NAME="NJets_svnUb_v5"

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_r0
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_${NAME}_r1
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_${NAME}_r2 --xaxis "-1.0,2.0"
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_${NAME}_r3 --xaxis "-0.5,4.5"
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_${NAME}_r4 --xaxis "0.5,3.5"

python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np50.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_50p_${NAME}_r0 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_np50.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_50p_${NAME}_r1 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_np50.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_50p_${NAME}_r2 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_np50.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_50p_${NAME}_r3 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_np50.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_50p_${NAME}_r4 --xaxis "-1.5,5.5"

higgsCombiner0_ub_freezeNuis_np50.MultiDimFit.mH120.root
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_freezeNuis_np50.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_freezeNuis_50p_${NAME}_r0 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_freezeNuis_np50.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_freezeNuis_50p_${NAME}_r1 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_freezeNuis_np50.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_freezeNuis_50p_${NAME}_r2 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_freezeNuis_np50.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_freezeNuis_50p_${NAME}_r3 --xaxis "-1.5,5.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_freezeNuis_np50.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_freezeNuis_50p_${NAME}_r4 --xaxis "-1.5,5.5"


mkdir -p /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}
cp scan*${NAME}* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}