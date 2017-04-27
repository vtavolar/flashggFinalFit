#!/usr/bin/env python
# 
# --------------------------------------------
# Standard python import
from optparse import OptionParser, make_option
import fnmatch, glob, os, sys, json, itertools, array
#sys.argv.append( '-b' )

## ------------------------------------------------------------------------------------------------------------------------------------------------------


#from templates_maker import buildRooDataSet
import ROOT
from ROOT import TH2D, TH1D, TFile, TProfile, TCanvas, TGraphAsymmErrors
from ROOT import RooWorkspace
from ROOT import RooAbsData
from ROOT import RooDataSet
from ROOT import *

gSystem.AddIncludePath("$CMSSW_BASE/src/flashggFinalFit/Signal/interface/")

gSystem.Load("/mnt/t3nfs01/data01/shome/vtavolar/FinalFits_74_wip/CMSSW_7_4_7/src/flashggFinalFit/Signal/src/DataSetFiller_vec_cc.so")
#gROOT.ProcessLine('#include "flashgg/Systematics/macros/DataSetFiller.h"')


from ROOT import gROOT
gROOT.ForceStyle()
gStyle.SetOptTitle(0)
gStyle.SetOptStat(0)

class Load:
    def __call__(self,option, opt_str, value, parser, *args, **kwargs):
        if option.dest == "__opts__":
            dest = parser.values
        else:
            dest = getattr(parser.values,option.dest)
        origin = getattr(parser.values,"%s_src" % option.dest,None)
        if origin:
            origin += ",%s" % value
        else:
            origin = value
            setattr(parser.values,"%s_src" % option.dest,origin)

        if type(dest) == dict:
            setter = dict.__setitem__
            getter = dict.get
        else:
            setter = setattr
            getter = getattr
        
        for cfg in value.split(","):
            cf = open(cfg)
            settings = json.loads(cf.read())
            for k,v in settings.iteritems():
                print k,v
                attr  = getter(dest,k,None)
                if attr and type(attr) == list:           
                    attr.extend(v)
                setter(dest,k,v)
            cf.close()



#"variables": [
#        ("genPt","recoPt",[0.0,100.0,200.0,300.0,400.0,500.0,600.0,700.0,10000.0],[0.0,10000.0]), 
#        ("genNjets2p5","recoNjets2p5",[-0.5,0.5,1.5,2.5,3.5,4.5,5.5,6.5,100.0],[]) ],




def getSystLabels():
    phosystlabels=[]
    jetsystlabels=[]
    systlabels=[]
    for direction in ["Up","Down"]:
        phosystlabels.append("MvaShift%s01sigma" % direction)
##        phosystlabels.append("SigmaEOverEShift%s01sigma" % direction)
##        phosystlabels.append("MaterialCentral%s01sigma" % direction)
##        phosystlabels.append("MaterialForward%s01sigma" % direction)
##        phosystlabels.append("FNUFEB%s01sigma" % direction)
##        phosystlabels.append("FNUFEE%s01sigma" % direction)
##        phosystlabels.append("MCScaleGain6EB%s01sigma" % direction)
##        phosystlabels.append("MCScaleGain1EB%s01sigma" % direction)
##        jetsystlabels.append("JEC%s01sigma" % direction)
##        jetsystlabels.append("JER%s01sigma" % direction)
##        jetsystlabels.append("PUJIDShift%s01sigma" % direction)        
##        for r9 in ["HighR9","LowR9"]:
##            for region in ["EB","EE"]:
##                phosystlabels.append("ShowerShape%s%s%s01sigma"%(r9,region,direction))
##                phosystlabels.append("MCScale%s%s%s01sigma" % (r9,region,direction))
##                for var in ["Rho","Phi"]:
##                    phosystlabels.append("MCSmear%s%s%s%s01sigma" % (r9,region,var,direction))
    systlabels += phosystlabels
    systlabels += jetsystlabels
    return systlabels

