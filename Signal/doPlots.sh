OBS="Pt"
EXT="PtNNLOPS_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt --logy  -V ${OBS} --resizeLast 450.0 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt --logy  -V ${OBS} --resizeLast 450.0  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt --logy  -V ${OBS} --resizeLast 450.0 --spectrum 
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsRapidity"
EXT="AbsRapidityNNLOPS_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS}  --resizeLast 2.5  --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS}  --resizeLast 2.5  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS}  --resizeLast 2.5  --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1.2 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1.2 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="CosThetaStar"
EXT="CosThetaStarNNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS} --spectrum  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS}  --outdir plots_mus  
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt -V ${OBS} --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="MET"
EXT="METNNLOPS_newBins_v2"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 250.0 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 250.0  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 250.0 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="NjetsBflavorTight2p5"
EXT="NjetsBflavorTight2p5NNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="Nleptons"
EXT="NleptonsNNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="1LeptonHighMET"
EXT="1LeptonHighMETNNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="1LeptonLowMET"
EXT="1LeptonLowMETNNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="1Lepton1Bjet"
EXT="1Lepton1BjetNNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}



OBS="Njets2p5"
EXT="Njets2p5NNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 4.5 --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 4.5  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 4.5 --spectrum 
##mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}




OBS="Jet2p5Pt0"
EXT="Jet2p5Pt0NNLOPS_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np45.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np45_ub_freezeNuis.txt  --hideFirstBin --logy -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np45.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np45_ub_freezeNuis.txt  --hideFirstBin --logy -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np45.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np45_ub_freezeNuis.txt  --hideFirstBin --logy -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 300  --resizeFirst -30 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 300  --resizeFirst -30 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="Jet2p5AbsRapidity0"
EXT="Jet2p5AbsRapidity0NNLOPS_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="AbsDeltaPhiGgJet0Eta2p5"
EXT="AbsDeltaPhiGgJet0Eta2p5NNLOPS_newBins"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaRapidityGgJet0Eta2p5"
EXT="AbsDeltaRapidityGgJet0Eta2p5NNLOPS"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean  --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2.5  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2.5  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="Jet4p7Pt1"
EXT="Jet4p7Pt1NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="Jet4p7AbsRapidity1"
EXT="Jet4p7AbsRapidity1NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaPhiJjEta4p7"
EXT="AbsDeltaPhiJjEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaPhiGgJjEta4p7"
EXT="AbsDeltaPhiGgJjEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="ZeppenfeldEta4p7"
EXT="ZeppenfeldEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 2.0 --skipFirstInMean --spectrum  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 2.0 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 2.0 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 2  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="MjjEta4p7"
EXT="MjjEta4p7NNLOPS_newBins_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1200  --resizeFirst -10 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 1200  --resizeFirst -10 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaEtaJJEta4p7"
EXT="AbsDeltaEtaJJEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np30.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np30_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean --spectrum 
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 5  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


OBS="Jet4p7Pt1VBFlike"
EXT="Jet4p7Pt1VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --resizeLast 130  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaPhiJjEta4p7VBFlike"
EXT="AbsDeltaPhiJjEta4p7VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

OBS="AbsDeltaPhiGgJjEta4p7VBFlike"
EXT="AbsDeltaPhiGgJjEta4p7VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir m125_${EXT}/
#python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --resizeFirst -1 --outdir plots/
#mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
#cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}






OBS="PtNjets2p5"
EXT="PtNjets2p5NNLOPS_newBins_v2"
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np60.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np60_ub_freezeNuis.txt  --logy -V ${OBS} --spectrum  --outdir m125_${EXT}
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np60.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np60_ub_freezeNuis.txt  --logy -V ${OBS} --outdir plots_mus
python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np60.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np60_ub_freezeNuis.txt  --logy -V ${OBS} --spectrum  

##python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --outdir m125_${EXT}/
##python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz  --outdir plots/
##mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}


##!!##OBS="PtNjets2p5_0"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --outdir plots_mus
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --spectrum
##!!##
##!!##
##!!##OBS="PtNjets2p5_1"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --outdir plots_mus
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --spectrum
##!!##
##!!##
##!!##OBS="PtNjets2p5_1plus"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --outdir plots_mus
##!!##python plotMusFromTxt.py --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --spectrum
##!!##



