import os
from os import system
import sys

observables={}
observables["pt"]=dict(nbins=8,
                       binsmap=[".*/InsideAcceptance_genPt_0p0to15p0:r0[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_15p0to30p0:r1[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_30p0to45p0:r2[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_45p0to85p0:r3[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_85p0to125p0:r4[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_125p0to200p0:r5[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_200p0to350p0:r6[1,-2,2.4]",
                                ".*/InsideAcceptance_genPt_350p0to10000p0:r7[1,-2,2.4]"],
                       BFname="pT_bestfit",
                       npoints=10
                       )

observables["njets"]=dict(nbins=5,
                       binsmap=[".*/InsideAcceptance_myGenNjets2p5_m0p5to0p5:r0[1,-1.5,5.5]", 
                                ".*/InsideAcceptance_myGenNjets2p5_0p5to1p5:r1[1,-1.5,5.5]",
                                ".*/InsideAcceptance_myGenNjets2p5_1p5to2p5:r2[1,-1.5,5.5]",
                                ".*/InsideAcceptance_myGenNjets2p5_2p5to3p5:r3[1,-1.5,5.5]",
                                ".*/InsideAcceptance_myGenNjets2p5_3p5to100p0:r4[1,-1.5,5.5]"],
                       BFname="njets_bestfit",
                       npoints=10
                       )


obs=sys.argv[1]
directory=sys.argv[2]
datacard=sys.argv[3]
pattern=sys.argv[4]

datacardRoot=datacard.replace(".txt",".root")
dcpostfit=datacard.replace(".txt","_post_asimov_fit.root")

print directory
print datacard
print datacardRoot
print dcpostfit

os.system("mkdir -p "+str(directory))
#os.system("cp ../Plots/FinalResults/"+str(datacard)+" ../Plots/FinalResults/CMS-HGG_*"+str(pattern)+"*root "+str(directory) )
os.chdir(str(directory))

#os.system(" rm CMS-HGG_sigfit_"+str(pattern)+".root")
#os.system("../mergeWorkspaces.py CMS-HGG_sigfit_"+str(pattern)+".root CMS-HGG_sigfit_"+str(pattern)+"_*root")
#print "sed -i 's/CMS-HGG_sigfit_"+str(pattern)+"_.*root/CMS-HGG_sigfit_"+str(pattern)+".root/' "+str(datacard)
#os.system("sed -i 's/CMS-HGG_sigfit_"+str(pattern)+"_*root/CMS-HGG_sigfit_"+str(pattern)+".root/' "+str(datacard))


print "CURRENT FOLDER"
os.system("pwd")

#obs="pt"
binmap=""
##binmap="--PO 'map="
for binm in observables[obs]["binsmap"]:
    binmap = str(binmap) + "--PO 'map="+str(binm)+"' "
##    binmap = str(binmap) + str(binm)+","
##binmap = binmap+"'"

print binmap


print "text2workspace.py -P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel  --verbose=1 "+str(binmap)+" --PO 'higgsMassRange=123,127'  -o  "+str(datacardRoot)+" "+str(datacard)
os.system( "text2workspace.py -P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel  --verbose=1 "+str(binmap)+" --PO 'higgsMassRange=123,127'  -o  "+str(datacardRoot)+" "+str(datacard) )

 
initialRs=""
for ir in range(int(observables[str(obs)]['nbins'])):
    initialRs=initialRs + "r" + str(ir)+"=1,"
initialRs.rstrip(",")
if initialRs.endswith(","):
    initialRs = initialRs[:-1]
print initialRs

#os.system("combine -M MultiDimFit  --saveWorkspace -n "+str(observables[str(obs)]['BFname'])+" --setPhysicsModelParameters "+str(initialRs)+" -m 125 --minimizerStrategy 2 "+str(datacardRoot)) 

os.chdir("..")

fitcommand=""
fitcommand="bash fit_bins_ub.sh "+str(directory)+" higgsCombine"+str(observables[str(obs)]['BFname'])+".MultiDimFit.mH125.root 0 "+str(observables[str(obs)]['nbins']-1)+" "+str(observables[str(obs)]['npoints'])

print fitcommand

#os.system(fitcommand)


grepline="grep 'best fit' "
for ib in range(observables[str(obs)]['nbins']):
    print "python makeCombinePlots.py  -b -f "+str(directory)+"/higgsCombiner"+str(ib)+"_ub_np"+str(observables[str(obs)]['npoints'])+".MultiDimFit.mH120.root --mu --muExpr 'r"+str(ib)+"' -o "+str(directory)+"/scan_"+str(pattern)+"_r"+str(ib)+" | tee "+str(directory)+"/scan_"+str(pattern)+"_r"+str(ib)+".log" 
    os.system(  "python makeCombinePlots.py  -b -f "+str(directory)+"/higgsCombiner"+str(ib)+"_ub_np"+str(observables[str(obs)]['npoints'])+".MultiDimFit.mH120.root --mu --muExpr 'r"+str(ib)+"' -o "+str(directory)+"/scan_"+str(pattern)+"_r"+str(ib)+" | tee "+str(directory)+"/scan_"+str(pattern)+"_r"+str(ib)+".log"  )
    grepline = grepline+str(directory)+"/scan_"+str(pattern)+"_r"+str(ib)+".log "
grepline = grepline + " >> "+str(directory)+"/best_fit_"+str(obs)+".txt"
os.system(grepline)

