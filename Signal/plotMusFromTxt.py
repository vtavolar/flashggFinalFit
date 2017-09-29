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



from ROOT import gROOT
gROOT.ForceStyle()
gStyle.SetOptTitle(0)
gStyle.SetOptStat(0)

import numpy as np

xlabels={}
xlabels["AbsDeltaEtaJJEta4p7"] = "|#Delta #eta (j_{0}, j_{1})|, |#eta_{j}<4.7|"
xlabels["AbsDeltaPhiGgJet0Eta2p5"] = "|#Delta #phi (#gamma#gamma, j_{0})|, |#eta_{j}<2.5|"
xlabels["AbsDeltaPhiGgJjEta4p7"] = "|#Delta #phi (#gamma#gamma, j_{0}j_{1})|, |#eta_{j}<4.7|"
xlabels["AbsDeltaPhiJjEta4p7"] = "|#Delta #phi ( j_{0}, j_{1})|, |#eta_{j}<4.7|"
xlabels["AbsDeltaRapidityGgJet0Eta2p5"] = "|#Delta Y (#gamma#gamma, j_{0})|, |#eta_{j}<2.5|"
xlabels["AbsRapidity"] = "|Y (#gamma#gamma)|"
xlabels["CosThetaStar"] = "|cos(#theta*)|"
xlabels["Jet4p7Pt1"] = "p_{T}(j_{1}), |#eta_{j}<4.7|"
xlabels["ZeppenfeldEta4p7"] = "|#bar{#eta}(j_{0}j_{1}) - #eta(#gamma#gamma)|, |#eta_{j}<4.7|"
xlabels["Jet2p5Pt0"] = "p_{T}(j_{0}), |#eta_{j}<2.5|"
xlabels["Jet2p5AbsRapidity0"] = "Y(j_{0}), |#eta_{j}<2.5|"
xlabels["MjjEta4p7"] = "M(j_{0}j_{1}), |#eta_{j}<4.7|"
xlabels["PtNjets2p5"] = "p_{T}(#gamma#gamma) x N_{j}, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_0"] = "p_{T}(#gamma#gamma), N_{j}=0, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_1"] = "p_{T}(#gamma#gamma), N_{j}=1, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_1plus"] = "p_{T}(#gamma#gamma), N_{j}>1, |#eta_{j}<2.5|"










def getBinBoundariesFromDataset(dname):
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

def getBinBoundariesFromProcess(dname):
    nameSplit = dname.split("_")
    genbinl=0.
    genbinh=0.
    for ip in range(len(nameSplit)):
        if "gen" in nameSplit[ip] or "Gen" in nameSplit[ip]:
            if(len(nameSplit)>ip+1):
                genbinl = float(nameSplit[ip+1].replace("m","-").replace("p","."))
                genbinh = float(nameSplit[ip+2].replace("m","-").replace("p","."))
    return [genbinl,genbinh]

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
    
def mapPOItoProcess(line):
    POItoProc={}
    for s in filter(None,line.strip(' ').split("--PO")):
        print s.strip()
        print s.strip().split(":")
        print s.strip().split(":")[0].split("/")
        print s.strip().split(":")[1].split("[")
        POItoProc[s.strip().split(":")[1].split("[")[0]] = getBinBoundariesFromProcess( s.strip().split(":")[0].split("/")[1] )
    return POItoProc

def getBestFit(POIs, lines):
    BF={}
    for POI in POIs:
        for line in lines:
            if POI in line:
                print "".join(line.split())
                BF[POI]= re.split('[\+-]', (("".join(line.split())).split(POI+":")[1].strip()))
    for POI in POIs:
        if POI not in BF.keys():
            BF[POI]=[0.0,1.0,1.0]
    return BF
                
savefmts=['.png','.root','.pdf','.jpg']
# Main routine
def main(o,args):
    with open(options.files) as f:
        content = f.readlines()
    POItoProc = mapPOItoProcess(content[-1])
    print POItoProc
#    POItoProc["r9"]="bla"
    BF = getBestFit(POItoProc.keys(),content[:-1])
    print BF
