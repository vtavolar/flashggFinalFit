#!/usr/bin/env python2.7
###!/usr/bin/env python
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

def system(exec_line):
  #print "[INFO] defining exec_line"
  #if options.verbose: print '\t', exec_line
  os.system(exec_line)

def getSystLabels(isMET):
    phosystlabels=[]
    jetsystlabels=[]
    metsystlabels=[]
    systlabels=[]
    for direction in ["Up","Down"]:
        phosystlabels.append("MvaShift%s01sigma" % direction)
        phosystlabels.append("SigmaEOverEShift%s01sigma" % direction)
#        phosystlabels.append("MaterialCentral%s01sigma" % direction)
        phosystlabels.append("MaterialForward%s01sigma" % direction)
        phosystlabels.append("FNUFEB%s01sigma" % direction)
        phosystlabels.append("FNUFEE%s01sigma" % direction)
        phosystlabels.append("MCScaleGain6EB%s01sigma" % direction)
        phosystlabels.append("MCScaleGain1EB%s01sigma" % direction)
        jetsystlabels.append("JEC%s01sigma" % direction)
        jetsystlabels.append("JER%s01sigma" % direction)
        jetsystlabels.append("PUJIDShift%s01sigma" % direction)        
        metsystlabels.append("metJecUncertainty%s01sigma" % direction)
        metsystlabels.append("metJerUncertainty%s01sigma" % direction)
        metsystlabels.append("metPhoUncertainty%s01sigma" % direction)
        metsystlabels.append("metUncUncertainty%s01sigma" % direction)
        for r9 in ["HighR9","LowR9"]:
            for region in ["EB","EE"]:
                phosystlabels.append("ShowerShape%s%s%s01sigma"%(r9,region,direction))
                phosystlabels.append("MCScale%s%s%s01sigma" % (r9,region,direction))
                for var in ["Rho","Phi"]:
                    phosystlabels.append("MCSmear%s%s%s%s01sigma" % (r9,region,var,direction))
    systlabels += phosystlabels
    systlabels += jetsystlabels
    if isMET:
      systlabels += metsystlabels
    return systlabels

def writeJob(jobId, folder, label, inputfile, outputfile, jsonfile):
#    job_file = open('%s/SignalFitJobs/sub%d.sh'%(options.outDir,counter),'w')
    job_file = open('%s/sub%d.sh'%(folder,jobId),'w')


    job_file.write("#!/bin/bash\n")
    job_file.write('touch %s.run\n'%os.path.abspath(job_file.name))
    job_file.write('cd %s/%s\n'%(os.getcwd(),folder))

    job_file.write('source $VO_CMS_SW_DIR/cmsset_default.sh\n')
    job_file.write('source /mnt/t3nfs01/data01/swshare/glite/external/etc/profile.d/grid-env.sh\n')
    job_file.write('export SCRAM_ARCH=slc6_amd64_gcc491\n')
    job_file.write('export LD_LIBRARY_PATH=/swshare/glite/d-cache/dcap/lib/:$LD_LIBRARY_PATH\n')
    job_file.write('eval `scramv1 runtime -sh`\n')


    exec_line = "python $CMSSW_BASE/src/flashggFinalFit/Signal/reduceWs.py --verbose -f %s --load $CMSSW_BASE/src/flashggFinalFit/Signal/%s --outfile %s --label %s" %(inputfile, jsonfile, outputfile, label)
    job_file.write('\t echo "PREPARING TO RUN "\n')
    job_file.write('if ( %s ) then\n'%exec_line)
    job_file.write('\t echo "DONE" \n')
    job_file.write('\t touch %s.done\n'%os.path.abspath(job_file.name))
    job_file.write('else\n')
    job_file.write('\t echo "FAIL" \n')
    job_file.write('\t touch %s.fail\n'%os.path.abspath(job_file.name))
    job_file.write('fi\n')
#    job_file.write('cd -\n')
    job_file.write('\t echo "RM RUN "\n')
    job_file.write('rm -f %s.run\n'%os.path.abspath(job_file.name))
#    job_file.write('rm -rf scratch_$number\n')
    job_file.close()
    system('chmod +x %s'%os.path.abspath(job_file.name))
    if options.queue:
        system('rm -f %s.done'%os.path.abspath(job_file.name))
        system('rm -f %s.fail'%os.path.abspath(job_file.name))
        system('rm -f %s.log'%os.path.abspath(job_file.name))
        system('rm -f %s.err'%os.path.abspath(job_file.name))
        if (options.batch == "LSF") : system('bsub -q %s -o %s.log %s'%(options.queue,os.path.abspath(job_file.name),os.path.abspath(job_file.name)))
        if (options.batch == "T3CH") : 
            if label == 'nominal' or label == 'pdfWeights':
                system('qsub -q %s -l h_vmem=6g -o %s.log -e %s.err %s'%(options.queue,os.path.abspath(job_file.name),os.path.abspath(job_file.name),os.path.abspath(job_file.name)))
            else:
                system('qsub -q %s -o %s.log -e %s.err %s'%(options.queue,os.path.abspath(job_file.name),os.path.abspath(job_file.name),os.path.abspath(job_file.name)))
        if (options.batch == "IC") : 
            system('qsub -q %s -o %s.log -e %s.err %s'%(options.queue,os.path.abspath(job_file.name),os.path.abspath(job_file.name),os.path.abspath(job_file.name)))
#    if options.runLocal:
#        system('bash %s'%os.path.abspath(job_file.name))





def main(o,args):
  isMET=False
  if ("MET" in  options.outdir):
    isMET=True
  if options.doSysts:
      syslabels = getSystLabels(isMET)
  else:
      syslabels = []
  syslabels.append("nominal")
  if options.doPdfWeights:
      syslabels.append("pdfWeights")
  counter = 0
  if not os.path.exists(options.outdir):
    os.makedirs(options.outdir)
  for label in syslabels:

      writeJob(counter, options.outdir, label, options.infile, options.outfile, options.json)        
      counter = counter+1


if __name__ == "__main__":
    parser = OptionParser(option_list=[

            make_option("-q", "--queue",
                        action="store", type="string", dest="queue",
                        default="",
                        ),
            make_option("-i", "--infile",
                        action="store", type="string", dest="infile",
                        default="in.root",
                        ),
            make_option("-o", "--outfile",
                        action="store", type="string", dest="outfile",
                        default="out.root",
                        ),
            make_option("-j", "--json",
                        action="store", type="string", dest="json",
                        default="a.json",
                        ),
            make_option("-b", "--batch",
                        action="store", type="string", dest="batch",
                        default="T3CH",
                        ),
            make_option("-S", "--doSysts",
                        action="store_true", dest="doSysts",
                        default=False,
                        ),
            make_option("-P", "--doPdfWeights",
                        action="store_true", dest="doPdfWeights",
                        default=False,
                        ),
            make_option("-O", "--outdir",
                        action="store", dest="outdir",
                        default="./",
                        )

            ])

    (options, args) = parser.parse_args()

    sys.argv.append("-b")
    main(options, args)
