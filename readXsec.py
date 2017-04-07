
def getXSgraph(scope=""):
    import math
    xsecs={}
    xsecs["ggh"]={}
    xsecs["vbfh"]={}
    xsecs["zh"]={}
    xsecs["wh"]={}
    xsecs["tth"]={}
    masses=[]
    f = open('/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/HiggsAnalysis/CombinedLimit/data/lhc-hxswg/sm/xs/13TeV/13TeV-ggH.txt')
    lines = f.readlines()
    for l in lines:
    #    print l
        if l.startswith('mH'):
            continue
#        print 'mass'+str(l.split(' ')[0])
        masses.append(l.split(' ')[0])
    #    xsecs["ggh"][l.split(' ')[0]]= [i for i in l.split()]
        eup = math.sqrt(float(l.split()[4])**2 + float(l.split()[5])**2)
        edown = math.sqrt(float(l.split()[4])**2 + float(l.split()[5])**2)
        xsecs["ggh"][l.split(' ')[0]]= [float(l.split()[1]), eup/100., edown/100.]
    
    metadata={}
    metadata['vbfh']=dict(filename='/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/HiggsAnalysis/CombinedLimit/data/lhc-hxswg/sm/xs/13TeV/13TeV-vbfH.txt')
    metadata['zh']=dict(filename='/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/HiggsAnalysis/CombinedLimit/data/lhc-hxswg/sm/xs/13TeV/13TeV-ZH.txt')
    metadata['wh']=dict(filename='/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/HiggsAnalysis/CombinedLimit/data/lhc-hxswg/sm/xs/13TeV/13TeV-WH.txt')
    metadata['tth']=dict(filename='/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/HiggsAnalysis/CombinedLimit/data/lhc-hxswg/sm/xs/13TeV/13TeV-ttH.txt')
    
    for proc in metadata.keys():
        #        print proc
        f = open(metadata[proc]['filename'])
        lines = f.readlines()
        for l in lines:
            if l.startswith('mH'):
                continue
            #    print 'mass'+str(l.split(' ')[0])
            l.replace('\t',' ')
            #        print l.split()[2]
            eup = math.sqrt(float(l.split()[2])**2 + float(l.split()[5])**2 + float(l.split()[6])**2)
            edown = math.sqrt(float(l.split()[3])**2 + float(l.split()[5])**2 + float(l.split()[6])**2)
            xsecs[proc][l.split()[0]]= [float(l.split()[1]),eup/100., edown/100.]
    #    print proc
    #    print xsecs[proc]
        
    
    #print xsecs["ggh"]
    
    
#    print xsecs['ggh']['126.00'][0],xsecs['vbfh']['126.00'][0],xsecs['wh']['126.00'][0],xsecs['zh']['126.00'][0],xsecs['tth']['126.00'][0]


    f = open('/mnt/t3nfs01/data01/shome/vtavolar/FinalFits/CMSSW_7_1_5/src/flashggFinalFit/br.txt')
    lines = f.readlines()
    BR={}
    for l in lines:
        if l.startswith('mH') \
                or l.startswith('#'):
            continue
        #    print 'mass'+str(l.split(' ')[0])
        l.replace('\t',' ')
#        print l.split()
        BR["%.2f" %(float(l.split()[0]))] = [float(l.split()[1]), math.sqrt(float(l.split()[2])**2 + float(l.split()[4])**2 +  float(l.split()[6])**2), math.sqrt(float(l.split()[3])**2 + float(l.split()[5])**2 +  float(l.split()[7])**2)]
#        print "%.2f" %(float(l.split()[0]))
#    print BR
    
    totxsec=[]
    mass=[]
    empty=[]
    euptotxsec=[]
    edowntotxsec=[]
