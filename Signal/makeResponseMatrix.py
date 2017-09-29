#!/usr/bin/env python2.7
###!/usr/bin/env python
# 
# --------------------------------------------
# Standard python import
from optparse import OptionParser, make_option
import fnmatch, glob, os, sys, json, itertools, array
import re
#sys.argv.append( '-b' )
from array import array
## ------------------------------------------------------------------------------------------------------------------------------------------------------


#from templates_maker import buildRooDataSet
import ROOT
from ROOT import TH2D, TH1D, TFile, TProfile, TCanvas, TGraphAsymmErrors
from ROOT import RooWorkspace
from ROOT import RooAbsData
from ROOT import RooDataSet
from ROOT import *

import tdrstyle
import CMS_lumi
reload(tdrstyle)
reload(CMS_lumi)

CMS_lumi.lumi_13TeV = ''
CMS_lumi.extraText = 'Simulation Preliminary'
CMS_lumi.relPosX = 0.18
CMS_lumi.relPosY = -0.06


from ROOT import gROOT
gROOT.ForceStyle()
gStyle.SetOptTitle(0)
gStyle.SetOptStat(0)

import numpy as np



def getBinBoundaries(dname):
    nameSplit = dname.split("_")
    genbinl=0.
    genbinh=0.
    recobinl=0.
    recobinh=0.
    for ip in range(len(nameSplit)):
        if "gen" in nameSplit[ip] or "Gen" in nameSplit[ip]:
            if(len(nameSplit)>ip+1):
                genbinl = float(nameSplit[ip+1].replace("m","-").replace("p","."))
                genbinh = float(nameSplit[ip+2].replace("m","-").replace("p","."))
        if "reco" in nameSplit[ip] or "Reco" in nameSplit[ip]:
            if(len(nameSplit)>ip+1):
                recobinl = float(nameSplit[ip+1].replace("m","-").replace("p","."))
                recobinh = float(nameSplit[ip+2].replace("m","-").replace("p","."))
    return [genbinl,genbinh],[recobinl,recobinh]

def getVarsName(dname):
    nameSplit = dname.split("_")
    genVar=""
    recoVar=""
    for ip in range(len(nameSplit)):
        if "gen" in nameSplit[ip] or "Gen" in nameSplit[ip]:
            genVar=nameSplit[ip]
        if "reco" in nameSplit[ip] or "Reco" in nameSplit[ip]:
            recoVar=nameSplit[ip]
    return genVar,recoVar
    
savefmts=['.png','.root','.pdf','.jpg']
# Main routine
def main(o,args):
    infile = TFile(options.files, "READ")
    ws = infile.Get(options.wsname)
    alldata = ws.allData()
    genBoundaries=[]
    recoBoundaries=[]
    for d in alldata:
        genVar,recoVar = getVarsName(d.GetName())
        d.Print()
        genBs,recoBs = getBinBoundaries(d.GetName())
        genBoundaries.append(genBs[0])
        genBoundaries.append(genBs[1])
        recoBoundaries.append(recoBs[0])
        recoBoundaries.append(recoBs[1])
    genBoundaries = sorted(list(set(genBoundaries)))
    recoBoundaries = sorted(list(set(recoBoundaries)))
    if options.hideFirstBin:
        if -1000 in genBoundaries:
            genBoundaries.remove(-1000)
        if -1000 in recoBoundaries:
            recoBoundaries.remove(-1000)
    lastBinB = genBoundaries[-1]
    firstBinB = genBoundaries[0]
    if options.resizeLast != -1:
        genBoundaries[-1]=options.resizeLast
        recoBoundaries[-1]=options.resizeLast
    if options.resizeFirst != -1000:
        genBoundaries[0]=options.resizeFirst
        recoBoundaries[0]=options.resizeFirst
    print array('d', genBoundaries)
    print array('d', recoBoundaries)
    
    label=""
    respMs={}
    for cat in options.categories.split(","):
        respMs[cat] = TH2D("resp_matrix_"+str(label)+"_"+str(cat), "resp_matrix_"+str(label)+"_"+str(cat), len(genBoundaries)-1, array('d',genBoundaries), len(recoBoundaries)-1, array('d',recoBoundaries))
        respMs[cat].GetXaxis().SetTitle(genVar)
        respMs[cat].GetYaxis().SetTitle(recoVar)
