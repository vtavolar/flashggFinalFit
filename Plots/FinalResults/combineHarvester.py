#!/usr/bin/env python

import os
import numpy
import sys
import fnmatch
from copy import deepcopy as copy
import re

from optparse import OptionParser
from optparse import OptionGroup


from Queue import Queue

from threading import Thread, Semaphore
from multiprocessing import cpu_count

class Wrap:
    def __init__(self, func, args, queue):
        self.queue = queue
        self.func = func
        self.args = args
        
    def __call__(self):
        ret = self.func( *self.args )
        self.queue.put( ret  )

    
class Parallel:
    def __init__(self,ncpu):
        self.running = Queue(ncpu)
        self.returned = Queue()
        self.njobs = 0
  
    def run(self,cmd,args):
        wrap = Wrap( self, (cmd,args), self.returned )
        self.njobs += 1
        thread = Thread(None,wrap)
        thread.start()
        
    def __call__(self,cmd,args):
        if type(cmd) == str:
            print cmd
            for a in args:
                cmd += " %s " % a
            args = (cmd,)
            cmd = commands.getstatusoutput
        self.running.put((cmd,args))
        ret = cmd( *args ) 
        self.running.get()
        self.running.task_done()
        return ret

def getFilesFromDatacard(datacard):
    card = open(datacard,"r")
    files = set()
    for l in card.read().split("\n"):
        if l.startswith("shape"):
            toks = [t for t in l.split(" ") if t != "" ]
            files.add(toks[3])
    files = list(files)
    ret = files[0]
    for f in files[1:]:
        ret += ",%s" % f
    return ret

parser = OptionParser()
parser.add_option("-d","--datfile",help="Pick up running options from datfile")
parser.add_option("-q","--queue",help="Which batch queue")
parser.add_option("--dryRun",default=False,action="store_true",help="Dont submit")
parser.add_option("--parallel",default=False,action="store_true",help="Run local fits in multithreading")
parser.add_option("--runLocal",default=False,action="store_true",help="Run locally")
parser.add_option("--skipWorkspace",default=False,action="store_true",help="Dont remake MultiDim workspace")
parser.add_option("--hadd",help="Trawl passed directory and hadd files. To be used when jobs are complete.")
parser.add_option("-v","--verbose",default=False,action="store_true")
parser.add_option("--poix",default="r")
parser.add_option("--S0",default=False,action="store_true",help="Stats only")
parser.add_option("--catsMap",default="")
parser.add_option("--nBins",default=7)
parser.add_option("--mhRange",default=-1)
parser.add_option("--batch",default="LSF",help="Which batch system to use (LSF,IC)")
parser.add_option("--catRanges",default="")
parser.add_option("--prefix",default="./")
parser.add_option("--freezeAll",default=False,action="store_true",help="Freeze all nuisances")
parser.add_option("--float",default="",action="store",help="Freeze all nuisances")
parser.add_option("--postFitAll",default=False,action="store_true",help="Use post-fit nuisances for all methods")
#parser.add_option("--blindStd",default=False,action="store_true",help="Run standard suite of blind plots")
#parser.add_option("--unblindSimple",default=False,action="store_true",help="Run simple set of unblind plots (limit, pval, best fit mu)")
#parser.add_option("--unblindFull",default=False,action="store_true",help="Run full suite of unblind plots")
specOpts = OptionGroup(parser,"Specific options")
specOpts.add_option("--datacard",default=None)
specOpts.add_option("--files",default=None)
specOpts.add_option("--outDir",default=None)
specOpts.add_option("--method",default=None)
specOpts.add_option("--catName",default="", type="string")
specOpts.add_option("--expected",type="int",default=None)
specOpts.add_option("--mh",type="float",default=None)
specOpts.add_option("--mhLow",type="float",default=None)
specOpts.add_option("--mhHigh",type="float",default=None)
specOpts.add_option("--mhStep",type="float",default=None)
specOpts.add_option("--muLow",type="float",default=None)
specOpts.add_option("--muHigh",type="float",default=None)
specOpts.add_option("--rvLow",type="float",default=None)
specOpts.add_option("--rvHigh",type="float",default=None)
specOpts.add_option("--rfLow",type="float",default=None)
specOpts.add_option("--rfHigh",type="float",default=None)
specOpts.add_option("--cvLow",type="float",default=None)
specOpts.add_option("--cvHigh",type="float",default=None)
specOpts.add_option("--cfLow",type="float",default=None)
specOpts.add_option("--cfHigh",type="float",default=None)
specOpts.add_option("--kgamLow",type="float",default=None)
specOpts.add_option("--kgamHigh",type="float",default=None)
specOpts.add_option("--kgluLow",type="float",default=None)
specOpts.add_option("--kgluHigh",type="float",default=None)
specOpts.add_option("--wspace",type="str",default=None)
specOpts.add_option("--jobs",type="int",default=None)
specOpts.add_option("--pointsperjob",type="int",default=1)
specOpts.add_option("--expectSignal",type="float",default=None)
specOpts.add_option("--expectSignalMass",type="float",default=None)
specOpts.add_option("--splitChannels",default=None)
specOpts.add_option("--profileMH",default=False)
specOpts.add_option("--toysFile",default=None)
specOpts.add_option("--additionalOptions",default="",type="string")
specOpts.add_option("--postFit",default=False,action="store_true",help="Use post-fit nuisances")
parser.add_option_group(specOpts)
(opts,args) = parser.parse_args()
if not os.path.exists(os.path.expandvars('$CMSSW_BASE/bin/$SCRAM_ARCH/combine')):
  sys.exit('ERROR - CombinedLimit package must be installed')
if not os.path.exists(os.path.expandvars('$CMSSW_BASE/bin/$SCRAM_ARCH/text2workspace.py')):
  sys.exit('ERROR - CombinedLimit package must be installed')
if not os.path.exists(os.path.expandvars('$CMSSW_BASE/bin/$SCRAM_ARCH/combineCards.py')):
  sys.exit('ERROR - CombinedLimit package must be installed')

cwd = os.getcwd()
allowedMethods = ['Asymptotic','AsymptoticGrid','ProfileLikelihood','ChannelCompatibilityCheck','MultiPdfChannelCompatibility','MHScan','MHScanStat','MHScanNoGlob','MuScan','MuScanMHProf','RVScan','RFScan','RVRFScan','MuMHScan','GenerateOnly', 'RProcScan', 'RTopoScan', 'RBinScan', 'MuVsMHScan','CVCFScan','KGluKGamScan','MultiPdfMuHatvsMH']