#variables=[("leadGenPt", "subleadGenPt", [0.,100.,200.,300.,400.,500.,600.,700.,10000.])]
variables=[]
#[["genPt", "recoPt", [0.,100.,200.,300.,400.,500.,600.,700.,10000.],[0.,10000.]], ["genNjets2p5", "recoNjets2p5", [-0.5,0.5,1.5,2.5,3.5,4.5,5.5,6.5,100.],[]] ]
procs=[]
#procs=["InsideAcceptance_130_13TeV"]
cats=[]
#cats=["SigmaMpTTag_0", "SigmaMpTTag_1", "SigmaMpTTag_2"]

import numpy as np

savefmts=['.png','.root','.pdf','.jpg']
# Main routine
def main(o,args):
    variables = options.variables
    procs = options.procs
    cats = options.cats
    print "****variables***"
    print variables
    #from configfile import variables, procs, cats
    if 0 and options.files.startswith("/store"):
        filepath = "root://eoscms/"+str(options.files)
    else:
        filepath = options.files
    print 'filepath is '+str(filepath)
    infile = TFile.Open(filepath)
    infile.Print()
    wspace =  RooWorkspace("cms_hgg_13TeV")
###    tree = infile.Get("tagsDumper/cms_hgg_13TeV")
    wspace.Print()

    variables_0=[]    
    variables_1=[]    
    for ivarset in range(len(variables)):
        isData=False
        varset = variables[ivarset]
        print 'we look at the variable ...'
        print variables[ivarset]
        if not variables[ivarset][-1]:
            variables[ivarset] = (variables[ivarset][0], variables[ivarset][1], variables[ivarset][2], variables[ivarset][2])
        if not variables[ivarset][1]:
            variables[ivarset] = (variables[ivarset][0], variables[ivarset][0], variables[ivarset][2], [1,1])
            isData=True
        variables_0.append(variables[ivarset][0])
        variables_1.append(variables[ivarset][1])

        proc = procs[0]
        cat = cats[0]
        tree = infile.Get( "tagsDumper/trees/"+str(proc)+"_"+str(cat) )
        tree.SetAlias("myGenNjets2p5", "(genJet2p5Numberofdaughters0 > 5) + (genJet2p5Numberofdaughters1 > 5) + (genJet2p5Numberofdaughters2 > 5) + (genJet2p5Numberofdaughters3 > 5) + (genJet2p5Numberofdaughters4 > 5) + (genJet2p5Numberofdaughters5 > 5)")
        varsInTree = []
        branchNames = tree.GetListOfBranches().Clone()
        for i in range( branchNames.GetEntries() ):
            varsInTree.append(branchNames.At(i).GetName())
        print "varsInTree"
        print varsInTree
        #do not dump into ws vars if they are needed only for splitting, or if they are "other" vars not used at the moment (not even for splitting)
        varsToDump = [var for var in varsInTree if (var not in options.othervars and var not in variables_0 and var not in variables_1) ]
        print "varsToDump"
        print varsToDump
        #eliminate duplicates from list
        varsToDump = list(set(varsToDump))
        roorealvars=[]
        rooarglist=RooArgList()
        limitedvars=[]
        rrv0=RooRealVar(varsToDump[0],varsToDump[0],-10.,10.)
        rrv1=RooRealVar(varsToDump[1],varsToDump[1],-10.,10.)
        ras = RooArgSet(rrv0,rrv1)
#        print varsToDump[20]
#        print varsToDump[23]
#        del varsToDump[23]
        
        print "varsToDump before for"
        print varsToDump
        for var in varsToDump:
            print "print them one by one"
            print var
#            val = tree.GetBranch(var).GetEntry(0)
#            print type(val)
##            if type(val) is int:
##                print "skipping var ",var
##                continue
            if var in limitedvars:
                rrv = RooRealVar(str(var),limitedvars[var]["min"],limitedvars[var]["max"])
                roorealvars.append(rrv)
                rooarglist.add(rrv)
            else:
                rrv = RooRealVar(str(var), str(var), -float("inf"), float("inf"))
#                rrv = wspace.factory(str(var)+"[0.]")
                rrv.Print()
#                rrv.SetName(str(var))
#                rrv.SetTitle(str(var))
                roorealvars.append(rrv)
                rooarglist.add(rrv, True)
        datasetsReduced={}
        print roorealvars
        rooarglist.Print()


