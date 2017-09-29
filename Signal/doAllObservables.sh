DIR_IA="root://t3dcachedb.psi.ch:1094///pnfs/psi.ch/cms/trivcat/store/user/vtavolar/Differentials_ntuples/July_tightPuJetId/IA/"
DIR_OA="root://t3dcachedb.psi.ch:1094///pnfs/psi.ch/cms/trivcat/store/user/vtavolar/Differentials_ntuples/July_tightPuJetId/OA/"
DIR_DATA="root://t3dcachedb.psi.ch:1094///pnfs/psi.ch/cms/trivcat/store/user/vtavolar/Differentials_ntuples/July_tightPuJetId/data/"

SIGMODOPT="--useFtest "

bash reduceAndFit.sh --obs="Jet4p7AbsRapidity1" --ext="Jet4p7AbsRapidity1_tightJetPuId_test" --dirIA=${DIR_IA} --dirOA=${DIR_OA} --dirData=${DIR_DATA} --refTagDiff="recoJet4p7AbsRapidity1_m1000p0_0p0_SigmaMpTTag_1"  --refTagWV="recoJet4p7AbsRapidity1_m1000p0_0p0_SigmaMpTTag_1"  --refProcWV="InsideAcceptance_genJet4p7AbsRapidity1_m1000p0_0p0" --refProcDiff="InsideAcceptance_genJet4p7AbsRapidity1_m1000p0_0p0" --refProc="InsideAcceptance_genJet4p7AbsRapidity1_m1000p0_0p0" --skipSplit --sigModOpt="${SIGMODOPT}" ##"[1,-1.0,3.0]" 