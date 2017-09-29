OBS="CosThetaStar"
EXT="CosThetaStar"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}   --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}   
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsRapidity"
EXT="AbsRapidity_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}  --resizeLast 1.2   --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}  --resizeLast 1.2   
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1.2 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1.2 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}



OBS="Jet2p5Pt0"
EXT="Jet2p5Pt0"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean 
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 300  --resizeFirst -30 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 300  --resizeFirst -30 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="Jet2p5AbsRapidity0"
EXT="Jet2p5AbsRapidity0_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

EXT="AbsDeltaPhiGgJet0Eta2p5"
OBS="AbsDeltaPhiGgJet0Eta2p5"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --outdir m125_${EXT}
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsDeltaRapidityGgJet0Eta2p5"
EXT="AbsDeltaRapidityGgJet0Eta2p5"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean  
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2.5  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2.5  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="Jet4p7Pt1"
EXT="Jet4p7Pt1_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsDeltaPhiGgJjEta4p7"
EXT="AbsDeltaPhiGgJjEta4p7_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1  --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsDeltaPhiJjEta4p7"
EXT="AbsDeltaPhiJjEta4p7_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="ZeppenfeldEta4p7"
EXT="ZeppenfeldEta4p7_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 2.0 --skipFirstInMean   --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 2.0  --skipFirstInMean 
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsDeltaEtaJJEta4p7"
EXT="AbsDeltaEtaJJEta4p7_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean  
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="MjjEta4p7"
EXT="MjjEta4p7_newBins_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1200  --resizeFirst -10 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1200  --resizeFirst -10 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="Jet4p7AbsRapidity1"
EXT="Jet4p7AbsRapidity1_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="AbsDeltaPhiGgJjEta4p7VBFlike"
EXT="AbsDeltaPhiGgJjEta4p7VBFlike_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1  --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="AbsDeltaPhiJjEta4p7VBFlike"
EXT="AbsDeltaPhiJjEta4p7VBFlike_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
OBS="Jet4p7Pt1VBFlike"
EXT="Jet4p7Pt1VBFlike_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir m125_${EXT}/
python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir plots/
mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}



#OBS="PtNjets2p5"
#EXT="PtNjets2p5_newBins"
#python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}   
#python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20.txt -V ${OBS}   --outdir m125_${EXT}
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="PtNjets2p5_0"
EXT="PtNjets2p5_newBins"
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_0j.txt -V ${OBS}   --resizeLast 100
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_0j.txt -V ${OBS}   --resizeLast 100  --outdir m125_${EXT}

OBS="PtNjets2p5_1"
EXT="PtNjets2p5_newBins"
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_1j.txt -V ${OBS}   --resizeLast 200
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_1j.txt -V ${OBS}   --resizeLast 200 --outdir m125_${EXT}

OBS="PtNjets2p5_1plus"
EXT="PtNjets2p5_newBins"
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_1j.txt -V ${OBS}   --resizeLast 400
python plotMusFromTxt.py --files expectedPrecision_differential_${EXT}_np20_1j.txt -V ${OBS}   --resizeLast 400 --outdir m125_${EXT}