if opts.parallel:
    parallel = Parallel(cpu_count())

if not opts.files and opts.datacard:
    opts.files = getFilesFromDatacard(opts.datacard)
    print "Here are the files"
    print opt.files

defaults = copy(opts)
print "INFO - queue ", opts.queue
def system(exec_line):
  #print "[INFO] defining exec_line"
  if opts.verbose: print '\t', exec_line
  os.system(exec_line)

def checkValidMethod():
  print "[INFO] checking valid methods"
  if opts.method not in allowedMethods: sys.exit('%s is not a valid method'%opts.method)

def configureMassFromNJobs():
  print "[INFO] configuring mass from number of jobs"
  if opts.mhLow and opts.mhHigh and opts.mhStep:
    masses = numpy.arange(opts.mhLow,opts.mhHigh+opts.mhStep,opts.mhStep)
    print "[INFO] -->masses: ", masses
    if len(masses)<opts.jobs: sys.exit("Can't have more masses than number of jobs")
    else:
      opts.masses_per_job = [[] for x in range(opts.jobs)]
      while len(masses)!=0:
        for j in range(opts.jobs):
          if len(masses)==0: break
          opts.masses_per_job[j].append(masses[0])
          masses = numpy.delete(masses,0)
    if len(opts.masses_per_job)!=opts.jobs: sys.exit('ERROR - len job config (%d) not equal to njobs (%d)'%(len(opts.masses_per_job),opts.jobs))

def strtodict(lstr):
  print "[INFO] string to dictionariy"
  retdict = {}
  if not len(lstr): return retdict
  objects = lstr.split(':')
  for o in objects:
    k,vs = o.split('[')
    vs = vs.rstrip(']')
    vs = vs.split(',')
    retdict[k] = [float(vs[0]),float(vs[1])]
  return retdict

catRanges = strtodict(opts.catRanges)

def getSortedCats():
  print "[INFO] sorting categories"
  cats = set()
  f = open(opts.datacard)
  for l in f.readlines():
    if l.startswith('bin'):
      #print l
      els = l.split()[1:]
      #print els
      for el in els: 
        cats.add(el)
      break
  
  #print " cats[0] ",  cats , "  cats[:]"
  #myarr = sorted(cats, key=lambda x: (x[:3],int(x.split('cat')[1].split('_')[0])), reverse=True)
  #myarr = sorted(cats, key=lambda x: (x[:3],x.split('_')[0]), reverse=True)
  myarr=sorted(cats)
  print "[INFO] -->categories", myarr
  if opts.verbose: print myarr
  return myarr

def removeRelevantDiscreteNuisances():
  print "[INFO] remove relevant discrete nuisances"
  newCard = open('tempcard.txt','w')
  card = open(opts.datacard)
  for line in card.readlines():
    if 'discrete' in line:
      for cat in opts.splitChannels:
        #catString = '_'+cat.split('cat')[1]
        catString = '_'+cat
        if catString in line: newCard.write(line)
    else: newCard.write(line)
  card.close()
  newCard.close()
  system('mv %s %s'%(newCard.name,card.name))

def splitCard():
  print "[INFO] splitting card"
  if not opts.splitChannels: sys.exit('Channel splitting options not specified')
  f = open(opts.datacard)
  allCats = set()
  for line in f.readlines():
    if line.startswith('bin'):
      for el in line.split()[1:]:
        allCats.add(el)
  f.close()
  if opts.verbose: print ' [INFO] -->Found these categories in card: ', allCats
  veto = ""
  for cat in allCats:
    if cat in opts.splitChannels: continue
    #else: veto += "|ch1_"+cat
    else: veto += "|"+cat
  veto=veto[1:]
  splitCardName = opts.datacard.replace('.txt','')
  for cat in opts.splitChannels: splitCardName += '_'+cat
  splitCardName += '.txt'
  print 'combineCards.py --xc="%s" %s > %s'%(veto,opts.datacard,splitCardName)
  system('combineCards.py --xc="%s" %s > %s'%(veto,opts.datacard,splitCardName))
  opts.datacard = splitCardName
  removeRelevantDiscreteNuisances()


def makeFloatMHCard():
     olddatacard=opts.datacard
     opts.datacard=olddatacard.replace(".txt",".mhRange.txt")
     f1 = open(olddatacard, "r")
     f2 = open(opts.datacard, "w")
     for line in f1:
        if ("imax") in line : line = "imax *\n" 
        if ("jmax") in line : line = "jmax *\n" 
        if ("kmax") in line : line = "kmax *\n" 
        f2.write(line)
     f2.write("MH param %.2f %.2f"%(opts.mh, opts.mhRange))
     f1.close()
     f2.close()

def makeStatOnlyCard():
  print "[INFO] making stats-only card"
  
  assert(opts.datacard.endswith('.txt'))
  newcardname = opts.datacard.replace('.txt','_statonly.txt') 
  outf = open(newcardname,'w')
  inf = open(opts.datacard)
  for line in inf.readlines():
    line_els = line.split()
    if line.startswith('kmax'): line = line.replace(line_els[1],'*')
    if len(line_els)>1 and (line_els[1]=='lnN' or line_els[1]=='param'): continue
    else: outf.write(line)
  inf.close()
  outf.close()
  opts.datacard = newcardname 

def makeNoGlobCard():
  
  print "[INFO] making _noglob card"
  
  assert(opts.datacard.endswith('.txt'))
  newcardname = opts.datacard.replace('.txt','_noglob.txt') 
  outf = open(newcardname,'w')
  inf = open(opts.datacard)
  for line in inf.readlines():
    line_els = line.split()
    if line.startswith('kmax'): line = line.replace(line_els[1],'*')
    if line.startswith('CMS_hgg_globalscale'): continue
    else: outf.write(line)
  inf.close()
  outf.close()
  opts.datacard = newcardname 

def writePreambleT3(sub_file):
  #print "[INFO] writing preamble"
  sub_file.write('#!/bin/bash\n')
  sub_file.write('touch %s.run\n'%os.path.abspath(sub_file.name))
  sub_file.write('cd %s\n'%os.getcwd())
  sub_file.write('source $VO_CMS_SW_DIR/cmsset_default.sh')
  sub_file.write('source /swshare/glite/external/etc/profile.d/grid-env.sh')