##        for proc in procs:
##            print "proc ",proc
##            for cat in cats:
##                print "cat ",cat
##                tree = infile.Get( "tagsDumper/trees/"+str(proc)+"_"+str(cat) )
##                tree.SetAlias("myGenNjets2p5", "(genJet2p5Numberofdaughters0 > 5) + (genJet2p5Numberofdaughters1 > 5) + (genJet2p5Numberofdaughters2 > 5) + (genJet2p5Numberofdaughters3 > 5) + (genJet2p5Numberofdaughters4 > 5) + (genJet2p5Numberofdaughters5 > 5)")
##                boundaries = []
##                boundaries.append( variables[ivarset][-2] )
##                boundaries.append( variables[ivarset][-1] )
##                print "root hasattr before"
##                print hasattr(ROOT, "vecBoundaries")
##                if not hasattr(ROOT, "vecBoundaries"):
##                    gROOT.ProcessLine(" std::vector<std::vector<double > >* vecBoundaries = new std::vector<std::vector<double > >() ;")
##                else:
##                    ROOT.vecBoundaries.clear()
##                print "root hasattr after"
##                print hasattr(ROOT, "vecBoundaries")
##                if not hasattr(ROOT, "tempvec"):
##                    gROOT.ProcessLine("std::vector<double >* tempvec = new std::vector<double >() ;")
##                else:
##                    ROOT.tempvec.clear()
##                for b in variables[ivarset][-2]:
##                    ROOT.tempvec.push_back(b)
##                ROOT.vecBoundaries.push_back(tempvec)
##                ROOT.tempvec.clear()
##                for b in variables[ivarset][-1]:
##                    ROOT.tempvec.push_back(b)
##                ROOT.vecBoundaries.push_back(tempvec)
##                filler = DataSetFiller(str(proc), str(cat), rooarglist, "weight", False, True)
##                wei = TCut("weight")
##                if options.cut:
##                    wei *= TCut(str(options.cut))
##                if not hasattr(ROOT, "obsnames"):
##                    gROOT.ProcessLine("std::vector<std::string >* obsnames = new std::vector<std::string >() ;")
##                else:
##                    ROOT.obsnames.clear()
##                ROOT.obsnames.push_back( str( variables[ivarset][0] ) )
##                ROOT.obsnames.push_back( str( variables[ivarset][1] ) )
##                print obsnames
##                filler.setGrid(ROOT.obsnames, vecBoundaries )
##                filler.fillFromTree(tree,wei.GetTitle())
##                if not hasattr(ROOT, "datasets"):
##                    gROOT.ProcessLine("std::vector<RooDataSet* >* datasets = new std::vector<RooDataSet* >() ;")
##                else:
##                    ROOT.datasets.clear()
##                ROOT.datasets = filler.get()
##                for ids in range( ROOT.datasets.size() ):
##                    datasetsReduced[ ROOT.datasets[ids].GetName() ] = ( ROOT.datasets[ids] )

        systlabels = getSystLabels()
        rrv_cms_mass = RooRealVar("CMS_hgg_mass", "CMS_hgg_mass", 100, 180)
        rrv_cms_mass.setBins(160)
        rrv_weight = RooRealVar("weight", "weight", -float("inf"), float("inf"))
        rooarglist_syst=RooArgList(rrv_cms_mass,rrv_weight)
        systlabels.append("")

        if options.label:
            if options.label == "pdfWeights":
                systlabels=[]
            elif options.label == "nominal":
                systlabels=[""]
            else:
                systlabels = [options.label]

        for label in systlabels:
            for proc in procs:
                print "proc ",proc
                for cat in cats:
                    print "cat ",cat
                    if label == "":
                        tree = infile.Get( "tagsDumper/trees/"+str(proc)+"_"+str(cat) )
                    else:
                        tree = infile.Get( "tagsDumper/trees/"+str(proc)+"_"+str(cat)+"_"+str(label) )
                    tree.SetAlias("myGenNjets2p5", "(genJet2p5Numberofdaughters0 > 5) + (genJet2p5Numberofdaughters1 > 5) + (genJet2p5Numberofdaughters2 > 5) + (genJet2p5Numberofdaughters3 > 5) + (genJet2p5Numberofdaughters4 > 5) + (genJet2p5Numberofdaughters5 > 5)")
                    boundaries = []
                    boundaries.append( variables[ivarset][-2] )
                    boundaries.append( variables[ivarset][-1] )
                    print "root hasattr before"
                    print hasattr(ROOT, "vecBoundaries")
                    if not hasattr(ROOT, "vecBoundaries"):
                        gROOT.ProcessLine(" std::vector<std::vector<double > >* vecBoundaries = new std::vector<std::vector<double > >() ;")
                    else:
                        ROOT.vecBoundaries.clear()
                    print "root hasattr after"
                    print hasattr(ROOT, "vecBoundaries")
                    if not hasattr(ROOT, "tempvec"):
                        gROOT.ProcessLine("std::vector<double >* tempvec = new std::vector<double >() ;")
                    else:
                        ROOT.tempvec.clear()
                    for b in variables[ivarset][-2]:
                        ROOT.tempvec.push_back(b)
                    ROOT.vecBoundaries.push_back(tempvec)
                    ROOT.tempvec.clear()
                    for b in variables[ivarset][-1]:
                        ROOT.tempvec.push_back(b)
                    ROOT.vecBoundaries.push_back(tempvec)
                    if label == "":
                        filler = DataSetFiller(str(proc), str(cat), rooarglist, "weight", False, True)
                    else:
                        filler = DataSetFiller(str(proc), str(cat)+"_"+str(label), rooarglist_syst, "weight", False, True)           
                    wei = TCut("weight")
                    if options.cut:
                        wei *= TCut(str(options.cut))
                    if not hasattr(ROOT, "obsnames"):
                        gROOT.ProcessLine("std::vector<std::string >* obsnames = new std::vector<std::string >() ;")
                    else:
                        ROOT.obsnames.clear()
                    ROOT.obsnames.push_back( str( variables[ivarset][0] ) )
                    ROOT.obsnames.push_back( str( variables[ivarset][1] ) )
                    print obsnames
                    filler.setGrid(ROOT.obsnames, vecBoundaries )
                    filler.fillFromTree(tree,wei.GetTitle())
                    if not hasattr(ROOT, "datasets"):
                        gROOT.ProcessLine("std::vector<RooDataSet* >* datasets = new std::vector<RooDataSet* >() ;")
                    else:
                        ROOT.datasets.clear()
                    ROOT.datasets = filler.get()
                    for ids in range( ROOT.datasets.size() ):
                        if label=="":
                            datasetsReduced[ ROOT.datasets[ids].GetName() ] = ( ROOT.datasets[ids] )
                        else:
                            datasetsReduced[ ROOT.datasets[ids].GetName() ] = ( ROOT.datasets[ids] ).binnedClone(str(  ROOT.datasets[ids].GetName()  ))
                            datasetsReduced[ ROOT.datasets[ids].GetName() ].SetTitle( ROOT.datasets[ids].GetName() )





        if options.label == "pdfWeights" or not options.label:
            rrv_pdfWeights={}
            for iw in range(60):
                rrv_pdfw = RooRealVar("pdfWeight_"+str(iw), "weight*pdfWeights["+str(iw)+"]/pdfWeights[0]", -float("inf"), float("inf"))
                rrv_pdfWeights[rrv_pdfw.GetName()] = (rrv_pdfw)
            rooarglist_pdfw=RooArgList(rrv_cms_mass,rrv_weight)
            for irrv in rrv_pdfWeights.values():
                rooarglist_pdfw.add(irrv)
            for proc in procs:
                print "proc ",proc
                for cat in cats:
                    print "cat ",cat
                    tree = infile.Get( "tagsDumper/trees/"+str(proc)+"_"+str(cat) )
                    boundaries = []
                    boundaries.append( variables[ivarset][-2] )
                    boundaries.append( variables[ivarset][-1] )
                    print "root hasattr before"
                    print hasattr(ROOT, "vecBoundaries")
                    if not hasattr(ROOT, "vecBoundaries"):
                        gROOT.ProcessLine(" std::vector<std::vector<double > >* vecBoundaries = new std::vector<std::vector<double > >() ;")
                    else:
                        ROOT.vecBoundaries.clear()
                    print "root hasattr after"
                    print hasattr(ROOT, "vecBoundaries")
                    if not hasattr(ROOT, "tempvec"):
                        gROOT.ProcessLine("std::vector<double >* tempvec = new std::vector<double >() ;")
                    else:
                        ROOT.tempvec.clear()
                    for b in variables[ivarset][-2]:
                        ROOT.tempvec.push_back(b)
                    ROOT.vecBoundaries.push_back(tempvec)
                    ROOT.tempvec.clear()
                    for b in variables[ivarset][-1]:
                        ROOT.tempvec.push_back(b)
                    ROOT.vecBoundaries.push_back(tempvec)
                    
                    filler = DataSetFiller(str(proc), str(cat)+"_pdfWeights", rooarglist_pdfw, "weight", False)
                    wei = TCut("1")
                    if options.cut:
                        wei *= TCut(str(options.cut))
                    if not hasattr(ROOT, "obsnames"):
                        gROOT.ProcessLine("std::vector<std::string >* obsnames = new std::vector<std::string >() ;")
                    else:
                        ROOT.obsnames.clear()
                    ROOT.obsnames.push_back( str( variables[ivarset][0] ) )
                    ROOT.obsnames.push_back( str( variables[ivarset][1] ) )
                    print obsnames
                    filler.setGrid(ROOT.obsnames, vecBoundaries )
                    filler.fillFromTree(tree,wei.GetTitle())
                    if not hasattr(ROOT, "datasets"):
                        gROOT.ProcessLine("std::vector<RooDataSet* >* datasets = new std::vector<RooDataSet* >() ;")
                    else:
                        ROOT.datasets.clear()
                    ROOT.datasets = filler.get()
                                
                    for ids in range( ROOT.datasets.size() ):
                        ds = ( ROOT.datasets[ids] )
    
    #                    ds.SetName(str(dname))
    #                    ds.SetTitle(str(dname))
                        totpdfweights={}
                        ##initialise keys and values of pdfweights dict (so we don't have to check it at each iteration)
    
                        iset=ds.get()
                        iset.Print()
                        print iset
                        iteriset = iset.createIterator()
                        iwvar = iteriset.Next()
                        while iwvar:
                            totpdfweights[iwvar.GetName()] = 0.
                            iwvar = iteriset.Next()
    
                            #now loop through the entries and sum    
                        for ientry in range(ds.numEntries()):
                            iset=ds.get(ientry)
                            iteriset = iset.createIterator()
                            iwvar = iteriset.Next()
                            while iwvar:
                                totpdfweights[iwvar.GetName()] = totpdfweights[iwvar.GetName()] + iset.getRealValue(iwvar.GetName())
                                iwvar = iteriset.Next()
                        for ikey in totpdfweights.keys():
                            if ikey=='CMS_hgg_mass':
                                print "we found ",ikey
                                print "so we continue"
                                continue
                            if datasetsReduced[str( ds.GetName() ).replace("_pdfWeights","")].sumEntries() != 0:
                                totpdfweights[ikey] = totpdfweights[ikey]/datasetsReduced[str( ds.GetName() ).replace("_pdfWeights","")].sumEntries()
                            else:
                                totpdfweights[ikey]=0.
                            rrv_pdfWeights[ikey].setVal(totpdfweights[ikey])
    #                        ds.var(str(ikey)).setVal(totpdfweights[ikey])
                        rooarglist_pdfw_final=RooArgSet()
                        for irrv in rrv_pdfWeights.values():
                            rooarglist_pdfw_final.add(irrv)
                        rrv_sumentries = RooRealVar("sumW","sumW", 0)
                        rrv_sumentries.setVal(datasetsReduced[str( ds.GetName() ).replace("_pdfWeights","")].sumEntries())
                        ds_final = RooDataSet(str( ds.GetName() ), str( ds.GetName() ), rooarglist_pdfw_final, rrv_sumentries.GetName())
                        ds_final.add( rooarglist_pdfw_final, rrv_sumentries.getVal() )
                        ds.Print("V")
                        ds_final.Print("V")
                        datasetsReduced[ds_final.GetName()]=ds_final






        new_wspace = RooWorkspace("cms_hgg_13TeV")
        outfilename = options.outfile.split('.')[0]+'_'+str(variables[ivarset][0])
        if options.label:
            outfilename = outfilename+'_'+options.label
        outfilename = outfilename+'.root'
        outfile = TFile(outfilename, 'RECREATE')
        stepsize=int(len(datasetsReduced.keys())/10)
        iteration = 0
        while(len(datasetsReduced.keys())>0):
            print 'iteration '+str(iteration)
            print "length of datasets is "+str(len(datasetsReduced.keys()))
            iteration=iteration+1
            try: outfile
            except NameError: outfile = TFile(outfilename, 'UPDATE')

            try: new_wspace
            except NameError: 
                outfile.ls()
                new_wspace = outfile.Get("cms_hgg_13TeV")
                print "cms_hgg_13TeV;1"
                gDirectory.Delete("cms_hgg_13TeV;1")
                outfile.ls()
            written=[]
            if stepsize > len(datasetsReduced.keys()):
                stepsize = len(datasetsReduced.keys())
            for ikey in range(stepsize):
                getattr(new_wspace, 'import')(datasetsReduced[  datasetsReduced.keys()[ikey] ], ROOT.RooFit.Rename(  datasetsReduced[  datasetsReduced.keys()[ikey] ].GetName()  )  ) ##since root6, overloaded import methods are ambigous, need a second argument (rename the ds to the name it already has...) to disambiguate
                datasetsReduced[ datasetsReduced.keys()[ikey]  ].Write()
                written.append( datasetsReduced.keys()[ikey]  )
            print 'Number of data in ws '
            print len(new_wspace.allData())
            new_wspace.Print()
            new_wspace.Write()
            outfile.Write()
            outfile.Close()
            print "written at this round"
            print written
            print "still in the list are "+str(len(datasetsReduced))
            print datasetsReduced
            for wkey in written:
                print wkey
                del datasetsReduced[wkey]
            del new_wspace
            del outfile

    