#        respM.GetXaxis().Print()
#        respM.GetYaxis().Print()
        for d in alldata:
            if cat in d.GetName():
                genBs,recoBs = getBinBoundaries(d.GetName())
                if genBs[1] == lastBinB and options.resizeLast != -1:
                    genBs[1]=options.resizeLast
                if recoBs[1] == lastBinB and options.resizeLast != -1:
                    recoBs[1]=options.resizeLast

                if genBs[0] == firstBinB and options.resizeFirst != -1000:
                    genBs[0]=options.resizeFirst
                if recoBs[0] == firstBinB and options.resizeFirst != -1000:
                    recoBs[0]=options.resizeFirst
                print "dname: "+str(d.GetName())+", sumW: "+str(d.sumEntries())
                respMs[cat].SetBinContent(respMs[cat].GetBin( respMs[cat].GetXaxis().FindBin(0.5*(genBs[0]+genBs[1])), respMs[cat].GetYaxis().FindBin(0.5*(recoBs[0]+recoBs[1]) ) ), respMs[cat].GetBinContent( respMs[cat].GetBin( respMs[cat].GetXaxis().FindBin(0.5*(genBs[0]+genBs[1])), respMs[cat].GetYaxis().FindBin(0.5*(recoBs[0]+recoBs[1]) ) ) )  +  d.sumEntries() )
    cat="all"
    respMAll = TH2D("resp_matrix_"+str(label)+"_"+str(cat), "resp_matrix_"+str(label)+"_"+str(cat), len(genBoundaries)-1, array('d',genBoundaries), len(recoBoundaries)-1, array('d',recoBoundaries))
    respMAll.GetXaxis().SetTitle(genVar)
    respMAll.GetYaxis().SetTitle(recoVar)
    for rm in respMs.values():
        respMAll.Add(rm)
    respMs[cat]=respMAll

    c1=TCanvas()
    for respM in respMs.keys():
        
        respMs[respM].GetXaxis().CenterTitle()
        respMs[respM].GetYaxis().CenterTitle()

        respMs[respM].GetZaxis().SetTitle("efficiency")
        respMs[respM].GetZaxis().CenterTitle()

        respMs[respM].DrawNormalized("colz text")
        c1.Draw()
        c1.RedrawAxis()
        if options.logx:
            c1.SetLogx()
        if options.logy:
            c1.SetLogy()
        if options.logz:
            c1.SetLogz()
        respMs[respM].Print("ALL")
        for fmt in savefmts:
            savename = str(options.outdir)+"/respMatrix_"+str(options.variables)+"_"+str(respM) 
            if options.resizeLast != -1:
                savename = str(savename)+"_lastBinResizedTo"+str(options.resizeLast)
            if options.resizeFirst != -1000:
                savename = str(savename)+"_firstBinResizedTo"+str(options.resizeFirst)
            if options.hideFirstBin:
                savename = str(savename)+"_hideFirstBin"
            c1.SaveAs(str(savename)+str(fmt))
    

        
    
    
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
            make_option("-w", "--wsname",
                        action="store", type="string", dest="wsname",
                        default="cms_hgg_13TeV",
                        help="name of ws to be read", metavar="PATTERN"
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

            make_option("-V", "--variables",
                        action="store", dest="variables", type="string",
                        default="",
                        help="list of variables"
                        ),
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
            make_option("-D", "--outdir",
                        action="store", type="string", dest="outdir",
                        default="plots",
                        ),
            make_option("-L", "--logz",
                        action="store_true", dest="logz",
                        default=False,
                        ),
            make_option("-x", "--logx",
                        action="store_true", dest="logx",
                        default=False,
                        ),
            make_option("-y", "--logy",
                        action="store_true", dest="logy",
                        default=False,
                        ),
            make_option("-H", "--hideFirstBin",
                        action="store_true", dest="hideFirstBin",
                        default=False,
                        ),
            make_option("-N", "--maxEntries",
                        action="store", type="int", dest="maxEntries",
                        default=-1,
                        ),
            make_option("-R", "--resizeLast",
                        action="store", type="float", dest="resizeLast",
                        default=-1,
                        ),
            make_option("--resizeFirst",
                        action="store", type="float", dest="resizeFirst",
                        default=-1000,
                        ),
            make_option("-C", "--categories",
                        action="store", type="string", dest="categories",
                        default="SigmaMpTTag_0,SigmaMpTTag_1,SigmaMpTTag_2",
                        ),

            ])

    (options, args) = parser.parse_args()

    sys.argv.append("-b")
    main(options, args)