#  sub_file.write('eval `scramv1 runtime -sh`\n')
  #sub_file.write('cd -\n')
  sub_file.write('number=$RANDOM\n')
  sub_file.write('mkdir -p scratch_$number\n')
  sub_file.write('cd scratch_$number\n')
  sub_file.write('cp -p $CMSSW_BASE/bin/$SCRAM_ARCH/combine .\n')
  sub_file.write('cp -p %s .\n'%os.path.abspath(opts.datacard))
  if opts.toysFile: 
    for f in opts.toysFile.split(','):
      sub_file.write('cp -p %s .\n'%os.path.abspath(f))
  for file in opts.files.split(','):
    sub_file.write('cp -p %s .\n'%os.path.abspath(file))

def writePreamble(sub_file):
  #print "[INFO] writing preamble"
  sub_file.write('#!/bin/bash\n')
  sub_file.write('set -x\n')
  sub_file.write('touch %s.run\n'%os.path.abspath(sub_file.name))
  sub_file.write('cd %s\n'%os.getcwd())
  if (opts.batch == "IC"):
      sub_file.write('source $VO_CMS_SW_DIR/cmsset_default.sh\n')
      sub_file.write('source /mnt/t3nfs01/data01/swshare/glite/external/etc/profile.d/grid-env.sh\n')
      sub_file.write('export SCRAM_ARCH=slc6_amd64_gcc481\n')
      sub_file.write('export LD_LIBRARY_PATH=/swshare/glite/d-cache/dcap/lib/:$LD_LIBRARY_PATH\n')
  #if (opts.batch == "LSF"):
  sub_file.write('set +x\n') 
  sub_file.write('eval `scramv1 runtime -sh`\n')
  sub_file.write('set -x\n') 
  #sub_file.write('cd -\n')
  if (opts.batch == "IC" ) : sub_file.write('cd $TMPDIR\n')
  sub_file.write('number=$RANDOM\n')
  sub_file.write('mkdir -p scratch_$number\n')
  sub_file.write('cd scratch_$number\n')
  sub_file.write('ls $CMSSW_BASE/bin/$SCRAM_ARCH/combine\n')
  sub_file.write('cp -p $CMSSW_BASE/bin/$SCRAM_ARCH/combine .\n')
  sub_file.write('cp -p %s .\n'%os.path.abspath(opts.datacard))
  sub_file.write('mkdir /scratch/$USER\n')
  if opts.toysFile: 
    for f in opts.toysFile.split(','):
      sub_file.write('cp -p %s .\n'%os.path.abspath(f))
  for file in opts.files.split(','):
    sub_file.write('cp -p %s .\n'%os.path.abspath(file))

def writePostamble(sub_file, exec_line):

  #print "[INFO] writing to postamble"
  if opts.S0: exec_line += ' -S 0 '
  if (opts.batch == "IC"):
      exec_line += ' &> /scratch/$USER/wn_log.txt'
  sub_file.write('if ( %s ) then\n'%exec_line)
  sub_file.write('\t cp /scratch/$USER/wn_log.txt %s\n'%os.path.abspath(opts.outDir))
  sub_file.write('\t mv higgsCombine*.root %s\n'%os.path.abspath(opts.outDir))
  sub_file.write('\t touch %s.done\n'%os.path.abspath(sub_file.name))
  sub_file.write('else\n')
  sub_file.write('\t touch %s.fail\n'%os.path.abspath(sub_file.name))
  sub_file.write('fi\n')
  sub_file.write('rm -f %s.run\n'%os.path.abspath(sub_file.name))
  sub_file.write('cd -\n')
  sub_file.write('rm -rf scratch_$number\n')
  sub_file.close()
  system('chmod +x %s'%os.path.abspath(sub_file.name))
  if not opts.dryRun and opts.queue:
    system('rm -f %s.done'%os.path.abspath(sub_file.name))
    system('rm -f %s.fail'%os.path.abspath(sub_file.name))
    system('rm -f %s.log'%os.path.abspath(sub_file.name))
    if (opts.batch == "LSF") : system('bsub -q %s -o %s.log %s'%(opts.queue,os.path.abspath(sub_file.name),os.path.abspath(sub_file.name)))
    if (opts.batch == "IC") : system('qsub -l h_vmem=6g -q %s -o %s.log -e %s.err %s > out.txt'%(opts.queue,os.path.abspath(sub_file.name),os.path.abspath(sub_file.name),os.path.abspath(sub_file.name)))
    #if (opts.batch == "IC") : system('qsub %s -q %s -o %s.log '%(os.path.abspath(sub_file.name),opts.queue,os.path.abspath(sub_file.name)))
  if opts.runLocal:
    if opts.parallel:
                    tmpdir = "/tmp/%s/combineHarvester%d_%d" % ( os.getlogin(), os.getpid(), parallel.njobs )
                    system('mkdir -p %s'%tmpdir)
                    parallel.run(system,['cd %s; bash %s' % ( tmpdir, os.path.abspath(sub_file.name))])
    else:
                    system('bash %s'%os.path.abspath(sub_file.name))

def writeAsymptotic():
  print '[INFO] Writing Asymptotic'
  try:
    assert(opts.masses_per_job)
  except AssertionError:
    sys.exit('No masses have been defined')

  for j, mass_set in enumerate(opts.masses_per_job):
    file = open('%s/sub_job%d.sh'%(opts.outDir,j),'w')
    writePreamble(file)
    exec_line = ''
    for mass in mass_set:
      exec_line +=  'combine %s -M Asymptotic -m %6.2f --cminDefaultMinimizerType=Minuit2'%(opts.datacard,mass)
      if opts.S0: exec_line += ' --S0 '
      if opts.additionalOptions: exec_line += ' %s'%opts.additionalOptions
      if opts.expected: exec_line += ' --run=expected'
      if mass!=mass_set[-1]: exec_line += ' && '
    writePostamble(file,exec_line)

