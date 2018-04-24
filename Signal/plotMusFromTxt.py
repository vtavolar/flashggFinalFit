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

import os.path


from ROOT import gROOT
gROOT.ForceStyle()
gStyle.SetOptTitle(0)
gStyle.SetOptStat(0)



ROOT.myColorA0   = ROOT.TColor.GetColor("#ff8000")
ROOT.myColorA1   = ROOT.TColor.GetColor("#ffbf80")

ROOT.myColorB1   = ROOT.TColor.GetColor("#538cc6")

import numpy as np

observables={}
observables["Pt"]                           = dict( xlabel="p_{T}^{#gamma#gamma} (GeV)"                                              , ylabel=    "d#sigma_{fid}/dp_{T}^{#gamma#gamma} (fb/GeV)"                          , legend="r")
observables["AbsDeltaEtaJJEta4p7"]          = dict( xlabel="|#Delta #eta (j_{0}, j_{1})|, |#eta_{j}<4.7|"                            , ylabel=    "d#sigma_{fid}/d|#Delta #eta (j_{0}, j_{1})| (fb)"                      , legend="r")
observables["AbsDeltaPhiGgJet0Eta2p5"]      = dict( xlabel="|#Delta #phi (#gamma#gamma, j_{0})|, |#eta_{j}<2.5|"                     , ylabel=    "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0})| (fb)"               , legend="l")
observables["AbsDeltaPhiGgJjEta4p7"]        = dict( xlabel="|#Delta #phi (#gamma#gamma, j_{0}j_{1})|, |#eta_{j}<4.7|"                , ylabel=    "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0}j_{1})| (fb)"          , legend="l")
observables["AbsDeltaPhiJjEta4p7"]          = dict( xlabel="|#Delta #phi ( j_{0}, j_{1})|, |#eta_{j}<4.7|"                           , ylabel=    "d#sigma_{fid}/d|#Delta #phi ( j_{0}, j_{1})| (fb)"                     , legend="l")
observables["AbsDeltaRapidityGgJet0Eta2p5"] = dict( xlabel="|#Delta Y (#gamma#gamma, j_{0})|, |#eta_{j}<2.5|"                        , ylabel=    "d#sigma_{fid}/d|#Delta Y (#gamma#gamma, j_{0})| (fb)"                  , legend="r")
observables["AbsRapidity"]                  = dict( xlabel="|Y (#gamma#gamma)|"                                                      , ylabel=    "d#sigma_{fid}/d|Y (#gamma#gamma)| (fb)"                                , legend="l")
observables["CosThetaStar"]                 = dict( xlabel="|cos(#theta*)|"                                                          , ylabel=    "d#sigma_{fid}/d|cos(#theta*)| (fb)"                                    , legend="r")
observables["Jet4p7Pt1"]                    = dict( xlabel="p_{T}(j_{1}), |#eta_{j}<4.7|"                                            , ylabel=    "d#sigma_{fid}/dp_{T}(j_{1}) (fb/GeV)"                                  , legend="r")
observables["ZeppenfeldEta4p7"]             = dict( xlabel="|#bar{#eta}(j_{0}j_{1}) - #eta(#gamma#gamma)|, |#eta_{j}<4.7|"           , ylabel=    "d#sigma_{fid}/d|#bar{#eta}(j_{0}j_{1}) - #eta(#gamma#gamma)| (fb)"     , legend="r")
observables["Jet2p5Pt0"]                    = dict( xlabel="p_{T}(j_{0}), |#eta_{j}<2.5|"                                            , ylabel=    "d#sigma_{fid}/dp_{T}(j_{0}) (fb/GeV)"                                  , legend="r")
observables["Jet2p5AbsRapidity0"]           = dict( xlabel="Y(j_{0}), |#eta_{j}<2.5|"                                                , ylabel=    "d#sigma_{fid}/dY(j_{0}) (fb)"                                          , legend="r")
observables["MjjEta4p7"]                    = dict( xlabel="M(j_{0}j_{1}), |#eta_{j}<4.7|"                                           , ylabel=    "d#sigma_{fid}/dM(j_{0}j_{1}) (fb/GeV)"                                 , legend="r")
observables["Njets2p5"]                     = dict( xlabel="N_{j}, |#eta_{j}<2.5|"                                                   , ylabel=    "d#sigma_{fid}/dN_{j} (fb)"                                             , legend="r")
observables["PtNjets2p5"]                   = dict( xlabel="p_{T}(#gamma#gamma) x N_{j}, |#eta_{j}<2.5|"                             , ylabel=    "d#sigma_{fid}/d^{2}p_{T}(#gamma#gamma) N_{j} (fb/GeV)"                 , legend="r")
observables["PtNjets2p5_0"]                 = dict( xlabel="p_{T}(#gamma#gamma), N_{j}=0, |#eta_{j}<2.5|"                            , ylabel=    "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}=0 (fb/GeV)"                 , legend="r")
observables["PtNjets2p5_1"]                 = dict( xlabel="p_{T}(#gamma#gamma), N_{j}=1, |#eta_{j}<2.5|"                            , ylabel=    "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}=1 (fb/Gev)"                 , legend="r")
observables["PtNjets2p5_1plus"]             = dict( xlabel="p_{T}(#gamma#gamma), N_{j}>1, |#eta_{j}<2.5|"                            , ylabel=    "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}>1 (fb/GeV)"                 , legend="r")
observables["MET"]                          = dict( xlabel="p_{T}^{miss}"                                                            , ylabel=    "d#sigma_{fid}/dp_{T}^{miss} (fb/GeV)"                                  , legend="r")
observables["NjetsBflavorTight2p5"]         = dict( xlabel="N_{b}, |#eta_{j}<2.5|"                                                   , ylabel=    "d#sigma_{fid}/dN_{b} (fb)"                                             , legend="r")
observables["Nleptons"]                     = dict( xlabel="N_{lepton}"                                                              , ylabel=    "d#sigma_{fid}/dN_{lepton} (fb)"                                        , legend="r")
observables["1Lepton1Bjet"]                 = dict( xlabel="N_{lepton} = 1, N_{b} = 1"                                               , ylabel=    "#sigma_{fid}(N_{lepton} = 1, N_{b} = 1 (fb)"                           , legend="r")
observables["1LeptonHighMET"]               = dict( xlabel="N_{lepton} = 1, high p_{T}^{miss}"                                       , ylabel=    "#sigma_{fid}(N_{lepton} = 1, high p_{T}^{miss} (fb)"                   , legend="r")
observables["1LeptonLowMET"]                = dict( xlabel="N_{lepton} = 1, low p_{T}^{miss}"                                        , ylabel=    "#sigma_{fid}(N_{lepton} = 1, low p_{T}^{miss} (fb)"                    , legend="r")
observables["Jet4p7AbsRapidity1"]           = dict( xlabel="Y(j_{1}), |#eta_{j}<4.7|"                                                , ylabel=    "d#sigma_{fid}/dY(j_{1}) (fb)"                                          , legend="r")
observables["Jet4p7Pt1VBFlike"]             = dict( xlabel="p_{T}(j_{1}), |#eta_{j}<4.7|, VBF-like"                                  , ylabel=    "d#sigma_{fid}/dp_{T}(j_{1}) (fb/GeV)"                                  , legend="r")
observables["AbsDeltaPhiGgJjEta4p7VBFlike"] = dict( xlabel="|#Delta #phi (#gamma#gamma, j_{0}j_{1})|, |#eta_{j}<4.7|, VBF-like"      , ylabel=    "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0}j_{1})| (fb)"          , legend="r")
observables["AbsDeltaPhiJjEta4p7VBFlike"]   = dict( xlabel="|#Delta #phi ( j_{0}, j_{1})|, |#eta_{j}<4.7|, VBF-like"                 , ylabel=    "d#sigma_{fid}/d|#Delta #phi ( j_{0}, j_{1})| (fb)"                     , legend="l")