#    central=[0]*len(BF.keys())
#    up=[1]*len(BF.keys())
#    down=[1]*len(BF.keys())
#    points=[]
    central={}
    up={}
    down={}
    xerr={}
    data=[]
    for POI in POItoProc.keys():
        data.append( {'x': 0.5*(POItoProc[POI][0]+POItoProc[POI][1]), 'y': float(BF[POI][0]), 'errx': float( 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) - POItoProc[POI][0]) , 'erryup' : float(BF[POI][1]), 'errydown': float(BF[POI][2])   }) 
        central[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][0])
        xerr[ 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) ] = float( 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) - POItoProc[POI][0]) 
        up[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][1])
        down[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][2])

        #binBound.append((POItoProc[POI][0]+POItoProc[POI][1]))
        #binBound.append(POItoProc[POI][1])
        
    #    binBound = list(sorted(set(binBound)))
    sortedData = sorted(data, key=lambda k: k['x'])
    if options.resizeFirst != -1000:
        sortedData[0]['x'] = 0.5*(options.resizeFirst + sortedData[1]['x'] - sortedData[1]['errx'])
        sortedData[0]['errx'] = sortedData[1]['x'] - sortedData[1]['errx'] - sortedData[0]['x'] 

    if options.resizeLast != -1:
        sortedData[-1]['x'] = 0.5*(options.resizeLast + sortedData[-2]['x'] + sortedData[-2]['errx'])
        sortedData[-1]['errx'] =   sortedData[-1]['x'] - (sortedData[-2]['x'] + sortedData[-2]['errx'])

    print sortedData
    print central
    print up
    print down
    print xerr
    print central.keys()
    print central.values()
##    graph = TGraphAsymmErrors( len(central.keys()), array('d', central.keys()), array('d', central.values()), array('d', xerr.values() ),array('d', xerr.values()), array('d',down.values()), array('d',up.values()) )
    graph = TGraphAsymmErrors( len(sortedData), array('d', [a['x'] for a in sortedData]), array('d', [a['y'] for a in sortedData]), array('d', [a['errx'] for a in sortedData] ),array('d', [a['errx'] for a in sortedData]), array('d',[a['errydown'] for a in sortedData]), array('d', [a['erryup'] for a in sortedData]) )
    ErrDown = [a['errydown'] for a in sortedData]
    ErrUp = [a['erryup'] for a in sortedData]
    graph.SetName("graph_"+options.variable)
    graph.SetTitle("")
    graph.Print("all")
    graph.SetMarkerStyle(20)
    graph.SetMarkerSize(1.1)
    c1= TCanvas()
    graph.Draw("ap")
    graph.GetXaxis().SetTitle(options.variable)
    if (options.variable in xlabels.keys()):
        print "variable "+str(options.variable)+" has a label for xaxis"
        print "setting xlabel to "+str(xlabels[options.variable])
        graph.GetXaxis().SetTitle(xlabels[options.variable])
###        graph.GetXaxis().SetTitleSize(1.2)
    graph.GetYaxis().SetTitle("d (#sigma_{fid}/#sigma_{fid}^{SM}) / d x")
    graph.GetYaxis().SetRangeUser(0.0,2.0)
#    graph.GetYaxis().SetTitleSize(1.2)
#    graph.GetXaxis().SetTitleSize(1.2)
    graph.Draw("ap")
    tex_m=TLatex()
    tex_m.SetNDC()
    tex_m.SetTextAlign(12)
    tex_m.SetTextFont(42)
    tex_m.SetTextSize(0.055)
    tex_m.SetLineWidth(2)
    tex_m.DrawLatex(0.1,0.93,"#bf{CMS}, #it{Preliminary}")
        
    tex_m=TLatex()
    tex_m.SetNDC()
    tex_m.SetTextAlign(12)
    tex_m.SetTextFont(42)
    tex_m.SetTextSize(0.045)
#        tex_m.SetLineWidth(2)
    tex_m.DrawLatex(0.65,0.93,"35.9 fb^{-1} (13TeV)")
        
    for fmt in savefmts:
        savename = str(options.outdir)+"/expectedPrecision_"+str(options.variable) 
        if options.resizeLast != -1:
            savename = str(savename)+"_lastBinResizedTo"+str(options.resizeLast)
        if options.resizeFirst != -1000:
            savename = str(savename)+"_firstBinResizedTo"+str(options.resizeFirst)
        if options.hideFirstBin:
            savename = str(savename)+"_hideFirstBin"
        c1.SaveAs(str(savename)+str(fmt))    
    SymmError = [0.5*(a+b) for a,b in zip(ErrUp,ErrDown)]
    MeanError = np.mean(SymmError)
    StdDevError = np.std(SymmError)
    numberOfBins = len(SymmError)
    MedianError = np.median(SymmError)
    Quant25Error = np.percentile(SymmError,25)
    Quant75Error = np.percentile(SymmError,75)
    if(options.skipFirstInMean):
        MeanError = np.mean(SymmError[1:])
        StdDevError = np.std(SymmError[1:])
        numberOfBins = len(SymmError[1:])
        MedianError = np.median(SymmError[1:])
        Quant25Error = np.percentile(SymmError[1:],25)
        Quant75Error = np.percentile(SymmError[1:],75)

    out_file = open(str(options.outdir)+"/meanPrecision.txt", "a")
    out_file.write(str(options.variable)+"	"+str(numberOfBins)+"	"+str(MeanError)+"	"+str(StdDevError)+"	"+str(MedianError)+"	"+str(Quant25Error)+"	"+str(Quant75Error)+"\n")
    out_file.close