def writeAsymptoticGrid():
  print '[INFO] Writing AsymptoticGrid'
  
  if not os.path.exists(os.path.expandvars('$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/makeAsymptoticGrid.py')):
    sys.exit('ERROR - CombinedLimit package must be installed')
  
  try:
    assert(opts.masses_per_job)
  except AssertionError:
    sys.exit('No masses have been defined')
  
  # create specialised limit grid workspace
  if not opts.skipWorkspace:
    print '[INFO] Creating workspace for %s...'%opts.method
    ws_exec_line = 'text2workspace.py %s -o %s'%(os.path.abspath(opts.datacard),os.path.abspath(opts.datacard).replace('.txt','.root')) 
    #print ws_exec_line
    system(ws_exec_line)
  opts.datacard = opts.datacard.replace('.txt','.root')

  # sub jobs through combine
  for j, mass_set in enumerate(opts.masses_per_job):
    for mass in mass_set:
      system('python $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/makeAsymptoticGrid.py -w %s -m %6.2f -n 10 -r %3.1f %3.1f --runLimit --nCPU=3 -d %s'%(opts.datacard,mass,opts.muLow,opts.muHigh,os.path.abspath(opts.outDir)))
      sub_file_name = os.path.abspath(opts.outDir+'/limitgrid_%5.1f.sh'%(mass))
      if opts.verbose:
        if (opts.batch == "LSF") : print 'bsub -q %s -n 3 -R "span[hosts=1]" -o %s.log %s'%(opts.queue,os.path.abspath(sub_file_name),os.path.abspath(sub_file_name))
        if (opts.batch == "IC") : print 'qsub -q %s -n 3 -R "span[hosts=1]" -o %s.log %s'%(opts.queue,os.path.abspath(sub_file_name),os.path.abspath(sub_file_name))
        #if (opts.batch == "IC") : print 'qsub %s -q %s -n 3 -R "span[hosts=1]" -o %s.log '%(os.path.abspath(sub_file_name),opts.queue,os.path.abspath(sub_file_name))
      if not opts.dryRun and opts.queue:
        system('rm -f %s.log'%os.path.abspath(sub_file_name))
        if (opts.batch == "LSF") :    system('bsub -q %s -n 3 -R "span[hosts=1]" -o %s.log %s'%(opts.queue,os.path.abspath(sub_file_name),os.path.abspath(sub_file_name)))
        if (opts.batch == "IC") :    system('qsub -q %s -n 3 -R "span[hosts=1]" -o %s.log /%s'%(opts.queue,os.path.abspath(sub_file_name),os.path.abspath(sub_file_name)))
        #if (opts.batch == "IC") :    system('qsub %s -q %s -n 3 -R "span[hosts=1]" -o %s.log '%(os.path.abspath(sub_file_name),opts.queue,os.path.abspath(sub_file_name)))
      if opts.runLocal:
        system('bash %s'%os.path.abspath(sub_file_name))

  # switch back
  opts.datacard = opts.datacard.replace('.root','.txt')

def writeProfileLikelhood():

  print '[INFO] Writing ProfileLikelihood'
  try:
    assert(opts.masses_per_job)
  except AssertionError:
    sys.exit('No masses have been defined')

  tempcardstore = opts.datacard
  #if opts.splitChannels: splitCard()
  toysfilestore = opts.toysFile
  
  if ("Stat" in opts.outDir) : makeStatOnlyCard()
  # write
  for j, mass_set in enumerate(opts.masses_per_job):
    file = open('%s/sub_job%d.sh'%(opts.outDir,j),'w')
    if opts.toysFile:
      opts.toysFile = ''
      for mass in mass_set:
        opts.toysFile += toysfilestore.replace('${m}',str(mass)).replace('.0','')
    writePreamble(file)
    exec_line = ''
    for mass in mass_set:
      exec_line +=  'combine %s -M ProfileLikelihood -m %6.2f --signif --pval --cminDefaultMinimizerType=Minuit2'%(opts.datacard,mass)
      if opts.additionalOptions: exec_line += ' %s'%opts.additionalOptions
      if opts.expected: exec_line += ' -t -1 '
      if opts.expectSignal: exec_line += ' --expectSignal=%3.1f'%opts.expectSignal
      if opts.expectSignalMass: exec_line += ' --expectSignalMass=%6.2f'%opts.expectSignalMass
      if opts.toysFile: exec_line += ' --toysFile %s'%toysfilestore.replace('${m}',str(mass)).replace('.0','')
      if mass!=mass_set[-1]: exec_line += ' && '
    
    writePostamble(file,exec_line)
  # change back
  opts.datacard = tempcardstore
  opts.toysFile = toysfilestore

def writeChannelCompatibility():

  print '[INFO] Writing ChannelCompatibility'
  try:
    assert(opts.mh)
  except AssertionError:
    sys.exit('mh is not defined')

  file = open('%s/sub_m%6.2f.sh'%(opts.outDir,opts.mh),'w')
  writePreamble(file)
  exec_line = 'combine %s -M ChannelCompatibilityCheck -m %6.2f --rMin=-25. --saveFitResult --cminDefaultMinimizerType=Minuit2'%(opts.datacard,opts.mh)
  writePostamble(file,exec_line)

def writeSingleGenerateOnly():
  
  file = open('%s/sub.sh'%(opts.outDir),'w')
  writePreamble(file)
  exec_line = 'combine %s -M GenerateOnly -m %6.2f --saveToys '%(opts.datacard,opts.mh)
  if opts.expected: exec_line += ' -t -1'
  if opts.expectSignal: exec_line += ' --expectSignal=%3.1f'%opts.expectSignal
  if opts.expectSignalMass: exec_line += ' --expectSignalMass=%6.2f'%opts.expectSignalMass
  writePostamble(file,exec_line)

def writeGenerateOnly():

  print "[INFO] writing generate only"
  if opts.splitChannels:
    backupcard = opts.datacard
    backupdir = opts.outDir
    if 'all' in opts.splitChannels:
      cats = getSortedCats()
      for cat in cats:
        opts.splitChannels = [cat]
        splitCard()
        opts.outDir += '/'+cat
        system('mkdir -p %s'%opts.outDir)
        writeSingleGenerateOnly()
        opts.datacard = backupcard
        opts.outDir = backupdir
    else:
      splitCard()
      writeSingleGenerateOnly()
      opts.datacard = backupcard
      opts.outDir = backupdir
  else:
    writeSingleGenerateOnly()

def writeMultiPdfMuHatvsMH():
  
  print '[INFO] Writing MultiPdfMuHatvsMH'
  rmindefault = opts.muLow
  backupdir = opts.outDir
  rmaxdefault = opts.muHigh
  print "[DEBUG] MultiPdfMuHatvsMH   -- mulow, mu high ", rmindefault ," , ",rmaxdefault 
  print "[DEBUG] MultiPdfMuHatvsMH   -- catRanges ", catRanges 
  mLow=opts.mhLow
  mHigh=opts.mhHigh
  mStep=opts.mhStep
  m=mLow
  counter=0;
  while (m < mHigh+0.1 ):
    print "[DEBUG] MultiPdfMuHatvsMH   -- loop trhoguh masses, now process m: ", m
    opts.method = 'MuScan'
    opts.mass = m
    backupmass =  getattr(opts,"mh",None)
    backupskipws =  opts.skipWorkspace
    opts.outDir += '/%.2f'%m
    print system('mkdir -p %s'%opts.outDir)
    system('mkdir -p %s'%opts.outDir)
    if (counter==0) :  
      opts.skipWorkspace=0
      #opts.skipWorkspace=1
      counter=counter+1
    else :
      opts.skipWorkspace=1
    #print  opts.datacard
    #opts.datacard = opts.datacard 
    opts.mh=m
    writeMultiDimFit()
    opts.mh=backupmass
    #opts.datacard = backupcard
    opts.skipWorkspace = backupskipws
    opts.muLow  = rmindefault
    opts.outDir = backupdir
    m += mStep
  
  