xlabels={}
xlabels["Pt"] = "p_{T}^{#gamma#gamma} (GeV)"

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

xlabels["Njets2p5"] = "N_{j}, |#eta_{j}<2.5|"
xlabels["PtNjets2p5"] = "p_{T}(#gamma#gamma) x N_{j}, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_0"] = "p_{T}(#gamma#gamma), N_{j}=0, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_1"] = "p_{T}(#gamma#gamma), N_{j}=1, |#eta_{j}<2.5|"
xlabels["PtNjets2p5_1plus"] = "p_{T}(#gamma#gamma), N_{j}>1, |#eta_{j}<2.5|"

xlabels["MET"] = "p_{T}^{miss}"
xlabels["NjetsBflavorTight2p5"] = "N_{b}, |#eta_{j}<2.5|"
xlabels["Nleptons"] = "N_{lepton}"
xlabels["1Lepton1Bjet"] = "N_{lepton} = 1, N_{b} = 1"
xlabels["1LeptonHighMET"] = "N_{lepton} = 1, high p_{T}^{miss}"
xlabels["1LeptonLowMET"] = "N_{lepton} = 1, low p_{T}^{miss}"

xlabels["Jet4p7AbsRapidity1"] = "Y(j_{1}), |#eta_{j}<4.7|"

