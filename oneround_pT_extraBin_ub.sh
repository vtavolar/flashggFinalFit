THEDIR=$1
TOSKIP=$2
THESCRIPT=$3
THEDATACARD=$4
THEPATTERN=$5


DIR=$THEDIR

NAME="pT_svnUb_v5"

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scramv1 runtime -sh`
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_np10.MultiDimFit.mH125.root --mu --muExpr "r0" -o scan_${NAME}_r0
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_np10.MultiDimFit.mH125.root --mu --muExpr "r1" -o scan_${NAME}_r1
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_np10.MultiDimFit.mH125.root --mu --muExpr "r2" -o scan_${NAME}_r2
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_np10.MultiDimFit.mH125.root --mu --muExpr "r3" -o scan_${NAME}_r3
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_np10.MultiDimFit.mH125.root --mu --muExpr "r4" -o scan_${NAME}_r4
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner5_np10.MultiDimFit.mH125.root --mu --muExpr "r5" -o scan_${NAME}_r5
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner6_np10.MultiDimFit.mH125.root --mu --muExpr "r6" -o scan_${NAME}_r6
#python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner7_np10.MultiDimFit.mH125.root --mu --muExpr "r7" -o scan_${NAME}_r7


##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_r0
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_${NAME}_r1
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_${NAME}_r2
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_${NAME}_r3
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_${NAME}_r4
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner5_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r5" -o scan_${NAME}_r5
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner6_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r6" -o scan_${NAME}_r6
##python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner7_ub_np20.MultiDimFit.mH120.root --mu --muExpr "r7" -o scan_${NAME}_r7


###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_30p_r0 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_${NAME}_30p_r1 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_${NAME}_30p_r2 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_${NAME}_30p_r3 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_${NAME}_30p_r4 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner5_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r5" -o scan_${NAME}_30p_r5 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner6_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r6" -o scan_${NAME}_30p_r6 --xaxis "-0.5,2.5"
###python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner7_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r7" -o scan_${NAME}_30p_r7 --xaxis "-0.5,2.5"

python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_freezeNuis_30p_r0 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_${NAME}_freezeNuis_30p_r1 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_${NAME}_freezeNuis_30p_r2 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_${NAME}_freezeNuis_30p_r3 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_${NAME}_freezeNuis_30p_r4 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner5_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r5" -o scan_${NAME}_freezeNuis_30p_r5 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner6_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r6" -o scan_${NAME}_freezeNuis_30p_r6 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner7_ub_freezeNuis_np30.MultiDimFit.mH120.root --mu --muExpr "r7" -o scan_${NAME}_freezeNuis_30p_r7 --xaxis "-0.5,2.5"


python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_30p_r0 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner1_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r1" -o scan_${NAME}_30p_r1 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner2_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r2" -o scan_${NAME}_30p_r2 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner3_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r3" -o scan_${NAME}_30p_r3 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner4_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r4" -o scan_${NAME}_30p_r4 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner5_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r5" -o scan_${NAME}_30p_r5 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner6_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r6" -o scan_${NAME}_30p_r6 --xaxis "-0.5,2.5"
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner7_ub_np30.MultiDimFit.mH120.root --mu --muExpr "r7" -o scan_${NAME}_30p_r7 --xaxis "-0.5,2.5"


mkdir -p /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}
cp scan*${NAME}* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}