##    infile = TFile(options.files, "READ")
##    ws = infile.Get(options.wsname)
##    alldata = ws.allData()
##    genBoundaries=[]
##    recoBoundaries=[]
##    for d in alldata:
##        genVar,recoVar = getVarsName(d.GetName())
##        d.Print()
##        genBs,recoBs = getBinBoundaries(d.GetName())
##        genBoundaries.append(genBs[0])
##        genBoundaries.append(genBs[1])
##        recoBoundaries.append(recoBs[0])
##        recoBoundaries.append(recoBs[1])
##    genBoundaries = sorted(list(set(genBoundaries)))
##    recoBoundaries = sorted(list(set(recoBoundaries)))
##    if options.hideFirstBin:
##        if -1000 in genBoundaries:
##            genBoundaries.remove(-1000)
##        if -1000 in recoBoundaries:
##            recoBoundaries.remove(-1000)
##    lastBinB = genBoundaries[-1]
##    firstBinB = genBoundaries[0]
##    if options.resizeLast != -1:
##        genBoundaries[-1]=options.resizeLast
##        recoBoundaries[-1]=options.resizeLast
##    if options.resizeFirst != -1000:
##        genBoundaries[0]=options.resizeFirst
##        recoBoundaries[0]=options.resizeFirst
##    print array('d', genBoundaries)
##    print array('d', recoBoundaries)
##    
##    label=""
##    respMs={}
##    for cat in options.categories.split(","):
##        respMs[cat] = TH2D("resp_matrix_"+str(label)+"_"+str(cat), "resp_matrix_"+str(label)+"_"+str(cat), len(genBoundaries)-1, array('d',genBoundaries), len(recoBoundaries)-1, array('d',recoBoundaries))
##        respMs[cat].GetXaxis().SetTitle(genVar)
##        respMs[cat].GetYaxis().SetTitle(recoVar)
###        respM.GetXaxis().Print()
###        respM.GetYaxis().Print()
##        for d in alldata:
##            if cat in d.GetName():
##                genBs,recoBs = getBinBoundaries(d.GetName())
##                if genBs[1] == lastBinB and options.resizeLast != -1:
##                    genBs[1]=options.resizeLast
##                if recoBs[1] == lastBinB and options.resizeLast != -1:
##                    recoBs[1]=options.resizeLast
##
##                if genBs[0] == firstBinB and options.resizeFirst != -1000:
##                    genBs[0]=options.resizeFirst
##                if recoBs[0] == firstBinB and options.resizeFirst != -1000:
##5B                    recoBs[0]=options.resizeFirst
##                print "dname: "+str(d.GetName())+", sumW: "+str(d.sumEntries())
##                respMs[cat].SetBinContent(respMs[cat].GetBin( respMs[cat].GetXaxis().FindBin(0.5*(genBs[0]+genBs[1])), respMs[cat].GetYaxis().FindBin(0.5*(recoBs[0]+recoBs[1]) ) ), respMs[cat].GetBinContent( respMs[cat].GetBin( respMs[cat].GetXaxis().FindBin(0.5*(genBs[0]+genBs[1])), respMs[cat].GetYaxis().FindBin(0.5*(recoBs[0]+recoBs[1]) ) ) )  +  d.sumEntries() )
##    cat="all"
##    respMAll = TH2D("resp_matrix_"+str(label)+"_"+str(cat), "resp_matrix_"+str(label)+"_"+str(cat), len(genBoundaries)-1, array('d',genBoundaries), len(recoBoundaries)-1, array('d',recoBoundaries))
##    respMAll.GetXaxis().SetTitle(genVar)
##    respMAll.GetYaxis().SetTitle(recoVar)
##    for rm in respMs.values():
##        respMAll.Add(rm)
##    respMs[cat]=respMAll
##
##    c1=TCanvas()
##    for respM in respMs.keys():
##        respMs[respM].Draw("colz")
##        if options.logx:
##            c1.SetLogx()
##        if options.logy:
##            c1.SetLogy()
##        if options.logz:
##            c1.SetLogz()
##        respMs[respM].Print("ALL")
##        for fmt in savefmts:
##            savename = str(options.outdir)+"/respMatrix_"+str(respM) 
##            if options.resizeLast != -1:
##                savename = str(savename)+"_lastBinResizedTo"+str(options.resizeLast)
##            if options.resizeFirst != -1000:
##                savename = str(savename)+"_firstBinResizedTo"+str(options.resizeFirst)
##            if options.hideFirstBin:
##                savename = str(savename)+"_hideFirstBin"
##            c1.SaveAs(str(savename)+str(fmt))
    

        
    
    
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

            make_option("-V", "--variable",
                        action="store", dest="variable", type="string",
                        default="PtNJets2p5",
                        help="list of variable"
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
            make_option("-S", "--skipFirstInMean",
                        action="store_true", dest="skipFirstInMean",
                        default=False,
                        ),

            ])

    (options, args) = parser.parse_args()

    sys.argv.append("-b")
    main(options, args)