xlabels["Jet4p7Pt1VBFlike"] = "p_{T}(j_{1}), |#eta_{j}<4.7|, VBF-like"
xlabels["AbsDeltaPhiGgJjEta4p7VBFlike"] = "|#Delta #phi (#gamma#gamma, j_{0}j_{1})|, |#eta_{j}<4.7|, VBF-like"
xlabels["AbsDeltaPhiJjEta4p7like"] = "|#Delta #phi ( j_{0}, j_{1})|, |#eta_{j}<4.7|, VBF-like"



ylabels={}
ylabels["Pt"]                           = "d#sigma_{fid}/dp_{T}^{#gamma#gamma} (fb/GeV)"                          
ylabels["AbsDeltaEtaJJEta4p7"]          = "d#sigma_{fid}/d|#Delta #eta (j_{0}, j_{1})| (fb)"                      
ylabels["AbsDeltaPhiGgJet0Eta2p5"]      = "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0})| (fb)"               
ylabels["AbsDeltaPhiGgJjEta4p7"]        = "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0}j_{1})| (fb)"          
ylabels["AbsDeltaPhiJjEta4p7"]          = "d#sigma_{fid}/d|#Delta #phi ( j_{0}, j_{1})| (fb)"                     
ylabels["AbsDeltaRapidityGgJet0Eta2p5"] = "d#sigma_{fid}/d|#Delta Y (#gamma#gamma, j_{0})| (fb)"                  
ylabels["AbsRapidity"]                  = "d#sigma_{fid}/d|Y (#gamma#gamma)| (fb)"                                
ylabels["CosThetaStar"]                 = "d#sigma_{fid}/d|cos(#theta*)| (fb)"                                    
ylabels["Jet4p7Pt1"]                    = "d#sigma_{fid}/dp_{T}(j_{1}) (fb/GeV)"                                  
ylabels["ZeppenfeldEta4p7"]             = "d#sigma_{fid}/d|#bar{#eta}(j_{0}j_{1}) - #eta(#gamma#gamma)| (fb)"     
ylabels["Jet2p5Pt0"]                    = "d#sigma_{fid}/dp_{T}(j_{0}) (fb/GeV)"                                  
ylabels["Jet2p5AbsRapidity0"]           = "d#sigma_{fid}/dY(j_{0}) (fb)"                                          
ylabels["MjjEta4p7"]                    = "d#sigma_{fid}/dM(j_{0}j_{1}) (fb/GeV)"                                 
ylabels["Njets2p5"]                     = "d#sigma_{fid}/dN_{j} (fb)"                                             
ylabels["PtNjets2p5"]                   = "d#sigma_{fid}/d^{2}p_{T}(#gamma#gamma) N_{j} (fb/GeV)"                 
ylabels["PtNjets2p5_0"]                 = "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}=0 (fb/GeV)"                 
ylabels["PtNjets2p5_1"]                 = "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}=1 (fb/Gev)"                 
ylabels["PtNjets2p5_1plus"]             = "d#sigma_{fid}/dp_{T}(#gamma#gamma)), N_{j}>1 (fb/GeV)"                 
ylabels["MET"]                          = "d#sigma_{fid}/dp_{T}^{miss} (fb/GeV)"                                  
ylabels["NjetsBflavorTight2p5"]         = "d#sigma_{fid}/dN_{b} (fb)"                                             
ylabels["Nleptons"]                     = "d#sigma_{fid}/dN_{lepton} (fb)"                                        
ylabels["1Lepton1Bjet"]                 = "#sigma_{fid}(N_{lepton} = 1, N_{b} = 1 (fb)"                           
ylabels["1LeptonHighMET"]               = "#sigma_{fid}(N_{lepton} = 1, high p_{T}^{miss} (fb)"                   
ylabels["1LeptonLowMET"]                = "#sigma_{fid}(N_{lepton} = 1, low p_{T}^{miss} (fb)"                    
ylabels["Jet4p7AbsRapidity1"]           = "d#sigma_{fid}/dY(j_{1}) (fb)"                                          
ylabels["Jet4p7Pt1VBFlike"]             = "d#sigma_{fid}/dp_{T}(j_{1}) (fb/GeV)"                                  
ylabels["AbsDeltaPhiGgJjEta4p7VBFlike"] = "d#sigma_{fid}/d|#Delta #phi (#gamma#gamma, j_{0}j_{1})| (fb)"          
ylabels["AbsDeltaPhiJjEta4p7like"]      = "d#sigma_{fid}/d|#Delta #phi ( j_{0}, j_{1})| (fb)"                     










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

    print options.files
    with open(options.files) as f:
        content = f.readlines()
    POItoProc = mapPOItoProcess(content[-1])
    print "POItoProc"
    print POItoProc

    BF = getBestFit(POItoProc.keys(),content[:-1])
    print "BF"
    print BF

    print options.filesFreezeNuis
    with open(options.filesFreezeNuis) as f:
        content = f.readlines()
    POItoProcStatOnly = mapPOItoProcess(content[-1])
    print "POItoProcStatOnly"
    print POItoProcStatOnly
    BF_StatOnly = getBestFit(POItoProcStatOnly.keys(),content[:-1])
    print "BF_StatOnly"
    print BF_StatOnly


    if not set(POItoProc.keys()) == set(POItoProcStatOnly.keys()):
        raise ValueError("input files for full unc and stat. only scans do not have the same POIs definitions and can not be matched!")

    central={}
    centralSM={}
    up={}
    down={}
    up_StatOnly={}
    down_StatOnly={}
    xerr={}
    data=[]
    for POI in POItoProc.keys():
        data.append( {'x': 0.5*(POItoProc[POI][0]+POItoProc[POI][1]), 'y': float(BF[POI][0]), 'ySM' : float(1.), 'errx': float( 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) - POItoProc[POI][0]) , 'erryup' : float(BF[POI][1]), 'errydown': float(BF[POI][2]),  'erryup_statOnly' : float(BF_StatOnly[POI][1]), 'errydown_statOnly': float(BF_StatOnly[POI][2])    })
        central[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][0])
        centralSM[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = 1.
        xerr[ 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) ] = float( 0.5*(POItoProc[POI][0]+POItoProc[POI][1]) - POItoProc[POI][0]) 
        up[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][1])
        down[0.5*(POItoProc[POI][0]+POItoProc[POI][1])] = float(BF[POI][2])

        up_StatOnly[0.5*(POItoProcStatOnly[POI][0]+POItoProcStatOnly[POI][1])] = float(BF_StatOnly[POI][1])
        down_StatOnly[0.5*(POItoProcStatOnly[POI][0]+POItoProcStatOnly[POI][1])] = float(BF_StatOnly[POI][2])

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
    print '/mnt/t3nfs01/data01/shome/vtavolar/jupyter/CMSSW_8_0_28/src/higgs_model_dep/spectrumNNLOPS_%s.npz'% options.variable
    if os.path.isfile('/mnt/t3nfs01/data01/shome/vtavolar/jupyter/CMSSW_8_0_28/src/higgs_model_dep/spectrumNNLOPS_%s.npz'% options.variable) and options.spectrum:
        spectrum = np.load('/mnt/t3nfs01/data01/shome/vtavolar/jupyter/CMSSW_8_0_28/src/higgs_model_dep/spectrumNNLOPS_%s.npz' % options.variable)
        print spectrum.keys()
        print spectrum
        xsecs = spectrum['spectrum'] 
        print xsecs
        binwidth = spectrum['binwidth'] 
        #divide last bin for same binwidth as second-to-last
        if options.variable != 'CosThetaStar':
            binwidth[-1]=binwidth[-2]
        print binwidth
        xsecOverBw = map(lambda  s, b: s/b,  xsecs, binwidth)
        print central
        centralValues = map(lambda c, s, b: c*s/b, centralSM.values(), xsecs, binwidth)
        print centralValues
        ic=0
        for c in sorted(central.keys()):
            print c
            print central[c]
            central[c] = central[c]*centralValues[ic]
            centralSM[c] = centralSM[c]*centralValues[ic]
            ic+=1

        print centralValues
        print central
        print centralSM
    print sortedData
    sortedCentral = sorted(central.keys())
    print 'sortedCentral'
    print sortedCentral
    if options.resizeFirst != -1000:
        central[(0.5*(options.resizeFirst + sortedData[1]['x'] - sortedData[1]['errx']))] = central[sortedCentral[0]]
        del central[sortedCentral[0]]
        centralSM[(0.5*(options.resizeFirst + sortedData[1]['x'] - sortedData[1]['errx']))] = centralSM[sortedCentral[0]]
        del centralSM[sortedCentral[0]]

    if options.resizeLast != -1:
        central[(0.5*(options.resizeLast + sortedData[-2]['x'] + sortedData[-2]['errx']))] = central[sortedCentral[-1]]
        del central[sortedCentral[-1]]
        centralSM[(0.5*(options.resizeLast + sortedData[-2]['x'] + sortedData[-2]['errx']))] = centralSM[sortedCentral[-1]]
        del centralSM[sortedCentral[-1]]
    print "central"
    print central
    print "centralSM"
    print centralSM
    xsecs=[]
    for dt in sortedData:
        dt['y']=central[dt['x']]
        dt['ySM']=centralSM[dt['x']]
        dt['erryup'] = dt['erryup']*centralSM[dt['x']]
        dt['errydown'] = dt['errydown']*centralSM[dt['x']]
        dt['erryup_statOnly'] = dt['erryup_statOnly']*centralSM[dt['x']]
        dt['errydown_statOnly'] = dt['errydown_statOnly']*centralSM[dt['x']]
        xsecs.append(dt['y'])
    print "dt['y']"
    print dt['y']
    print 'xsecs'
    print xsecs

    print "scale up last bin to avg xsec if needed"
    lastBinXsec = sortedData[-1]['y']
    avgXsec = sum(xsecs[:-1])/float(len(xsecs))
    scaleLastBin=1.