#    masses.remove("125.09")
    for m in masses:
        xs = (xsecs["ggh"][str(m)][0] + xsecs["vbfh"][str(m)][0] + xsecs["zh"][str(m)][0] + xsecs["wh"][str(m)][0] + xsecs["tth"][str(m)][0])*BR[str(m)][0]
        eup = math.sqrt(
            (xsecs["ggh"][str(m)][0]*xsecs["ggh"][str(m)][1])**2
            +(xsecs["vbfh"][str(m)][0]*xsecs["vbfh"][str(m)][1])**2
            +(xsecs["zh"][str(m)][0]*xsecs["zh"][str(m)][1])**2
            +(xsecs["wh"][str(m)][0]*xsecs["wh"][str(m)][1])**2
            +(xsecs["tth"][str(m)][0]*xsecs["tth"][str(m)][1])**2
            )
        edown = math.sqrt(
            (xsecs["ggh"][str(m)][0]*xsecs["ggh"][str(m)][2])**2
            +(xsecs["vbfh"][str(m)][0]*xsecs["vbfh"][str(m)][2])**2
            +(xsecs["zh"][str(m)][0]*xsecs["zh"][str(m)][2])**2
            +(xsecs["wh"][str(m)][0]*xsecs["wh"][str(m)][2])**2
            +(xsecs["tth"][str(m)][0]*xsecs["tth"][str(m)][2])**2
            )
        mass.append(float(m))
        totxsec.append(xs*1.0*1000)
        euptotxsec.append(  1.0*1000*math.sqrt( (eup*BR[str(m)][0])**2 + (BR[str(m)][1]*0.01*(xs))**2 ) )      
        edowntotxsec.append(  1.0*1000*math.sqrt(  (edown*BR[str(m)][0])**2 + (BR[str(m)][2]*0.01*(xs))**2 ) ) 
        empty.append(0.)

    import numpy
    import ROOT
    from ROOT import *

    if "HX" in scope:
        HXxsec=[]
        mass=[]
        empty=[]
        eupHXxsec=[]
        edownHXxsec=[]
    #    masses.remove("125.09")
        for m in masses:
##            print "mass ",m
            xs = ( xsecs["vbfh"][str(m)][0] + xsecs["zh"][str(m)][0] + xsecs["wh"][str(m)][0] + xsecs["tth"][str(m)][0])*BR[str(m)][0]
            print "xs ",xs
            print "xs and err, up, vbf "+str(xsecs["vbfh"][str(m)][0])+" "+str(xsecs["vbfh"][str(m)][1])+" "+str(xsecs["vbfh"][str(m)][1]/xsecs["vbfh"][str(m)][0])
            print "xs and err, up, zh "+str(xsecs["zh"][str(m)][0]  )+" "+str(xsecs["zh"][str(m)][1])+" "+str(xsecs["zh"][str(m)][1]/xsecs["zh"][str(m)][0])
            print "xs and err, up, wh "+str(xsecs["wh"][str(m)][0]  )+" "+str(xsecs["wh"][str(m)][1])+" "+str(xsecs["wh"][str(m)][1]/xsecs["wh"][str(m)][0])
            print "xs and err, up, tth "+str(xsecs["tth"][str(m)][0] )+" "+str(xsecs["tth"][str(m)][1])+" "+str(xsecs["tth"][str(m)][1]/xsecs["tth"][str(m)][0])

            print "xs and err, up, vbf "+str(xsecs["vbfh"][str(m)][0])+" "+str(xsecs["vbfh"][str(m)][2])+" "+str(xsecs["vbfh"][str(m)][2]/xsecs["vbfh"][str(m)][0])
            print "xs and err, up, zh "+str(xsecs["zh"][str(m)][0]  )+" "+str(xsecs["zh"][str(m)][2])+" "+str(xsecs["zh"][str(m)][2]/xsecs["zh"][str(m)][0])
            print "xs and err, up, wh "+str(xsecs["wh"][str(m)][0]  )+" "+str(xsecs["wh"][str(m)][2])+" "+str(xsecs["wh"][str(m)][2]/xsecs["wh"][str(m)][0])
            print "xs and err, up, tth "+str(xsecs["tth"][str(m)][0] )+" "+str(xsecs["tth"][str(m)][2])+" "+str(xsecs["tth"][str(m)][2]/xsecs["tth"][str(m)][0])

            eup = math.sqrt( 
                (xsecs["vbfh"][str(m)][0]*xsecs["vbfh"][str(m)][1])**2
                +(xsecs["zh"][str(m)][0]*xsecs["zh"][str(m)][1])**2
                +(xsecs["wh"][str(m)][0]*xsecs["wh"][str(m)][1])**2
                +(xsecs["tth"][str(m)][0]*xsecs["tth"][str(m)][1])**2
                )
            print "eup ", eup
            edown = math.sqrt(
                (xsecs["vbfh"][str(m)][0]*xsecs["vbfh"][str(m)][2])**2
                +(xsecs["zh"][str(m)][0]*xsecs["zh"][str(m)][2])**2
                +(xsecs["wh"][str(m)][0]*xsecs["wh"][str(m)][2])**2
                +(xsecs["tth"][str(m)][0]*xsecs["tth"][str(m)][2])**2
            )
            print "edown ", edown
            mass.append(float(m))
            HXxsec.append(xs*1.0*1000)
            eupHXxsec.append(  1.0*1000*math.sqrt( (eup*BR[str(m)][0])**2 + (BR[str(m)][1]*0.01*(xs))**2 ) )      
            edownHXxsec.append(  1.0*1000*math.sqrt(  (edown*BR[str(m)][0])**2 + (BR[str(m)][2]*0.01*(xs))**2 ) ) 
            empty.append(0.)
            print "xsec ",HXxsec[-1]
            print "eup combined with BR ",eupHXxsec[-1]
            print "edown combined with BR ",edownHXxsec[-1]
            print "BR ",BR
        g_HX = TGraphAsymmErrors(len(mass), numpy.asarray(mass), numpy.asarray(HXxsec), numpy.asarray(empty), numpy.asarray(empty), numpy.asarray(eupHXxsec), numpy.asarray(edownHXxsec))    



    if "ggH" in scope:
        ggHxsec=[]
        mass=[]
        empty=[]
        eupggHxsec=[]
        edownggHxsec=[]
    #    masses.remove("125.09")
        for m in masses:
##            print "mass ",m
            xs = ( xsecs["ggh"][str(m)][0])*BR[str(m)][0]
            print "xs ",xs
            eup = math.sqrt( 
                (xsecs["ggh"][str(m)][0]*xsecs["ggh"][str(m)][1])**2
                )
##            print "eup ", eup
            edown = math.sqrt(
                (xsecs["ggh"][str(m)][0]*xsecs["ggh"][str(m)][2])**2
            )
##            print "edown ", edown
            mass.append(float(m))
            ggHxsec.append(xs*1.0*1000)
            eupggHxsec.append(  1.0*1000*math.sqrt( (eup*BR[str(m)][0])**2 + (BR[str(m)][1]*0.01*(xs))**2 ) )      
            edownggHxsec.append(  1.0*1000*math.sqrt(  (edown*BR[str(m)][0])**2 + (BR[str(m)][2]*0.01*(xs))**2 ) ) 
            empty.append(0.)
        g_ggH = TGraphAsymmErrors(len(mass), numpy.asarray(mass), numpy.asarray(ggHxsec), numpy.asarray(empty), numpy.asarray(empty), numpy.asarray(eupggHxsec), numpy.asarray(edownggHxsec))    



    
    g = TGraphAsymmErrors(len(mass), numpy.asarray(mass), numpy.asarray(totxsec), numpy.asarray(empty), numpy.asarray(empty), numpy.asarray(euptotxsec), numpy.asarray(edowntotxsec))

    
##    g.Print()
    c= TCanvas()
    g.SetLineColor(kRed)
    g.SetLineWidth(2)
    g.Draw("ale3")
#    c.SaveAs("xsecs_unc.pdf")
    if "HX" in scope:
        return g_HX
    if "ggH" in scope:
        return g_ggH
    else:
        return g

getXSgraph("HX")