def writeMultiPdfChannelCompatibility():
  
  print '[INFO] Writing MultiPdfChannelCompatibility'
  backupcard = opts.datacard
  backupdir = opts.outDir
  cats = getSortedCats()
  print "[INFO] MultiPdfChannelCompatibility  cats ", cats 
  rmindefault = opts.muLow
  rmaxdefault = opts.muHigh
  print "[INFO] MultiPdfChannelCompatibility   -- mulow, mu high ", rmindefault ," , ",rmaxdefault 
  catRanges = strtodict(opts.catRanges)
  for cat in cats:
    print "[INFO] MultiPdfChannelCompatibility   -- loop trhoguh cats, now process : ", cat  
    if cat in catRanges.keys():
      #if opts.verbose: print " set ranges for cat %s to"%cat, catRanges[cat]
      print " [INFO] set ranges for cat %s to", catRanges[cat]
      opts.muLow  = catRanges[cat][0]
      opts.muHigh = catRanges[cat][1]
      print "[INFO] MultiPdfChannelCompatibility   -- mu ranges for cat  ", cat  , " -- ", opts.muLow, " --> ", opts.muHigh
    if opts.verbose: print cat
    opts.splitChannels = [cat]
    print "[INFO MultiPdfChannelCompatibility   -- about to split card for cat ", cat
    splitCard()
    opts.outDir += '/'+cat
    print 'mkdir -p %s'%opts.outDir
    system('mkdir -p %s'%opts.outDir)
    print "[INFO] MultiPdfChannelCompatibility   -- about to write multidimfit for cat ",cat 
    opts.method = 'MuScan'
    writeMultiDimFit()
    opts.datacard = backupcard
    opts.outDir = backupdir
    opts.muLow  = rmindefault
    opts.muHigh = rmaxdefault
  
  for cat in ["All"]:
    if cat in catRanges.keys():
      #if opts.verbose: print " set ranges for cat %s to"%cat, catRanges[cat]
      opts.muLow  = catRanges[cat][0]
      opts.muHigh = catRanges[cat][1]
    if opts.verbose: print cat
    opts.outDir += '/'+cat
    system('mkdir -p %s'%opts.outDir)
    opts.method = 'MuScan'
    opts.datacard = backupcard
    writeMultiDimFit()
    opts.outDir = backupdir
    opts.muLow  = rmindefault
    opts.muHigh = rmaxdefault
  