#    if lastBinXsec < avgXsec:
#        scaleLastBin = avgXsec/lastBinXsec
    sortedData[-1]['y'] = sortedData[-1]['y']*scaleLastBin
    sortedData[-1]['ySM'] = sortedData[-1]['ySM']*scaleLastBin
    sortedData[-1]['erryup'] = sortedData[-1]['erryup']*scaleLastBin
    sortedData[-1]['errydown'] = sortedData[-1]['errydown']*scaleLastBin
    sortedData[-1]['erryup_statOnly'] = sortedData[-1]['erryup_statOnly']*scaleLastBin
    sortedData[-1]['errydown_statOnly'] = sortedData[-1]['errydown_statOnly']*scaleLastBin

    xsecs[-1] = xsecs[-1]*scaleLastBin
    print 'sortedData[-1][y]'
    print sortedData[-1]['y']
    print 'xsecs[-1]'
    print xsecs[-1]
    print "search min and max for plotting"
    xsecMin = min(xsecs)
    xsecMax = max(xsecs)
    if options.hideFirstBin:
        xsecMin = min(xsecs[1:])
        xsecMax = max(xsecs[1:])
    print 'xsecMin'
    print xsecMin
    print 'xsecMax'
    print xsecMax
    print up
    print down
    print xerr
    print central.keys()
    print central.values()
