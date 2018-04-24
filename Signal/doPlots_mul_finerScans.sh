OBS="Pt"
EXT="PtNNLOPS_newBins"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np300.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np300_ub_freezeNuis.txt --logy  -V ${OBS} --resizeLast 450.0 --spectrum 

OBS="AbsRapidity"
EXT="AbsRapidityNNLOPS_newBins"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np200.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np200_ub_freezeNuis.txt --logy -V ${OBS}  --resizeLast 2.5  --spectrum 


OBS="CosThetaStar"
EXT="CosThetaStarNNLOPS"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np200.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np200_ub_freezeNuis.txt -V ${OBS} --spectrum


OBS="MET"
EXT="METNNLOPS_newBins_v2"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np500.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np500_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 250.0 --spectrum 

OBS="NjetsBflavorTight2p5"
EXT="NjetsBflavorTight2p5NNLOPS"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np700.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np700_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum 

OBS="Nleptons"
EXT="NleptonsNNLOPS"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np700.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np700_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 2.5 --spectrum 


OBS="Njets2p5"
EXT="Njets2p5NNLOPS"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np400.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np400_ub_freezeNuis.txt  --logy -V ${OBS} --resizeLast 4.5 --spectrum 


OBS="Jet2p5Pt0"
EXT="Jet2p5Pt0NNLOPS_newBins"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np450.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np450_ub_freezeNuis.txt  --hideFirstBin --logy -V ${OBS}  --resizeFirst -30.0 --resizeLast 300.0 --skipFirstInMean --spectrum

OBS="Jet2p5AbsRapidity0"
EXT="Jet2p5AbsRapidity0NNLOPS_newBins"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np20.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np20_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum


OBS="AbsDeltaPhiGgJet0Eta2p5"
EXT="AbsDeltaPhiGgJet0Eta2p5NNLOPS_newBins"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np200.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np200_ub_freezeNuis.txt  --hideFirstBin  --logy -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum


OBS="AbsDeltaRapidityGgJet0Eta2p5"
EXT="AbsDeltaRapidityGgJet0Eta2p5NNLOPS"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np200.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np200_ub_freezeNuis.txt  --hideFirstBin   -V ${OBS} --resizeFirst -1 --resizeLast 2.5 --skipFirstInMean --spectrum 


OBS="Jet4p7Pt1"
EXT="Jet4p7Pt1NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np400.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np400_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum


OBS="Jet4p7AbsRapidity1"
EXT="Jet4p7AbsRapidity1NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5 --skipFirstInMean --spectrum


OBS="AbsDeltaPhiJjEta4p7"
EXT="AbsDeltaPhiJjEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np300.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np300_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum


OBS="AbsDeltaPhiGgJjEta4p7"
EXT="AbsDeltaPhiGgJjEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np400.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np400_ub_freezeNuis.txt --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum


OBS="ZeppenfeldEta4p7"
EXT="ZeppenfeldEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np40.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 2.0 --skipFirstInMean --spectrum


OBS="MjjEta4p7"
EXT="MjjEta4p7NNLOPS_newBins_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np400.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np400_ub_freezeNuis.txt --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 1200.0 --skipFirstInMean --spectrum


OBS="AbsDeltaEtaJJEta4p7"
EXT="AbsDeltaEtaJJEta4p7NNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np300.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np300_ub_freezeNuis.txt  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 5.0 --skipFirstInMean --spectrum 


OBS="Jet4p7Pt1VBFlike"
EXT="Jet4p7Pt1VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np700.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np700_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --resizeLast 130 --skipFirstInMean --spectrum


OBS="AbsDeltaPhiJjEta4p7VBFlike"
EXT="AbsDeltaPhiJjEta4p7VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --hideFirstBin  -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum


OBS="AbsDeltaPhiGgJjEta4p7VBFlike"
EXT="AbsDeltaPhiGgJjEta4p7VBFlikeNNLOPS_tightJetPuId"
python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np70.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np70_ub_freezeNuis.txt  --logy  --hideFirstBin -V ${OBS} --resizeFirst -1 --skipFirstInMean --spectrum


##!!##  OBS="PtNjets2p5"
##!!##  EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np60.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np60_ub_freezeNuis.txt  --logy -V ${OBS} --spectrum  


##!!##OBS="PtNjets2p5_0"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --outdir plots_mus
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_0j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_0j.txt -V ${OBS}  --logy   --resizeLast 100 --spectrum
##!!##
##!!##
##!!##OBS="PtNjets2p5_1"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --outdir plots_mus
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_1j.txt -V ${OBS}  --logy   --resizeLast 200 --spectrum
##!!##
##!!##
##!!##OBS="PtNjets2p5_1plus"
##!!##EXT="PtNjets2p5NNLOPS_newBins_v2"
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --spectrum --outdir m125_${EXT}
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --outdir plots_mus
##!!##python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_g1j.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np40_freezeNuis_g1j.txt -V ${OBS}  --logy   --resizeLast 400 --spectrum
##!!##




##!!##  OBS="1LeptonHighMET"
##!!##  EXT="1LeptonHighMETNNLOPS"
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
##!!##  #mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##!!##  #cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##!!##  
##!!##  OBS="1LeptonLowMET"
##!!##  EXT="1LeptonLowMETNNLOPS"
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np50.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np50_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
##!!##  #mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##!!##  #cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##!!##  
##!!##  OBS="1Lepton1Bjet"
##!!##  EXT="1Lepton1BjetNNLOPS"
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum --outdir m125_${EXT}
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0  --outdir plots_mus
##!!##  python plotMusFromTxt_mul.py  --outdir plots_mul_finerScans --files /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_ub_np35.txt --filesFreezeNuis /mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/Plots/FinalResults/expectedPrecision_differential_${EXT}_np35_ub_freezeNuis.txt  --logy -V ${OBS} --resizeFirst -1.0 --spectrum 
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir m125_${EXT}/
##!!##  #python makeResponseMatrix.py -V ${OBS} --files  m125_${EXT}/reduced${OBS}IA_gen${OBS}_nominal.root   --logz --outdir plots/
##!!##  #mkdir /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}
##!!##  #cp ../Background/outdir_differential_${EXT}/bkgfTest-Data/multipdf_reco${OBS}_* /afs/cern.ch/user/v/vtavolar/www/DiffHggPt/outdir_Differential_SignalModel_ICHEPconditions_1bis_newphp/afterMoriond17/Background/${EXT}