def writeMultiDimFit(method=None,wsOnly=False):

        print "[INFO] writing multidim fit"
        globe_name = "h2gglobe"
        mypath = os.path.abspath(os.getcwd())
        print "[INFO] --> path ", mypath
        print "[INFO] --> os.path.basename(mypath) ", os.path.basename(mypath)
        while mypath != "":
            #if "h2gglobe" in os.path.basename(mypath): #FIXME what is this structure for?
            if "flashgg" in os.path.basename(mypath):
                globe_name = os.path.basename(mypath)
                break
            mypath = os.path.dirname(mypath)
           # print "[INFO] --> path ", mypath
        if opts.profileMH:
            profMH = "--PO higgsMassRange=122,128"
        else:
            profMH = ""
        catsMap = opts.catsMap
        if not method:
            method = opts.method            
        if method == "RBinScan" and catsMap == "":
            for ibin in range(opts.nBins):
                binstr = " --PO map='.*cat"
                comma = "("
                for icat in range(30):
                    if icat % opts.nBins == ibin:
                        binstr += "%s%d" % (comma,icat)
                        comma ="|"
                binstr += ").*TeV/.*Bin.*:r_Bin%d[1,0,20]'" % ibin
                catsMap += binstr
        
        print '[INFO] Writing MultiDim Scan'
        ws_args = { "RVRFScan"   : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs " ,
    "RVScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs %s" % profMH,
    "RVnpRFScan"   : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs %s" % profMH,
    "RFScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs %s" % profMH,
    "RFnpRVScan"   : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs %s" % profMH,
    "MuScan"  : "",
    "MuScanMHProf"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:floatingHiggsMass",
    "CVCFScan"  : "-P HiggsAnalysis.CombinedLimit.HiggsCouplings:cVcF       %s" % profMH,
    "KGluKGamScan"  : "-P HiggsAnalysis.CombinedLimit.HiggsCouplings:higgsLoops %s" % profMH,
    "MHScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs  %s" % profMH,
    "MHScanStat"   : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs  %s" % profMH,
    "MHScanNoGlob"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:rVrFXSHiggs  %s" % profMH,
    "MuMHScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:floatingHiggsMass",
    "RTopoScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel %s %s" % ( catsMap, profMH ),
    "RBinScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:multiSignalModel %s %s" % ( catsMap, profMH ),
                "RDiffXsScan"  : "-P %s.AnalysisScripts.UnfoldModel:unfoldModel %s" % ( globe_name, profMH ),
    "RProcScan"  : "-P HiggsAnalysis.CombinedLimit.PhysicsModel:floatingXSHiggs --PO modes=ggH,qqH,VH,ttH --PO higgsMassRange=124,126 --PO ggHRange=-1:10 --PO qqHRange=-2:20 --PO VHRange=-2:20 --PO ttHRange=-2:20 "
  }

        setpois = {
            "RVRFScan" : [ "RV", "RF" ],
            "RVScan" : [ "RV", "RF" ],
            "RVnpRFScan": [ "RV", "RF" ],
            "RFScan": [ "RV", "RF" ],
            "RFnpRVScan": [ "RV", "RF" ],
            "MuScan": [ ],
            "MuScanMHProf": [ ],
            "CVCFScan": [ "CV", "CF" ],
            "KGluKGamScan": [ "kgluon", "kgamma" ],
            "MHScan": [ ],
            "MHScanStat": [ ],
            "MHScanNoGlob": [ ],
            "MuMHScan": [ ],
            "RProcScan": [ "r_ggH","r_qqH","r_VH","r_ttH" ],
            "RTopoScan": [ "r_untag","r_qqHtag","r_VHtag","r_ttHtag" ],
            "RBinScan": [ "r_Bin%d" % i for i in range(opts.nBins) ],
            "RDiffXsScan": [ "r_Bin%d" % i for i in range(opts.nBins) ],
            }
  
        combine_args = {
    "RVRFScan"   : "-P RV -P RF --floatOtherPOIs=1" , 
    "RVScan"  : "--floatOtherPOIs=1 -P RV" ,
    "RVnpRFScan"  : "--floatOtherPOIs=0 -P RV" ,
    "RFScan"  : "--floatOtherPOIs=1 -P RF" ,
    "RFnpRVScan"  : "--floatOtherPOIs=0 -P RF" ,
    "MuScan"  : "-P r",
    "MuScanMHProf"  : "-P r --floatOtherPOIs=1",
    "CVCFScan"  : "-P CV -P CF --floatOtherPOIs=1", 
    "KGluKGamScan"  : "-P kgluon -P kgamma --floatOtherPOIs=1", 
    "MHScan"  : "--floatOtherPOIs=1 -P MH",
    "MHScanStat"  : "--floatOtherPOIs=1 -P MH",
    "MHScanNoGlob"  : "--floatOtherPOIs=1 -P MH",
    "MuMHScan"  : "-P r -P MH",
    "RProcScan"  : "--floatOtherPOIs=1 -P %s"%(opts.poix), # need to add option to run specific process
    "RTopoScan"  : "--floatOtherPOIs=1 -P %s"%(opts.poix), # need to add option to run specific topologic categories
    "RBinScan"  : "--floatOtherPOIs=1 -P %s"%(opts.poix), # need to add option to run specific topologic categories
    "RDiffXsScan"  : "--floatOtherPOIs=1 -P %s"%(opts.poix), # need to add option to run specific topologic categories
    }
        par_ranges = {}
        if opts.rvLow!=None and opts.rvHigh!=None and opts.rfLow!=None and opts.rfHigh!=None:
          par_ranges["RVRFScan"]  = "RV=%4.2f,%4.2f:RF=%4.2f,%4.2f"%(opts.rvLow,opts.rvHigh,opts.rfLow,opts.rfHigh)
        if opts.rvLow!=None and opts.rvHigh!=None:
          par_ranges["RVScan"]  = "RV=%4.2f,%4.2f"%(opts.rvLow,opts.rvHigh) 
        if opts.rvLow!=None and opts.rvHigh!=None:
          par_ranges["RVnpRFScan"]= "RV=%4.2f,%4.2f"%(opts.rvLow,opts.rvHigh)
        if opts.rfLow!=None and opts.rfHigh!=None:
          par_ranges["RFScan"]  = "RF=%4.2f,%4.2f"%(opts.rfLow,opts.rfHigh)
        if opts.rfLow!=None and opts.rfHigh!=None:
          par_ranges["RFnpRVScan"]= "RF=%4.2f,%4.2f"%(opts.rfLow,opts.rfHigh)
        if opts.muLow!=None and opts.muHigh!=None:
          par_ranges["MuScan"]  = "r=%4.2f,%4.2f"%(opts.muLow,opts.muHigh) 
          par_ranges["MuScanMHProf"]= "r=%4.2f,%4.2f"%(opts.muLow,opts.muHigh) 
          par_ranges["RProcScan"]    = "%s=%4.2f,%4.2f"%(opts.poix,opts.muLow,opts.muHigh)
          par_ranges["RTopoScan"]    = "%s=%4.2f,%4.2f"%(opts.poix,opts.muLow,opts.muHigh)
          par_ranges["RBinScan"]    = "%s=%4.2f,%4.2f"%(opts.poix,opts.muLow,opts.muHigh)
          par_ranges["RDiffXsScan"] = "%s=%4.2f,%4.2f"%(opts.poix,opts.muLow,opts.muHigh)
        if opts.cvLow!=None and opts.cvHigh!=None and opts.cfLow!=None and opts.cfHigh!=None:
          par_ranges["CVCFScan"]    = "CV=%4.2f,%4.2f:CF=%4.2f,%4.2f"%(opts.cvLow,opts.cvHigh,opts.cfLow,opts.cfHigh)
        if opts.kgamLow!=None and opts.kgamHigh!=None and opts.kgluLow!=None and opts.kgluHigh!=None:
          par_ranges["KGluKGamScan"] = "kgamma=%4.2f,%4.2f:kgluon=%4.2f,%4.2f"%(opts.kgamLow,opts.kgamHigh,opts.kgluLow,opts.kgluHigh)
        if opts.mhLow!=None and opts.mhHigh!=None:
          par_ranges["MHScan"]    = "MH=%6.2f,%6.2f"%(opts.mhLow,opts.mhHigh)
          par_ranges["MHScanStat"]  = "MH=%6.2f,%6.2f"%(opts.mhLow,opts.mhHigh)
          par_ranges["MHScanNoGlob"]= "MH=%6.2f,%6.2f"%(opts.mhLow,opts.mhHigh)
        if opts.muLow!=None and opts.muHigh!=None and opts.mhLow!=None and opts.mhHigh!=None:
          par_ranges["MuMHScan"]    = "r=%4.2f,%4.2f:MH=%6.2f,%6.2f"%(opts.muLow,opts.muHigh,opts.mhLow,opts.mhHigh)
        # create specialised MultiDimFit workspace
        backupcard = opts.datacard
        if method=='MHScanStat':
          makeStatOnlyCard()
        if method=='MHScanNoGlob':
          makeNoGlobCard()
        if (opts.mhRange>-1):
         makeFloatMHCard()
        if not opts.skipWorkspace:
          print "we enter if not opts.skipWorkspace"  
          datacardname = os.path.basename(opts.datacard).replace('.txt','')
          print 'Creating workspace for %s...'%method
          exec_line = 'text2workspace.py %s -o %s %s'%(os.path.abspath(opts.datacard),os.path.abspath(opts.datacard).replace('.txt',method+opts.catName+'.root'),ws_args[method]) 
          print exec_line
          if opts.postFit:
                          exec_line += '&& combine -m 125 -M MultiDimFit --saveWorkspace -n %s_postFit %s' % ( datacardname+method, os.path.abspath(opts.datacard).replace('.txt',method+'.root') )
                          exec_line += '&& cp higgsCombine%s_postFit.MultiDimFit.mH125.root %s' % ( datacardname+method, os.path.abspath(opts.datacard).replace('.txt',method+'_postFit.root') )
          if opts.parallel and opts.dryRun:
                          parallel.run(system,(exec_line,))
          else:
              print '****DEBUG this is what is going to be executed: '+str(exec_line)
              system(exec_line)
              
        if wsOnly:
           return

        if opts.freezeAll:
            dcard=open(opts.datacard)
            nsec = 0
            nuis = ""
            toFloat = None
            if opts.float != "":
                toFloat = re.compile(opts.float)
            for line in dcard.read().split("\n"):
                if line.startswith("#"):
                    continue
                if line.startswith("--"):
                    nsec += 1
                    continue
                if nsec == 4:
                    nu = line.split(" ",1)[0]
                    if toFloat and toFloat.match(nu):
                        print "Floating ", nu
                        continue
                    if nu != "" and not "pdfindex" in nu:
                        if nuis != "":
                            nuis += ","
                        nuis+=nu
            if nuis != "":
                opts.additionalOptions += " --freezeNuisances %s" % nuis
            print opts.additionalOptions
      
        if opts.postFit:
                  opts.datacard = opts.datacard.replace('.txt',method+'_postFit.root')
                  if opts.expected and method in setpois and opts.expectSignal:
                      pars = ""
                      for poi in setpois[method]:
                          if pars != "": pars+=","
                          pars += "%s=%4.2f" % ( poi, opts.expectSignal )
                      if pars != "":
                          if not "--setPhysicsModelParameters" in opts.additionalOptions:
                             opts.additionalOptions += " --setPhysicsModelParameters %s" %pars
      
        else:
            print "we enter the else"
            opts.datacard = opts.datacard.replace('.txt',method+opts.catName+'.root')
              
                  
                  
        # make job scripts
        for i in range(opts.jobs):
          file = open('%s/sub_m%1.5g_job%d.sh'%(opts.outDir,getattr(opts,"mh",0.),i),'w')
          writePreamble(file)
          exec_line = 'combine %s  -M MultiDimFit --cminDefaultMinimizerType Minuit2 --cminDefaultMinimizerAlgo migrad --algo=grid  %s --points=%d --firstPoint=%d --lastPoint=%d -n %sJob%d'%(opts.datacard,combine_args[method],opts.pointsperjob*opts.jobs,i*opts.pointsperjob,(i+1)*opts.pointsperjob-1,method,i)
          if ("FloatMH" in opts.outDir) : exec_line += " --saveSpecifiedNuis MH" 
          if method in par_ranges.keys(): exec_line+=" --setPhysicsModelParameterRanges %s "%(par_ranges[method])
          if getattr(opts,"mh",None): exec_line += ' -m %6.2f'%opts.mh
          #if opts.expected: exec_line += ' -t -1 --freezeNuisances=JetVeto_migration0,JetVeto_migration1,pdfindex_UntaggedTag_0_13TeV,pdfindex_UntaggedTag_1_13TeV,pdfindex_UntaggedTag_2_13TeV,pdfindex_UntaggedTag_3_13TeV,pdfindex_VBFTag_0_13TeV,pdfindex_VBFTag_1_13TeV'
          if opts.expected: exec_line += ' -t -1 '
          #exec_line += ' --verbose -1 ' # make very quiet
          #exec_line += ' --verbose -1 --saveSpecifiedIndex pdfindex_UntaggedTag_0_13TeV,pdfindex_UntaggedTag_1_13TeV,pdfindex_UntaggedTag_2_13TeV,pdfindex_UntaggedTag_3_13TeV,pdfindex_VBFTag_0_13TeV,pdfindex_VBFTag_1_13TeV,pdfindex_TTHLeptonicTag_13TeV,pdfindex_TTHHadronicTag_13TeV' 
          if opts.expectSignal: exec_line += ' --expectSignal %4.2f'%opts.expectSignal
          if opts.expectSignalMass: exec_line += ' --expectSignalMass %6.2f'%opts.expectSignalMass
          if opts.additionalOptions: exec_line += ' %s'%opts.additionalOptions
          if opts.toysFile: exec_line += ' --toysFile %s'%opts.toysFile
          if opts.verbose: print '\t', exec_line
          writePostamble(file,exec_line)
      
        opts.datacard = backupcard 
      