##    graph = TGraphAsymmErrors( len(central.keys()), array('d', central.keys()), array('d', central.values()), array('d', xerr.values() ),array('d', xerr.values()), array('d',down.values()), array('d',up.values()) )
    newSortedData={}
    if options.variable=="PtNjets2p5":
        newSortedData["PtNjets2p5_0"]=sortedData[0:3]
        newSortedData["PtNjets2p5_0"][-1]['x'] = 65.0
        newSortedData["PtNjets2p5_0"][-1]['errx'] = 20.0
        adjustLastBin = (13000.0 - 45.0)/40.0
        newSortedData["PtNjets2p5_0"][-1]['y'] = newSortedData["PtNjets2p5_0"][-1]['y']*adjustLastBin
        newSortedData["PtNjets2p5_0"][-1]['ySM'] = newSortedData["PtNjets2p5_0"][-1]['ySM']*adjustLastBin
        newSortedData["PtNjets2p5_0"][-1]['erryup'] = newSortedData["PtNjets2p5_0"][-1]['erryup']*adjustLastBin
        newSortedData["PtNjets2p5_0"][-1]['errydown'] = newSortedData["PtNjets2p5_0"][-1]['errydown']*adjustLastBin
        newSortedData["PtNjets2p5_0"][-1]['erryup_statOnly'] = newSortedData["PtNjets2p5_0"][-1]['erryup_statOnly']*adjustLastBin
        newSortedData["PtNjets2p5_0"][-1]['errydown_statOnly'] = newSortedData["PtNjets2p5_0"][-1]['errydown_statOnly']*adjustLastBin
        

        newSortedData["PtNjets2p5_1"]=sortedData[3:6]
        for t in  newSortedData["PtNjets2p5_1"]:
            t['x'] = t['x']-13000.0
        newSortedData["PtNjets2p5_1"][-1]['x'] = 150.0
        newSortedData["PtNjets2p5_1"][-1]['errx'] = 30.0
        adjustLastBin = (13000.0 - 120.0)/60.0
        newSortedData["PtNjets2p5_1"][-1]['y'] = newSortedData["PtNjets2p5_1"][-1]['y']*adjustLastBin
        newSortedData["PtNjets2p5_1"][-1]['ySM'] = newSortedData["PtNjets2p5_1"][-1]['ySM']*adjustLastBin
        newSortedData["PtNjets2p5_1"][-1]['erryup'] = newSortedData["PtNjets2p5_1"][-1]['erryup']*adjustLastBin
        newSortedData["PtNjets2p5_1"][-1]['errydown'] = newSortedData["PtNjets2p5_1"][-1]['errydown']*adjustLastBin
        newSortedData["PtNjets2p5_1"][-1]['erryup_statOnly'] = newSortedData["PtNjets2p5_1"][-1]['erryup_statOnly']*adjustLastBin
        newSortedData["PtNjets2p5_1"][-1]['errydown_statOnly'] = newSortedData["PtNjets2p5_1"][-1]['errydown_statOnly']*adjustLastBin


        newSortedData["PtNjets2p5_1plus"]=sortedData[6:9]
        for t in  newSortedData["PtNjets2p5_1plus"]:
            t['x'] = t['x']-26000.0
        newSortedData["PtNjets2p5_1plus"][-1]['x'] = 400.0
        newSortedData["PtNjets2p5_1plus"][-1]['errx'] = 50.0
        print 'newSortedData'
        print newSortedData
    else:
        newSortedData[options.variable]=sortedData
    for obs in newSortedData.keys():
        sortedData=newSortedData[obs]
        if options.hideFirstBin:
            sortedData=sortedData[1:]
        print "newSortedData"
        print sortedData
        graph = TGraphAsymmErrors( len(sortedData), array('d', [a['x'] for a in sortedData]), array('d', [a['y'] for a in sortedData]), array('d', [a['errx'] for a in sortedData] ),array('d', [a['errx'] for a in sortedData]), array('d',[a['errydown'] for a in sortedData]), array('d', [a['erryup'] for a in sortedData]) )
        ErrDown = [a['errydown'] for a in sortedData]
        ErrUp = [a['erryup'] for a in sortedData]
        graph.SetName("graph_"+obs)
        graph.SetTitle("")
        graph.Print("all")
    #    graph.SetMarkerStyle(20)
    #    graph.SetMarkerSize(1.1)