## ------------------------------------------------------------------------------------------------------------------------------------------------------    
if __name__ == "__main__":
    parser = OptionParser(option_list=[
            make_option("-i", "--indir",
                        action="store", type="string", dest="indir",
                        default="./",
                        help="input directory", metavar="DIR"
                        ),
            make_option("-f", "--files",
                        action="store", type="string", dest="files",
                        default="allSig125IA.root",
                        help="pattern of files to be read", metavar="PATTERN"
                        ), 
            make_option("-t", "--treeName",
                        action="store", type="string", dest="treename",
                        default="TestTree",
                        help="TTree name", metavar="TREENAME"
                        ),
            make_option("-o", "--outfile",
                        action="store", type="string", dest="outfile",
                        default="reduced.root",
                        help="outputfile", metavar="FILE"
                        ),
            make_option("-l", "--label",
                        action="store", type="string", dest="label",
                        default="",
                        help="label", metavar="LABEL"
                        ),
            make_option("-w", "--weightsdir",
                        action="store", type="string", dest="weightsdir",
                        default="weights",
                        help="tmva weights dir", metavar="DIR"
                        ),
#            make_option("-V", "--variables",
#                        action="store", dest="variables", type="string",
#                        default="",
#                        help="list of variables"
#                        ),
            make_option("-T", "--tmvaSettings",
                        action="store", dest="tmvaSettings", type="string",
                        default="dipho.json",
                        help="settings for the TMVA training"
                        ),
            make_option("-v", "--verbose",
                        action="store_true", dest="verbose",
                        default=False,
                        ),
            make_option("-O", "--optimize",
                        action="store_true", dest="optimize",
                        default=False,
                        ),
            make_option("-D", "--outputdir",
                        action="store_true", dest="outdir",
                        default="plots",
                        ),
            make_option("-L", "--logz",
                        action="store_true", dest="logz",
                        default=False,
                        ),
            make_option("-N", "--maxEntries",
                        action="store", type="int", dest="maxEntries",
                        default=-1,
                        ),
            make_option("--load",  # special option to load whole configuaration from JSON
                        action="callback",callback=Load(),dest="__opts__",
                        type="string",
                        help="load JSON file with configuration",metavar="reduce_cfg.json"
                        ),

            ])

    (options, args) = parser.parse_args()

    sys.argv.append("-b")
    main(options, args)
