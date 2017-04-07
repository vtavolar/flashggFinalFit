THEDIR=$1
TOSKIP=$2
THESCRIPT=$3
THEDATACARD=$4
THEPATTERN=$5

DIR=$THEDIR

NAME=fidXs_svnUb_v5

cd /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scramv1 runtime -sh`

python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np40.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_40p_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_np40.MultiDimFit.mH120.root --scalex 69.5 --xlab "#sigma_{fid} (fb)" --ylab "#Delta q" --mu --muExpr "r0" -o scanFidXsec_${NAME}_40p_r0 -x 68,100 -y 0,2.5

python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_freezeNuis_np40.MultiDimFit.mH120.root --mu --muExpr "r0" -o scan_${NAME}_freezeNuis_40p_r0
python makeCombinePlots.py  -b -f /mnt/t3nfs01/data01/shome/vtavolar/combine74/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/$DIR/higgsCombiner0_ub_freezeNuis_np40.MultiDimFit.mH120.root --scalex 69.5 --xlab "#sigma_{fid} [fb]" --mu --muExpr "r0" -o scanFidXsec_${NAME}_freezeNuis_40p_r0

mkdir -p /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}
cp scan*${NAME}* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/Moriond17/outdir_${NAME}