#        graph.SetLineColor(myColorA0)
#        graph.SetFillColor(myColorA1)
        graph.SetMarkerStyle(20)
        graph.SetMarkerColor(kBlack)
        graph.SetMarkerSize(0.6)
        graph.SetLineColor(1)
        graph.SetFillColor(1)
#        graph.SetFillStyle(3001)
        c1= TCanvas()
#        c1.SetBottomMargin(0.15)
#        c1.SetLeftMargin(0.15)
        pads=splitCanvas(c1)
        pads[0].cd()
        graph.Draw("a2")
        graph.GetXaxis().SetTitle(obs)
##        if (obs in xlabels.keys()):
##            print "variable "+str(obs)+" has a label for xaxis"
##            print "setting xlabel to "+str(xlabels[obs])
##            graph.GetXaxis().SetTitle(xlabels[obs])
##    ###        graph.GetXaxis().SetTitleSize(1.2)
        graph.GetYaxis().SetTitle("d #sigma_{fid} / d x")
        if (obs in observables.keys()):
            if 'ylabel' in observables[obs].keys():
                print "variable "+str(obs)+" has a label for yaxis"
                print "setting ylabel to "+str(observables[obs]['ylabel'])
                graph.GetYaxis().SetTitle(observables[obs]['ylabel'])
        graph.GetXaxis().SetTitleFont(43)
        graph.GetYaxis().SetTitleFont(43)
        graph.GetXaxis().SetTitleSize(20)
        graph.GetYaxis().SetTitleSize(20)
        graph.GetYaxis().SetTitleOffset(1.16)
        graph.GetXaxis().SetTitleOffset(1.14)
        graph.GetYaxis().SetLabelSize(0.06)
        graph.GetXaxis().SetLabelSize(0.000)
        graph.GetYaxis().SetRangeUser(0., xsecMax*3.5 )
        if options.logy:
            pads[0].SetLogy()
            graph.GetYaxis().SetRangeUser(xsecMin/8., xsecMax*13. )

    #    graph.GetYaxis().SetRangeUser(0.0,2.0)
    #    graph.GetYaxis().SetTitleSize(1.2)
    #    graph.GetXaxis().SetTitleSize(1.2)
        graph.Draw("ap")
        def safeSquareSubtraction(x1,x2):
            if x1**2 - x2**2 >= 0:
                return np.sqrt(x1**2 -x2**2)
            else:
                return 1e-06
        graphSysts = TGraphAsymmErrors( len(sortedData), array('d', [a['x'] for a in sortedData]), array('d', [a['y'] for a in sortedData]), array('d', [a['errx'] for a in sortedData] ),array('d', [ a['errx'] for a in sortedData]), array('d', [safeSquareSubtraction(a['errydown'], a['errydown_statOnly']) for a in sortedData]), array('d', [safeSquareSubtraction(a['erryup'], a['erryup_statOnly']) for a in sortedData]) )
        print "graphSysts"
        graphSysts.Print()
        shadedBlue= TColor.GetColorTransparent(myColorB1, 0.6)
        graphSysts.SetLineColor(shadedBlue)
        graphSysts.SetFillColor(shadedBlue)