def run():
  print "[INFO] running..."
  # setup
  print opts.prefix , " ", opts.outDir  
  opts.outDir=os.path.join(opts.prefix,opts.outDir)
  system('mkdir -p %s'%opts.outDir)
  if opts.verbose: print 'Made directory', opts.outDir
  checkValidMethod()
  # submit
  storecard = opts.datacard
  if opts.postFit:
    opts.additionalOptions += " --snapshotName MultiDimFit"
    if opts.expected:
      opts.additionalOptions += " --toysFrequentist --bypassFrequentistFit" # Skip the actual fit but recentre constraints on fitted values from snapshot.
    if ( opts.method=='Asymptotic' or opts.method=='AsymptoticGrid' or opts.method=='ProfileLikelihood' or  opts.method=='ChannelCompatibilityCheck' or  opts.method=='MultiPdfChannelCompatibility' or  opts.method=='MultiPdfChannelCompatibility'):
      writeMultiDimFit("MuMHScan",True)
      opts.datacard = opts.datacard.replace('.txt','MuMHScan_postfit.root')
      if opts.expected:
        opts.additionalOptions += " --overrideSnapshotMass --redefineSignalPOIs r --freezeNuisances MH"
  if opts.wspace: opts.datacard=opts.wspace 
  if opts.splitChannels : splitCard()
  if opts.method=='Asymptotic' or opts.method=='AsymptoticGrid' or opts.method=='ProfileLikelihood':
    configureMassFromNJobs()
  if opts.method=='Asymptotic':
    writeAsymptotic()
  elif opts.method=='AsymptoticGrid':
    writeAsymptoticGrid()
  elif opts.method=='ProfileLikelihood':
    writeProfileLikelhood()
  elif opts.method=='ChannelCompatibilityCheck':
    writeChannelCompatibility()
  elif opts.method=='MultiPdfChannelCompatibility':
    writeMultiPdfChannelCompatibility()
  elif opts.method=='MultiPdfMuHatvsMH':
    writeMultiPdfMuHatvsMH()
  elif opts.method=='GenerateOnly':
    writeGenerateOnly()
  else:
    writeMultiDimFit()
  opts.datacard = storecard