#        graphSysts.SetFillStyle(3001)
        graphSysts.Draw("2same")
        graphLine = TGraphAsymmErrors(graph.GetN(), graph.GetX(), array('d', [a['ySM'] for a in sortedData]), graph.GetEXhigh(), graph.GetEXlow(), array('d',[0]*graph.GetN()), array('d',[0]*graph.GetN()))
        graphLine.Print("all")
        graphLine.SetLineColor(myColorA0)
        graphLine.SetLineWidth(2)
        graphLine.SetMarkerSize(0)
    
        
        graphLine.SetName(graph.GetName()+"_line")
    #    gStyle.SetErrorY(0.)
        graphLine.Draw("psame")
        graph.Draw("psame")
#        graph.Draw("a2same")
    #    histo = graph.GetHistogram()
    #    histo.SetLineColor(myColorA0)
    #    histo.Print("all")
    #    histo.Draw('histsame')
        legRight = TLegend(0.58,0.60,0.85,0.82)
        legRight.SetFillStyle(0)
        legRight.SetBorderSize(0)
        legRight.AddEntry(graphLine, 'aMC@NLO + NNLOPS', 'l')
        legRight.AddEntry(graph, 'Best fit, stat #oplus syst unc.', 'l')
        legRight.AddEntry(graphSysts, 'Syst unc.', 'f')


        legLeft = TLegend(0.22,0.60,0.46,0.82)
        legLeft.SetFillStyle(0)
        legLeft.SetBorderSize(0)
        legLeft.AddEntry(graphLine, 'aMC@NLO + NNLOPS', 'l')
        legLeft.AddEntry(graph, 'Best fit, stat #oplus syst unc.', 'l')
        legLeft.AddEntry(graphSysts, 'Syst unc.', 'f')

        tex_m=TLatex()
        tex_m.SetNDC()
        tex_m.SetTextAlign(12)
        tex_m.SetTextFont(42)
        tex_m.SetTextSize(0.038)
    #        tex_m.SetLineWidth(2)



        if (obs in observables.keys()):
            if 'legend' in observables[obs].keys():
                print "variable "+str(obs)+" has legend option"
                if observables[obs]['legend'] == 'r':
                    legRight.Draw()
                    tex_m.DrawLatex(0.59,0.845,"LHC HXSWG YR4, m_{H}=125.09")
                elif observables[obs]['legend'] == 'l':
                    legLeft.Draw()
                    tex_m.DrawLatex(0.23,0.845,"LHC HXSWG YR4, m_{H}=125.09")
                else:
                    legRight.Draw()
                    tex_m.DrawLatex(0.59,0.845,"LHC HXSWG YR4, m_{H}=125.09")

        else:
            legRight.Draw()
            tex_m.DrawLatex(0.59,0.845,"LHC HXSWG YR4, m_{H}=125.09")

        tex_m=TLatex()
        tex_m.SetNDC()
        tex_m.SetTextAlign(12)
        tex_m.SetTextFont(42)
        tex_m.SetTextSize(0.075)
        tex_m.SetLineWidth(2)
#        tex_m.DrawLatex(0.18,0.93,"#bf{CMS}, #it{Preliminary})"
        tex_m.DrawLatex(0.15,0.94,"#bf{CMS}")
            
        tex_m=TLatex()
        tex_m.SetNDC()
        tex_m.SetTextAlign(12)
        tex_m.SetTextFont(42)
        tex_m.SetTextSize(0.065)
    #        tex_m.SetLineWidth(2)
        tex_m.DrawLatex(0.68,0.94,"35.9 fb^{-1} (13 TeV)")


        if scaleLastBin != 1.:
            tex_m=TLatex()
            tex_m.SetNDC()
            tex_m.SetTextAlign(12)
            tex_m.SetTextFont(42)
            tex_m.SetTextSize(0.03)
    #        tex_m.SetLineWidth(2)
            tex_m.DrawLatex(0.85,0.85,"SF =%s"%scaleLastBin)
        pads[1].cd()
        pads[1].SetGridy()
        ratio = TGraphAsymmErrors(graph.GetN(), graph.GetX(), array('d', [a['y']/a['ySM'] for a in sortedData]), graph.GetEXhigh(), graph.GetEXlow(), array('d',[a['errydown']/a['ySM'] for a in sortedData]), array('d', [a['erryup']/a['ySM'] for a in sortedData]) )
        ratio.GetYaxis().SetRangeUser(-0.5,2.5)
        ratio.SetMarkerStyle(20)
        ratio.SetMarkerColor(kBlack)
        ratio.SetMarkerSize(0.6)
        print "ratio graph"
        ratio.Print("all")
        ratio.Draw("ap")
        if (obs in observables.keys()):
            if 'xlabel' in observables[obs].keys():
                print "variable "+str(obs)+" has a label for xaxis"
                print "setting xlabel to "+str(observables[obs]['xlabel'])
                ratio.GetXaxis().SetTitle(observables[obs]['xlabel'])
    ###        graph.GetXaxis().SetTitleSize(1.2)
        ratio.GetYaxis().SetTitle("Observed/expected")
        ratio.GetXaxis().SetTitleFont(43)
        ratio.GetYaxis().SetTitleFont(43)
        ratio.GetXaxis().SetTitleSize(20)
        ratio.GetYaxis().SetTitleSize(14)
        ratio.GetYaxis().SetTitleOffset(1.7)
        ratio.GetXaxis().SetTitleOffset(2.6)
        ratio.GetYaxis().SetLabelSize(0.083)
        ratio.GetXaxis().SetLabelSize(0.107)
        ratio.Draw("ap")
        for fmt in savefmts:
            savename = str(options.outdir)+"/expectedPrecisionNNLOPS_ub_"+str(obs) 
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
        out_file.write(str(obs)+"	"+str(numberOfBins)+"	"+str(MeanError)+"	"+str(StdDevError)+"	"+str(MedianError)+"	"+str(Quant25Error)+"	"+str(Quant75Error)+"\n")
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
    

def splitCanvas(c):
    pads=[]
    pads.append(TPad("pad1","pad1",0,0.35,1.,1.))
    pads.append(TPad("pad2","pad2",0,0.0,1.,0.35))
    pads[0].SetBottomMargin(0.0125)
    pads[1].SetBottomMargin(0.3)
    pads[0].SetLeftMargin(0.15)
    pads[1].SetLeftMargin(0.15)
    for pad in pads:
        pad.Draw()
    return pads        
    
    
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
            make_option("-F", "--filesFreezeNuis",
                        action="store", type="string", dest="filesFreezeNuis",
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
            make_option("-s", "--spectrum",
                        action="store_true", dest="spectrum",
                        default=False,
                        ),

            ])

    (options, args) = parser.parse_args()

    sys.argv.append("-b")
    main(options, args)