def resetDefaultConfig():
    print "[INFO] resetting default config"
    global opts
    opts = copy(defaults)
    ### for opt in specOpts.option_list:
    ###     opt_name = opt.dest.strip('--')
    ###     if opt_name=='datacard' or opt_name=='files': continue
    ###     else: setattr(opts,opt_name,None)

def configure(config_line):
  print "[INFO] configuring"
  # could automate this but makes it easier to read and add options this way
  resetDefaultConfig()
  if opts.verbose: print config_line
  for option in config_line.split():
    if option.startswith('outDir='): opts.outDir = option.split('=')[1]
    if option.startswith('method='): opts.method = option.split('=')[1]
    if option.startswith('expected='): opts.expected = int(option.split('=')[1])
    if option.startswith('expectSignal='): opts.expectSignal = float(option.split('=')[1])
    if option.startswith('expectSignalMass='): opts.expectSignalMass = float(option.split('=')[1])
    if option.startswith('mhLow='): opts.mhLow = float(option.split('=')[1])
    if option.startswith('mhHigh='): opts.mhHigh = float(option.split('=')[1])
    if option.startswith('mhStep='): opts.mhStep = float(option.split('=')[1])
    if option.startswith('jobs='): opts.jobs = int(option.split('=')[1])
    if option.startswith('pointsperjob='): opts.pointsperjob = int(option.split('=')[1])
    if option.startswith('splitChannels='): opts.splitChannels = option.split('=')[1].split(',')
    if option.startswith('toysFile='): opts.toysFile = option.split('=')[1]
    if option.startswith('catName='): opts.catName = '_'+option.split('=')[1]
    if option.startswith('mh='): 
      #opts.mh = float(option.split('=')[1])
      mhStr = (option.split('=')[1])
      if (len(mhStr.split(":"))>1):
        print "DEBUG LC mhStr.split(:)[1] " , mhStr.split(":")[1]
        opts.mh  = float(mhStr.split(":")[0])
        opts.mhRange = float(mhStr.split(":")[1])
      else :
       opts.mh = float(option.split('=')[1])
        
    if option.startswith('poix='): 
      poiopt = option.split('=')[1]
      if ',' in poiopt:
        opts.poix = " -P ".join(poiopt.split(','))
      else: opts.poix = option.split('=')[1]
    if option.startswith('muLow='): opts.muLow = float(option.split('=')[1])
    if option.startswith('muHigh='): opts.muHigh = float(option.split('=')[1])
    if option.startswith('rvLow='): opts.rvLow = float(option.split('=')[1])
    if option.startswith('rvHigh='): opts.rvHigh = float(option.split('=')[1])
    if option.startswith('rfLow='): opts.rfLow = float(option.split('=')[1])
    if option.startswith('rfHigh='): opts.rfHigh = float(option.split('=')[1])
    if option.startswith('cvLow='): opts.cvLow = float(option.split('=')[1])
    if option.startswith('cvHigh='): opts.cvHigh = float(option.split('=')[1])
    if option.startswith('cfLow='): opts.cfLow = float(option.split('=')[1])
    if option.startswith('cfHigh='): opts.cfHigh = float(option.split('=')[1])
    if option.startswith('kgamLow='): opts.kgamLow = float(option.split('=')[1])
    if option.startswith('kgamHigh='): opts.kgamHigh = float(option.split('=')[1])
    if option.startswith('kgluLow='): opts.kgluLow = float(option.split('=')[1])
    if option.startswith('kgluHigh='): opts.kgluHigh = float(option.split('=')[1])
    if option.startswith('wspace='): opts.wspace = str(option.split('=')[1])
    if option.startswith('catRanges='): opts.catRanges = str(option.split('=')[1])
    if option.startswith('nBins='): opts.nBins = int(option.split('=')[1])
    if option.startswith('freezeAll='): opts.freezeAll = int(option.split('=')[1])
    if option.startswith('float='): opts.float = str(option.split('=')[1])
    if option.startswith('opts='): 
      addoptstr = option.split("=")[1:]
      addoptstr = "=".join(addoptstr)
      opts.additionalOptions =  addoptstr.replace('+',' ')
      opts.additionalOptions = opts.additionalOptions.replace(">"," ")
      opts.additionalOptions = opts.additionalOptions.replace("<"," ")
    if option.startswith('catsMap='):
      for mp in option.split('=')[1].split(';'):
        if not "[" in mp.split(':')[-1]:
          mp += "[1,0,20]"
        opts.catsMap += " --PO map=%s" % mp
    if option.startswith('catRanges='):
      catRanges = strtodict(opts.catRanges)
    if option == "skipWorkspace": opts.skipWorkspace = True
    if option == "postFit":  opts.postFit = True
    if option == "expected": opts.expected = 1
  if opts.postFitAll: opts.postFit = True
  if opts.wspace : opts.skipWorkspace=True
  if "-P" in opts.poix and (opts.muLow!=None or opts.muHigh!=None): sys.exit("Cannot specify muLow/muHigh with >1 POI. Remove the muLow/muHigh option and add use --setPhysicsModelParameterRanges in opts keyword") 
  if opts.verbose: print opts
  run()

def trawlHadd():
  print "[INFO] trawling hadd"
  list_of_dirs=set()
  for root, dirs, files in os.walk(opts.hadd):
    for x in files:
      if 'higgsCombine' in x and '.root' in x: 
        list_of_dirs.add(root)

  for dir in list_of_dirs:
    for root, dirs, files in os.walk(dir):
      list_of_files=''
      for file in fnmatch.filter(files,'higgsCombine*.root'):
        list_of_files += ' '+os.path.join(root,'%s'%file)
      print root, ' -- ', len(list_of_files.split())
      exec_line = 'hadd -f %s/%s.root%s'%(dir,os.path.basename(dir),list_of_files)
      if opts.verbose: print exec_line
      system(exec_line)

if opts.hadd:
  trawlHadd()
elif opts.datfile:
  datfile = open(opts.datfile)
  for line in datfile.readlines():
    line=line.strip('\n')
    if line.startswith('#') or len(line)==0: 
      continue
    if line.startswith('datacard'): 
      opts.datacard = line.split('=')[1]
      defaults.datacard = opts.datacard
      assert('.txt' in opts.datacard)
      opts.files = getFilesFromDatacard(opts.datacard)
      defaults.files = opts.files
      continue
    if line.startswith('files'):
      opts.files = line.split('=')[1]
      defaults.files = opts.files
      continue
    configure(line)

else:
  # default setup here
  print '[INFO] Not yet implemented'
        
if opts.parallel:
    for i in range(parallel.njobs):
        print parallel.returned.get()
        
