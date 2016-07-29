#include <iostream>
#include <string>
#include <map>
#include <vector>

#include "TFile.h"
#include "TMath.h"
#include "TCanvas.h"
#include "TH1F.h"
#include "TLegend.h"
#include "TF1.h"

#include "TStopwatch.h"
#include "RooWorkspace.h"
#include "RooDataSet.h"
#include "RooDataHist.h"
#include "RooAddPdf.h"
#include "RooGaussian.h"
#include "RooRealVar.h"
#include "RooFormulaVar.h"
#include "RooFitResult.h"
#include "RooPlot.h"
#include "RooMsgService.h"
#include "RooMinuit.h"
#include "RooMoment.h"
#include "RooHist.h"
#include "TFitResult.h"

#include "boost/program_options.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/predicate.hpp"

#include "../interface/WSTFileWrapper.h"

#include "../../tdrStyle/tdrstyle.C"
#include "../../tdrStyle/CMS_lumi.C"

using namespace std;
using namespace RooFit;
using namespace boost;
namespace po = boost::program_options;

string filename_;
string datfilename_;
string json_dict_;
string outdir_;
int mass_;
string procString_;
int ncats_;
bool recursive_=false;
string flashggCatsStr_;
vector<string> flashggCats_;
string considerOnlyStr_;
vector<string> considerOnly_;
bool forceFracUnity_=false;
bool isFlashgg_;
bool verbose_;

void OptionParser(int argc, char *argv[]){
  po::options_description desc1("Allowed options");
  desc1.add_options()
    ("help,h",                                                                                "Show help")
    ("infilename,i", po::value<string>(&filename_),                                           "Input file name")
    ("datfilename,d", po::value<string>(&datfilename_)->default_value("dat/config.dat"),      "Output configuration file")
    ("outdir,o", po::value<string>(&outdir_)->default_value("plots"),      "Output configuration file")
    ("json_dict,j", po::value<string>(&json_dict_)->default_value(""),      "Output configuration file")
    ("mass,m", po::value<int>(&mass_)->default_value(125),                                    "Mass to run at")
    ("procs,p", po::value<string>(&procString_)->default_value("ggh,vbf,wh,zh,tth"),          "Processes")
    ("recursive",																																							"Recursive fraction")
    ("forceFracUnity",																																				"Force fraction unity")
    ("isFlashgg",	po::value<bool>(&isFlashgg_)->default_value(true),													"Use flashgg format")
    ("verbose",	po::value<bool>(&verbose_)->default_value(false),													"Use flashgg format")
    ("flashggCats,f", po::value<string>(&flashggCatsStr_)->default_value("UntaggedTag_0,UntaggedTag_1,UntaggedTag_2,UntaggedTag_3,UntaggedTag_4,VBFTag_0,VBFTag_1,VBFTag_2,TTHHadronicTag,TTHLeptonicTag,VHHadronicTag,VHTightTag,VHLooseTag,VHEtTag"),       "Flashgg category names to consider")
    ("considerOnly", po::value<string>(&considerOnlyStr_)->default_value("All"), 
     "If you wish to only consider a subset cat in the list, list them as separated by commas. ")
    ;

  po::options_description desc("Allowed options");
  desc.add(desc1);

  po::variables_map vm;
  po::store(po::parse_command_line(argc,argv,desc),vm);
  po::notify(vm);
  if (vm.count("help")){ cout << desc << endl; exit(1);}
  if (vm.count("recursive")) recursive_=true;
  if (vm.count("forceFracUnity")) forceFracUnity_=true;
}

RooAddPdf *buildSumOfGaussians(string name, RooRealVar *mass, RooRealVar *MH, int nGaussians){
  
  int mh=MH->getVal();
  assert(mh==125);
  RooArgList *gaussians = new RooArgList();
  RooArgList *coeffs = new RooArgList();
  for (int g=0; g<nGaussians; g++){

    //RooRealVar *dm = new RooRealVar(Form("dm_g%d",g),Form("dm_g%d",g),0.1,-2.*(1.+0.5*g),2.*(1.+0.5*g));
    RooRealVar *dm = new RooRealVar(Form("dm_g%d",g),Form("dm_g%d",g),0.1,-3.,3.); // make this identical to fit in signalfTest. FIXME maybe just use the identical function,ie create an InitialFit object here ?
    RooAbsReal *mean = new RooFormulaVar(Form("mean_g%d",g),Form("mean_g%d",g),"@0+@1",RooArgList(*MH,*dm));
    //RooRealVar *sigma = new RooRealVar(Form("sigma_g%d",g),Form("sigma_g%d",g),2.,0.7,5.*(1.+0.5*g));

    //    RooRealVar *sigma = new RooRealVar(Form("sigma_g%d",g),Form("sigma_g%d",g),2.,0.4,10.); // make this identical to fit in signalfTest. FIXME maybe just use the identical function,ie create an InitialFit object here ?

    // MDDB every gaussian you add is larger than the previous one (this is only the starting point of the fit)
    RooRealVar *sigma = new RooRealVar(Form("sigma_g%d",g),Form("sigma_g%d",g), 1.*(g+1), 0.4,20.); 

    RooGaussian *gaus = new RooGaussian(Form("gaus_g%d",g),Form("gaus_g%d",g),*mass,*mean,*sigma);

    //old fit params... check !
    //RooRealVar *dm = new RooRealVar(Form("dm_g%d",g),Form("dm_g%d",g),0.1,-0.1*(1.+0.5*g),0.1*(1.+0.5*g));
    //RooAbsReal *mean = new RooFormulaVar(Form("mean_g%d",g),Form("mean_g%d",g),"@0+@1",RooArgList(*MH,*dm));
    //RooRealVar *sigma = new RooRealVar(Form("sigma_g%d",g),Form("sigma_g%d",g),0.5,0.1,5.*(1.+0.5*g));
    //RooGaussian *gaus = new RooGaussian(Form("gaus_g%d",g),Form("gaus_g%d",g),*mass,*mean,*sigma);

    gaussians->add(*gaus);

    if (g<nGaussians-1) {
      RooRealVar *frac = new RooRealVar(Form("frac_g%d",g),Form("frac_g%d",g),0.1,0.01,0.99);
      //tempFitParams.insert(pair<string,RooRealVar*>(string(frac->GetName()),frac));
      coeffs->add(*frac);
    }

    if (g==nGaussians-1 && forceFracUnity_){
      string formula="1.";
      for (int i=0; i<nGaussians-1; i++) formula += Form("-@%d",i);
      RooAbsReal *recFrac = new RooFormulaVar(Form("frac_g%d",g),Form("frac_g%d",g),formula.c_str(),*coeffs);
      //tempFitUtils.insert(pair<string,RooAbsReal*>(string(recFrac->GetName()),recFrac));
      coeffs->add(*recFrac);
    }
  }
  RooAddPdf *tempSumOfGaussians = new RooAddPdf(name.c_str(),name.c_str(),*gaussians,*coeffs,recursive_);
  return tempSumOfGaussians;
}

void plot(string outPath, int mh, RooRealVar *var, RooAbsData *data, RooAbsPdf *pdf){

  TCanvas *canv = new TCanvas("c","c",1000,1000);
  RooPlot *plot = var->frame(Range(mh-10,mh+10));
  data->plotOn(plot);
  pdf->plotOn(plot);
  plot->Draw();
  canv->Print(Form("%s.pdf",outPath.c_str()));
}

double getMyNLL(RooRealVar *var, RooAbsPdf *pdf, RooDataHist *data){
  RooPlot *plot = var->frame();
  data->plotOn(plot);
  pdf->plotOn(plot);
  RooCurve *pdfCurve = (RooCurve*)plot->getObject(plot->numItems()-1);
  double sum=0.;
  for (int i=0; i<data->numEntries(); i++){
    double binCenter = data->get(i)->getRealValue("CMS_hgg_mass");
    double weight = data->weight();
    sum+=TMath::Log(TMath::Poisson(100.*weight,100.*pdfCurve->Eval(binCenter)));
  }
  return -1.*sum;
}


int main(int argc, char *argv[]){

  // Criteria to choose #gauss
  float myThresholdDist = 0.8; // how much better n+1 has to be wrt n
  float myThresholdChi2 = 0.5; // how much better n+1 has to be wrt n
  int   minNevts    = 500; // if below minNevts #gauss = -1
  float itsOK       = 0.1; // if  myDistance < itsOK suggest the #gauss that fulfill this condition

  OptionParser(argc,argv);
	
  if (verbose_) {
    std::cout << "[INFO] datfilename_	" << datfilename_ << std::endl;
  }
  if (verbose_) {
    std::cout << "[INFO] filename_	" << filename_ << std::endl;
  }

  TStopwatch sw;
  sw.Start();
 

  //make nice plots in ~correct style.
  setTDRStyle();
  writeExtraText = true;       // if extra text
  extraText  = "";  // default extra text is "Preliminary"
  lumi_8TeV  = "19.1 fb^{-1}"; // default is "19.7 fb^{-1}"
  lumi_7TeV  = "4.9 fb^{-1}";  // default is "5.1 fb^{-1}"
  lumi_sqrtS = "13 TeV";       // used with iPeriod = 0
                               //, e.g. for simulation-only plots
                               //(default is an empty string)

  
  // set range to be the same as SigfitPlots
  // want quite a large range otherwise don't
  // see crazy bins on the sides
  float rangeLow = 115;
  float rangeHigh = 135;

  //want binning of \0.5GeV
  //int   nBins    = 2* int(rangeHigh -rangeLow); 
  int   nBins    = 2* int(rangeHigh -rangeLow); 

  // silence roofit
  RooMsgService::instance().setGlobalKillBelow(RooFit::ERROR);
  RooMsgService::instance().setSilentMode(true);

  // make output dir
  system(Form("mkdir -p %s/fTest",outdir_.c_str()));

  // split procs, cats
  vector<string> procs;
  split(procs,procString_,boost::is_any_of(","));
  split(flashggCats_,flashggCatsStr_,boost::is_any_of(","));
  split(considerOnly_,considerOnlyStr_,boost::is_any_of(","));
  
  // automatically determine nCats from flashggCats input
  if (isFlashgg_){
    ncats_ =flashggCats_.size();
    // Ensure that the loop over the categories does not go out of scope. 
  } else {
    std::cout 
      << "[ERROR] Sorry, script not compatible with non-flashgg input! Exit." 
      << std::endl;
    exit (1);
  }

  // job splitting: can get this script to only consider specified tags
  for (unsigned int j =0; j <considerOnly_.size() ; j++){
    std::cout << " [INFO] considering only " << considerOnly_[j]<<std::endl;
  }

  // Open input files using WS wrapper.
  WSTFileWrapper *inWS 
    = new WSTFileWrapper(filename_,"tagsDumper/cms_hgg_13TeV");
  if(verbose_) std::cout << "[INFO] Opened files OK!" << std::endl;
  RooRealVar *mass = (RooRealVar*)inWS->var("CMS_hgg_mass");
  if(verbose_) std::cout << "[INFO] Got mass variable " << mass << std::endl;
  //mass->setBins(80);
  mass->setBins(nBins);
  mass->setRange(rangeLow,rangeHigh);
  //mass->setBins(20);

  // duplicate MH variable ? need to remove this ?? LC
  RooRealVar *MH = new RooRealVar("MH","MH",mass_);
  MH->setVal(mass_);
  MH->setConstant(true);
  MH->setBins(nBins);
  MH->setRange(rangeLow,rangeHigh);

  // record chosen nGaussians... 
  // This is really a bit useless: we are still picking the nGaussians by eye.
  map<string,pair<int,int> > choices;
  map<string,vector<RooPlot*> > plots;
  map<string,vector<RooPlot*> > plotsRV;
  map<string,vector<RooPlot*> > plotsWV;
  
  // declare temporary Plots/Frames, one for each proc and cat to consider.
  if(verbose_) std::cout << "[INFO] start looping through nProcs " << procs.size() << " to book rooPlots " <<  std::endl;
  for (unsigned int p=0; p<procs.size(); p++){
    vector<RooPlot*> temp;
    vector<RooPlot*> tempRV;
    vector<RooPlot*> tempWV;
    if(verbose_) std::cout << "[INFO] on proc " << procs[p] <<  " start looping through nCats " << ncats_ << " to book RooPlots " <<  std::endl;
    for (int cat=0; cat<ncats_; cat++){
      //RooPlot *plotRV = mass->frame(Range(mass_-10,mass_+10));
      RooPlot *plotRV = mass->frame(Range(rangeLow,rangeHigh));
      plotRV->SetTitle(
		       Form("%s_%s_RV",procs[p].c_str(),flashggCats_[cat].c_str()));
      tempRV.push_back(plotRV);
      //RooPlot *plotWV = mass->frame(Range(mass_-10,mass_+10));
      RooPlot *plotWV = mass->frame(Range(rangeLow,rangeHigh));
      plotWV->SetTitle(
		       Form("%s_%s_WV",procs[p].c_str(),flashggCats_[cat].c_str()));
      tempWV.push_back(plotWV);

      //combine dataset
      RooPlot *plot = mass->frame(Range(rangeLow,rangeHigh));
      plot->SetTitle(
		     Form("%s_%s",procs[p].c_str(),flashggCats_[cat].c_str()));
      temp.push_back(plot);
    }
    plots.insert(pair<string,vector<RooPlot*> >(procs[p],temp));
    plotsRV.insert(pair<string,vector<RooPlot*> >(procs[p],tempRV));
    plotsWV.insert(pair<string,vector<RooPlot*> >(procs[p],tempWV));
  }
  
  // decide what color to make the fits in output plots...
  vector<int> colors;
  colors.push_back(kBlue);
  colors.push_back(kRed);
  colors.push_back(kGreen+2);
  colors.push_back(kMagenta+1);

  // continue flag is used to tell the script to ignore some
  // cases if we are using a considerOnly option.
  bool continueFlag =0;
  if(verbose_) std::cout << "[INFO] start looping through nCats " << ncats_ << " to get datasets " <<std::endl;
  for (int cat=0; cat<ncats_; cat++){
    
    if ( (considerOnly_[0]).compare("All") != 0 ){
      for (unsigned int j =0; j <considerOnly_.size() ; j++){
	if ( (considerOnly_[j]).compare(flashggCats_[cat]) != 0) { 
	  std::cout << " [INFO] skipping " <<  flashggCats_[cat] << std::endl;
	  continueFlag=1;
	}
      }
    }
    
    if (continueFlag){ continueFlag=0; continue;}
    

	       
    if(verbose_) std::cout << "[INFO] on cat " << flashggCats_[cat] <<  " start looping through procs  " << procs.size() << " to get datasets " <<std::endl;
    // now main loop through processes...

    cout << "[TEX] \\documentclass[11pt]{article}" << endl;
    cout << "[TEX] \\usepackage{graphicx}" << endl;
    cout << "[TEX] \\begin{document}" << endl;
    cout << "[TEX] " << endl;
    cout << "[TEX] \\title{}" << endl;
    cout << "[TEX] \\author{}" << endl;
    cout << "[TEX] \\date{}" << endl;
    cout << "[TEX] \\maketitle" << endl;
    cout << "[TEX] " << endl;
    
    for (unsigned int p=0; p<procs.size(); p++){
      
      // get desired proc
      string proc = procs[p];

      //declare the datasets to use
			RooDataSet *data;  
			RooDataSet *dataRV;
			RooDataSet *dataWV; 
      
      // We want to reduce our datasets, so just get the most important vars.
      RooRealVar *mass = (RooRealVar*)inWS->var("CMS_hgg_mass");
      //RooRealVar *dZ = (RooRealVar*)inWS->var("dZ");
      RooRealVar *weight0 = new RooRealVar("weight","weight",-100000,1000000);
      RooRealVar *dZ = new RooRealVar("dZ","dZ",-100000,1000000);
      if (verbose_) std::cout << "[INFO] got roorealvars from ws ? mass " << mass << " dz " << dZ << std::endl;
      
      // access dataset and immediately reduce it!
      if (isFlashgg_){
	RooDataSet *data0   = (RooDataSet*)inWS->data(
						      Form("%s_%d_13TeV_%s",proc.c_str(),mass_,flashggCats_[cat].c_str()));
        if(verbose_) {
          std::cout << "[INFO] got dataset data0 ? " << data0 << "now make empty clones " << std::endl;
          if (data0) {
            std::cout << "[INFO] and it looks like this : " << *data0 << std::endl;
          } else {
            std::cout << "[INFO] but it is a null pointer! extit " << std::endl;
            exit (1);
          }
        }
        
        data   = (RooDataSet*) data0->emptyClone()->reduce(RooArgSet(*mass, *dZ));
        dataRV = (RooDataSet*) data0->emptyClone()->reduce(RooArgSet(*mass, *dZ));
        dataWV = (RooDataSet*) data0->emptyClone()->reduce(RooArgSet(*mass, *dZ));

        for (unsigned int i=0 ; i < data0->numEntries() ; i++){
	  if (data0->get(i)->getRealValue("CMS_hgg_mass") > 115 && data0->get(i)->getRealValue("CMS_hgg_mass") <135 ){
            mass->setVal(data0->get(i)->getRealValue("CMS_hgg_mass"));
            weight0->setVal(data0->weight() ); // <--- is this correct?
            dZ->setVal(data0->get(i)->getRealValue("dZ"));
            data->add( RooArgList(*mass, *dZ, *weight0), weight0->getVal() );
            if (dZ->getVal() <1.){
	      dataRV->add( RooArgList(*mass, *dZ, *weight0), weight0->getVal() );
            } else{
	      dataWV->add( RooArgList(*mass, *dZ, *weight0), weight0->getVal() );
            }
	  }
	}

        //print out contents, if you want... 
	if (verbose_) {
	  std::cout << "[INFO] Workspace contains : " << std::endl;
	  std::list<RooAbsData*> data =  (inWS->allData()) ;
	  for (std::list<RooAbsData*>::const_iterator 
		 iterator = data.begin(), end = data.end();
	       iterator != end;
	       ++iterator) {
	    std::cout << **iterator << std::endl;
	  }
	}
        
        //more verbosity
	if (verbose_) {
          std::cout 
            << "[INFO] Retrieved combined RV/WV data " 
            << Form("%s_%d_13TeV_%s",proc.c_str(),mass_,flashggCats_[cat].c_str()) 
            << "? "<< data<<std::endl;
        }
        
        // now split RV/WV scenarios
        // this method of reducing the dataset is not safe, I think it ignores
        // events with negative weights entirely!
        // See workaround above
	//dataRV = new RooDataSet("dataRV","dataRV",&*data,*(data->get()),"dZ<1");
	//dataWV = new RooDataSet("dataWV","dataWV",&*data,*(data->get()),"dZ>=1");
	if (verbose_) std::cout << "[INFO] Retrieved unreduced data"<< *data0  << std::endl;
	if (verbose_) std::cout << "[INFO] Retrieved reduced   data"<< *data    << std::endl;
	if (verbose_) std::cout << "[INFO] Retrieved reducedRV data"<< *dataRV  << std::endl;
	if (verbose_) std::cout << "[INFO] Retrieved reducedWV data"<< *dataWV  << std::endl;

      } else { // not flash!
      
        std::cout << "[ERROR] Sorry, only use flashgg input with this script."
		  << " Exit." << std::endl;
        exit(1);
      }
			
      cout <<  Form("[TEX] \\section{RV proc %s cat $%s$}", proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\begin{tabular}{ l l l l l l l }" << endl;
      cout << "[TEX] \\hline" << endl;
      cout << "[TEX]   Order & Mean & Sigma & Dist & chi2 & entries & dist/entrie\\\\" << endl;
      // which nGaussians do we want to choose?
      int rvChoice=0;
      int wvChoice=0;

      // right vertex
      int order=1;
      int prev_order=0;
      int cache_order=0;
      double thisNll=0.;
      //double prevNll=1.e6;
      double prevNll=0;
      double chi2=0.;
      double prob=0.;
      std::vector<pair<int,float> > rv_results;
      std::vector<pair<int,float> > rv_chi2;
      float rv_prob_limit =999;

      dataRV->plotOn(plotsRV[proc][cat]);

      TCanvas *ccResRV  = new TCanvas("ccResRV","Residuals",600,600);
      TCanvas *ccPullRV = new TCanvas("ccPullRV","Pulls",600,600);
      TCanvas *ccpPullRV = new TCanvas("ccpPullRV","PullsProjections",600,600);
	
      RooDataHist * dataRVbinned = 0;
      while (prob<rv_prob_limit && order <5){ 
			  
        // build sum of gaussians of correct order
	
        RooAddPdf *pdf = buildSumOfGaussians(Form("cat%d_g%d",cat,order),mass,MH,order);
	

	//MDDB fit binned dataset
	dataRVbinned = new RooDataHist("dataRVbinned","dataRVbinned",*mass,*dataRV); 
	RooFitResult *fitRes = pdf->fitTo(*dataRVbinned,Save(true),
					  RooFit::Minimizer("Minuit","minimize"),
					  SumW2Error(true),Verbose(false),Range(mass_-10,mass_+10)); 
		
        // do the unbinned fit
	// RooFitResult *fitRes = pdf->fitTo(*dataRV,Save(true),
	// 				  RooFit::Minimizer("Minuit","minimize"),
	// 				  SumW2Error(true),Verbose(false),Range(mass_-10,mass_+10)); 

	cout << "[MDDB] --------------------------------------------------"<< endl;
	cout << "[MDDB] RV names " << endl;
	dataRV->Print();
	pdf->Print();
	
	ccResRV->cd();
	RooPlot* frame2 = mass->frame() ;
	//	dataRV->plotOn(frame2);
	dataRVbinned->plotOn(frame2);
	pdf->plotOn(frame2);
	RooPlot* frame3 = mass->frame();
	RooHist *hres = frame2->residHist() ;
	hres->SetMarkerStyle(24+order);
	hres->SetMarkerColor(colors[order-1]);
	hres->SetLineColor(colors[order-1]);
	if (order == 1) hres->Draw("");
	hres->Draw("same");
	gPad->Update();
	
	ccPullRV->cd();
	RooHist *hpull = frame2->pullHist() ;
 	hpull->SetMarkerStyle(24+order);
	hpull->SetMarkerColor(colors[order-1]);
	hpull->SetLineColor(colors[order-1]);
	if (order == 1) hpull->Draw("");
	hpull->Draw("same");
	gPad->Update();

	ccpPullRV->cd();
	TH1F *hpp = new TH1F("hpp","hpp",20,-10,10);
	for (int ib = 1 ; ib <hpull->GetN()+1; ++ib){
	  double x = -999;
	  double y = -999;
	  int tmp = hpull->GetPoint(ib,x,y);
	  if (tmp != -1) hpp->Fill(y);
	}
 	hpp->SetMarkerStyle(24+order);
	hpp->SetMarkerColor(colors[order-1]);
	hpp->SetLineColor(colors[order-1]);	
	TF1 *f = new TF1("f","gaus(0)",-10,10);
	f->SetParameters(1,0,1);
	f->SetLineColor(colors[order-1]);	
	TFitResultPtr r = hpp->Fit("f","SL","same");
	float_t fitchi2   = r->Chi2(); 
	if (order == 1) {
	  hpp->SetMaximum(15);
	  hpp->Draw("");
	}
	hpp->Draw("same");
	gPad->Update();

	float myDistance = sqrt(f->GetParameter(1)*f->GetParameter(1) + (f->GetParameter(2)-1)*(f->GetParameter(2)-1)); //  + dKurt*dKurt + dSkew*dSkew);

	cout << "[MDDB] proc RV: " << proc << " cat " << flashggCats_[cat] << " order " << order << " --> Mean = " << f->GetParameter(1) << " Sigma = " << f->GetParameter(2) << " myDist = " << myDistance << " chi2 = " << fitchi2 <<  endl;
	cout << "[TEX]  " << order << " &" << f->GetParameter(1) << " & " << f->GetParameter(2) << " & " << myDistance << " & " << fitchi2 <<  " & " << dataRVbinned->numEntries() <<  " & " << myDistance/dataRVbinned->numEntries() << "\\\\" << endl;
	cout << "[MDDB] --------------------------------------------------"<< endl;



        //get NLL
        double myNll=0.;
	thisNll = fitRes->minNll();
        // maybe better way to do it ?
	//double myNll = getMyNLL(mass,pdf,dataRV);
	//thisNll = getMyNLL(mass,pdf,dataRV);
	//RooAbsReal *nll = pdf->createNLL(*dataRV);
	//RooMinuit m(*nll);
	//m.migrad();
	//thisNll = nll->getVal();
	//plot(Form("plots/fTest/%s_cat%d_g%d_rv",proc.c_str(),cat,order),
        //  mass_,mass,dataRV,pdf);
	chi2 = 2.*(prevNll-thisNll);
				
        // alternative, simpler chi2... but assumed high stats?
        float chi2_bis= (plotsRV[proc][cat])->chiSquare();
        
        // plot this order
	pdf->plotOn(plotsRV[proc][cat],LineColor(colors[order-1]));


	if (chi2<0. && order>1) chi2=0.;
	int diffInDof = (2*order+(order-1))-(2*prev_order+(prev_order-1));
	//int diffInDof = (order- prev_order);
	//prob = TMath::Prob(chi2,diffInDof);
	float prob_old = TMath::Prob(chi2,diffInDof);
	prob = TMath::Prob(chi2_bis,2*order+(order-1));

	//Wilk's theorem
	cout << "[INFO] \t RV: proc " << proc << " cat " 
	     << flashggCats_[cat] << " order " << order << " diffinDof " 
	     << diffInDof << " prevNll " << prevNll << " this Nll " << thisNll 
	     << " myNll " << myNll << " chi2 " << chi2 << " chi2_bis " 
	     << chi2_bis<<  " prob_old " << prob_old << ", prob_new " 
	     <<  prob << endl;

	// MDDB rv_results.push_back(std::make_pair(order,prob));
	rv_results.push_back(std::make_pair(order,myDistance)); // MDDB
	rv_chi2.push_back(std::make_pair(order,fitchi2)); // MDDB

	prevNll=thisNll;
	cache_order=order;
	prev_order=order;
	order++;
      }

      //MDDB
      ccResRV->Print(Form("%s/fTest/res_%s_cat_%s_rv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      ccResRV->Print(Form("%s/fTest/res_%s_cat_%s_rv.pdf", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccResRV;
      ccPullRV->Print(Form("%s/fTest/pull_%s_cat_%s_rv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      ccPullRV->Print(Form("%s/fTest/pull_%s_cat_%s_rv.pdf", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccPullRV;
      ccpPullRV->Print(Form("%s/fTest/ppull_%s_cat_%s_rv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      ccpPullRV->Print(Form("%s/fTest/ppull_%s_cat_%s_rv.pdf", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccpPullRV;

      cout << "[TEX] \\end{tabular}" << endl;
      cout << "[TEX] "<< endl;
      cout << "[TEX] \\begin{figure}[htbp]" << endl;
      cout << "[TEX] \\begin{center}" << endl;
      cout << Form("[TEX] \\includegraphics[width=15.0cm]{%s/sigfTest/rv_%s_%s}"  , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\end{center}" << endl;
      cout << "[TEX] \\end{figure}" << endl;
      cout << "[TEX] \\begin{figure}[htbp]" << endl;
      cout << "[TEX] \\begin{center}" << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/res_%s_cat_%s_rv}\\\\"  , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/pull_%s_cat_%s_rv}" , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/ppull_%s_cat_%s_rv}", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\end{center}" << endl;
      cout << "[TEX] \\end{figure}" << endl;


      // MDDB this is the original snippet of code
      // if (prob <rv_prob_limit){
      // 	float maxprob=-1;
      // 	for(unsigned int i =0; i<rv_results.size(); i++){
      // 	  if (rv_results[i].second > maxprob){
      // 	    maxprob=rv_results[i].second;
      // 	    rvChoice=rv_results[i].first;
      // 	  }
      // 	}
      // }else {
      // 	rvChoice=cache_order;
      // }

      // Choose the #gaussians RV
      float minDist = 9999999;
      float minchi2 = 9999999;
      rvChoice = 1;
      if (dataRV->numEntries() > minNevts){
      	for(unsigned int i =0; i<rv_results.size(); i++){
	  // if distance is small enough just use this #gauss, where enough is set by itsOK
	  if (rv_results[i].second < itsOK){
	    rvChoice = rv_results[i].first;	  
	    break;
	  }
	  // look for the "significantly" smaller distance, where significantly is set by myThresholdDist 
      	  if (rv_results[i].second < minDist*myThresholdDist){
      	    minDist  = rv_results[i].second;
	    minchi2  = rv_chi2[i].second;
      	    rvChoice = rv_results[i].first;	  
      	  } 
	  else // look for the "significantly" smaller chi2, where significantly is set by myThresholdChi2
	    if (rv_chi2[i].second < minchi2*myThresholdChi2){
	    minDist  = rv_results[i].second;
	    minchi2  = rv_chi2[i].second;
      	    rvChoice = rv_results[i].first;	  	    
	  }
      	}
      } else {
      	rvChoice = -1;
      }

      cout <<  "[TEX] Suggested number of gaussians: " << rvChoice << endl;
      cout << "[TEX] \\newpage" << endl;

    
      // wrong vertex
      order=1;
      prev_order=0;
      cache_order=0;
      thisNll=0.;
      //prevNll=1.e6;
      prevNll=0;
      chi2=0.;
      prob=0.;
      std::vector<pair<int,float> > wv_results;
      std::vector<pair<int,float> > wv_chi2;
      float wv_prob_limit = 999;

      dataWV->plotOn(plotsWV[proc][cat]);

      cout <<  Form("[TEX] \\section{WV proc %s cat $%s$}", proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\begin{tabular}{ l l l l l l l }" << endl;
      cout << "[TEX] \\hline" << endl;
      cout << "[TEX]   Order & Mean & Sigma & Dist & chi2 & entries & dist/entries\\\\" << endl;
    
      TCanvas *ccResWV  = new TCanvas("ccResWV","Residuals",600,600);
      TCanvas *ccPullWV = new TCanvas("ccPullWV","Pulls",600,600);
      TCanvas *ccpPullWV = new TCanvas("ccpPullWV","PullsProjections",600,600);

      //see comments in the RV section above.
      RooDataHist * dataWVbinned = 0;
      while (prob<wv_prob_limit && order <4){ 
	RooAddPdf *pdf = buildSumOfGaussians(
					     Form("cat%d_g%d",cat,order),mass,MH,order);

	//MDDB fit binned dataset
	dataWVbinned = new RooDataHist("dataWVbinned","dataWVbinned",*mass,*dataWV); 
	RooFitResult *fitRes = pdf->fitTo(*dataWVbinned,Save(true),
					  RooFit::Minimizer("Minuit","minimize"),
					  SumW2Error(true),Verbose(false),Range(mass_-10,mass_+10)); 


	// RooFitResult *fitRes = pdf->fitTo(*dataWV,
	// 				  Save(true),RooFit::Minimizer("Minuit","minimize"),
	// 				  SumW2Error(true),Verbose(false),Range(mass_-10,mass_+10));

	double myNll=0.;
	thisNll = fitRes->minNll();
	//double myNll = getMyNLL(mass,pdf,dataWV);
	//thisNll = getMyNLL(mass,pdf,dataWV);
	//RooAbsReal *nll = pdf->createNLL(*dataWV);
	//RooMinuit m(*nll);
	//m.migrad();
	//thisNll = nll->getVal();
	//plot(Form("plots/fTest/%s_cat%d_g%d_wv",
        //  proc.c_str(),cat,order),mass_,mass,dataWV,pdf);
        //
	pdf->plotOn(plotsWV[proc][cat],LineColor(colors[order-1]));
	chi2 = 2.*(prevNll-thisNll);
	float chi2_bis= (plotsWV[proc][cat])->chiSquare();
	if (chi2<0. && order>1) chi2=0.;
	int diffInDof = (2*order+(order-1))-(2*prev_order+(prev_order-1));
	//int diffInDof = (order-prev_order);
	//prob = TMath::Prob(chi2,diffInDof);
	float prob_old = TMath::Prob(chi2,diffInDof);
	prob  = TMath::Prob(chi2_bis,2*order+(order-1));



	//MDDB
	cout << "[MDDB] --------------------------------------------------"<< endl;
	cout << "[MDDB] WV names " << endl;
	dataWVbinned->Print();
	pdf->Print();
	
	ccResWV->cd();
	RooPlot* frame2 = mass->frame() ;
	dataWVbinned->plotOn(frame2);
	pdf->plotOn(frame2);
	RooPlot* frame3 = mass->frame();
	RooHist *hres = frame2->residHist() ;
	hres->SetMarkerStyle(24+order);
	hres->SetMarkerColor(colors[order-1]);
	hres->SetLineColor(colors[order-1]);
	if (order == 1) hres->Draw("");
	hres->Draw("same");
	gPad->Update();
	
	ccPullWV->cd();
	RooHist *hpull = frame2->pullHist() ;
 	hpull->SetMarkerStyle(24+order);
	hpull->SetMarkerColor(colors[order-1]);
	hpull->SetLineColor(colors[order-1]);
	if (order == 1) hpull->Draw("");
	hpull->Draw("same");
	gPad->Update();

	ccpPullWV->cd();
	TH1F *hpp = new TH1F("hpp","hpp",20,-10,10);
	for (int ib = 1 ; ib <hpull->GetN()+1; ++ib){
	  double x = -999;
	  double y = -999;
	  int tmp = hpull->GetPoint(ib,x,y);
	  if (tmp != -1) hpp->Fill(y);
	}
 	hpp->SetMarkerStyle(24+order);
	hpp->SetMarkerColor(colors[order-1]);
	hpp->SetLineColor(colors[order-1]);	
	TF1 *f = new TF1("f","gaus(0)",-10,10);
	f->SetParameters(1,0,1);
	f->SetLineColor(colors[order-1]);	
	TFitResultPtr r = hpp->Fit("f","SL","same");
	Double_t fitchi2   = r->Chi2(); 
	if (order == 1) {
	  hpp->SetMaximum(15);
	  hpp->Draw("");
	}
	hpp->Draw("same");
	gPad->Update();

	float myDistance = sqrt(f->GetParameter(1)*f->GetParameter(1) + (f->GetParameter(2)-1)*(f->GetParameter(2)-1)); //  + dKurt*dKurt + dSkew*dSkew);

	cout << "[MDDB] proc WV: " << proc << " cat " << flashggCats_[cat] << " order " << order << " --> Mean = " << f->GetParameter(1) << " Sigma = " << f->GetParameter(2) << " myDist = " << myDistance << " chi2 = " << fitchi2 <<  endl;
	cout << "[TEX]  " << order << " &" << f->GetParameter(1) << " & " << f->GetParameter(2) << " & " << myDistance << " & " << fitchi2 <<  " & " << dataWVbinned->numEntries() <<  " & " << myDistance/dataWVbinned->numEntries()  << "\\\\" << endl;
	cout << "[MDDB] --------------------------------------------------"<< endl;


      


	
	//Wilk's theorem
	cout << "[INFO] \t WV: proc " << proc <<" cat " 
	     << flashggCats_[cat] << " order " << order << " diffinDof " 
	     << diffInDof << " prevNll " << prevNll << " thosNll " 
	     << thisNll << " myNll" << myNll << " chi2" << chi2 << " chi2 bis " 
	     << chi2_bis << " prob_old " << prob_old << " prob_new " 
	     << prob <<  endl;

	// MDDB 	wv_results.push_back(std::make_pair(order,prob));
	wv_results.push_back(std::make_pair(order,myDistance)); //MDDB
	wv_chi2.push_back(std::make_pair(order,fitchi2)); //MDDB

	prevNll=thisNll;
	cache_order=order;
	prev_order=order;
	order++;
      }

      //MDDB
      ccResWV->Print(Form("%s/fTest/res_%s_cat_%s_wv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccResWV;
      ccPullWV->Print(Form("%s/fTest/pull_%s_cat_%s_wv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccPullWV;
      ccpPullWV->Print(Form("%s/fTest/ppull_%s_cat_%s_wv.png", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()));	
      delete ccpPullWV;

      cout << "[TEX] \\end{tabular}" << endl;
      cout << "[TEX] "<< endl;
      cout << "[TEX] \\begin{figure}[htbp]" << endl;
      cout << "[TEX] \\begin{center}" << endl;
      cout << Form("[TEX] \\includegraphics[width=15.0cm]{%s/sigfTest/wv_%s_%s}"  , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\end{center}" << endl;
      cout << "[TEX] \\end{figure}" << endl;
      cout << "[TEX] \\begin{figure}[htbp]" << endl;
      cout << "[TEX] \\begin{center}" << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/res_%s_cat_%s_wv}\\\\"  , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/pull_%s_cat_%s_wv}" , outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << Form("[TEX] \\includegraphics[width=5.0cm]{%s/sigfTest/ppull_%s_cat_%s_wv}", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;
      cout << "[TEX] \\end{center}" << endl;
      cout << "[TEX] \\end{figure}" << endl;


      // MDDB otiginal snippet of code
      // if (prob <wv_prob_limit){
      // 	float maxprob=-1;
      // 	for(unsigned int i =0; i<wv_results.size(); i++){
      // 	  if (wv_results[i].second > maxprob){
      // 	    maxprob=wv_results[i].second;
      // 	    wvChoice=wv_results[i].first;
      // 	  }
      // 	}
      // }else {
      // 	wvChoice=cache_order;
      // }
      
      // Choose the #gaussians WV
      minDist = 9999999;
      minchi2 = 9999999;
      wvChoice = 1;
      if (dataWV->numEntries() > minNevts){
	for(unsigned int i =0; i<wv_results.size(); i++){
	  // if distance is small enough just use this #gauss, where enough is set by itsOK
      	  if (wv_results[i].second < itsOK){
	    wvChoice = wv_results[i].first;	  
	    break;
	  }
	  // look for the "significantly" smaller distance, where significantly is set by myThresholdDist 
	  if (wv_results[i].second < minDist*myThresholdDist){
	    minDist  = wv_results[i].second;
	    minchi2  = wv_chi2[i].second;
	    wvChoice = wv_results[i].first;	  
	  } 
	  else // look for the "significantly" smaller chi2, where significantly is set by myThresholdChi2
	    if (wv_chi2[i].second < minchi2*myThresholdChi2){
	      minDist  = wv_results[i].second;
	      minchi2  = wv_chi2[i].second;
	      wvChoice = wv_results[i].first;	  	    
	    }
	}
      } else {
	wvChoice = -1;
      }

      cout <<  "[TEX] Suggested number of gaussians: " << wvChoice << endl;

      // insert final choices!
      choices.insert(pair<string,pair<int,int> >(
						 //Form("%s %d",proc.c_str(),cat),make_pair(rvChoice,wvChoice)));
						 //
						 //let's see if this works..
						 Form("%s %s",proc.c_str(),flashggCats_[cat].c_str()),
						 make_pair(rvChoice,wvChoice)));
    } 
  }
  
  // now make the plots! Start with legend
  TLegend *leg = new TLegend(0.7,0.7,0.89,0.89);
  leg->SetFillColor(0);
  leg->SetLineColor(0);
  TH1F *h1 = new TH1F("h1","",1,0,1);
  h1->SetLineColor(colors[0]);
  leg->AddEntry(h1,"1st order","L");
  TH1F *h2 = new TH1F("h2","",1,0,1);
  h2->SetLineColor(colors[1]);
  leg->AddEntry(h2,"2nd order","L");
  TH1F *h3 = new TH1F("h3","",1,0,1);
  h3->SetLineColor(colors[2]);
  leg->AddEntry(h3,"3rd order","L");
  TH1F *h4 = new TH1F("h4","",1,0,1);
  h4->SetLineColor(colors[3]);
  leg->AddEntry(h4,"4th order","L");
  leg->SetShadowColor(kWhite);

  // make the canvas
  TCanvas *canv = new TCanvas("c","c",50,50,800,600);
	
  // start with the RV plots
  for (map<string,vector<RooPlot*> >::iterator plotIt=plotsRV.begin();
       plotIt!=plotsRV.end();
       plotIt++){
    string proc = plotIt->first;
    for (int cat=0; cat<ncats_; cat++){
      if ( (considerOnly_[0]).compare("All") != 0 ){
	for (unsigned int j =0; j <considerOnly_.size() ; j++){
	  if ( (considerOnly_[j]).compare(flashggCats_[cat]) != 0) { 
	    //std::cout << " [INFO] skipping " 
	    //  <<  flashggCats_[cat] << std::endl;
	    continueFlag=1;
	  }
	}
      }

      //only make plots we asked for...
      if (continueFlag){ continueFlag=0; continue;}
      
      //actual plotting
      RooPlot *plot = plotIt->second.at(cat);
      plot->Draw();

      //make it a nice CMS style plot!
      string sim="Simulation Preliminary";
      CMS_lumi( canv, 0, 0, sim ); // CMS prefer option 11 i
                                   //but out of frame (0) looks nicer!!!


      //legend
      leg->Draw();
      
      //catname
      TLatex *latex = new TLatex();	
      latex->SetTextSize(0.038);
      latex->SetNDC();
      latex->DrawLatex(0.16,0.78,Form("#splitline{%s}{%s}",proc.c_str(),flashggCats_[cat].c_str()));
      latex->DrawLatex(0.16,0.88,Form("Right Vertex (#Delta Z < 1.)"));

      // save it !
      cout << "[MDDB] Printing " << Form("%s/fTest/rv_%s_%s.pdf", outdir_.c_str(),proc.c_str(), flashggCats_[cat].c_str()) << endl;

      canv->Print(Form("%s/fTest/rv_%s_%s.pdf",
		       outdir_.c_str(),proc.c_str(),
		       flashggCats_[cat].c_str()));
      canv->Print(Form("%s/fTest/rv_%s_%s.png",
		       outdir_.c_str(),proc.c_str(),
		       flashggCats_[cat].c_str()));
    }
  }

  // now plot the WV
  for (map<string,vector<RooPlot*> >::iterator plotIt=plotsWV.begin();
       plotIt!=plotsWV.end();
       plotIt++){
    string proc = plotIt->first;
    for (int cat=0; cat<ncats_; cat++){
      if ( (considerOnly_[0]).compare("All") != 0 ){
	for (unsigned int j =0; j <considerOnly_.size() ; j++){
	  if ( (considerOnly_[j]).compare(flashggCats_[cat]) != 0) { 
	    //std::cout << " [INFO] skipping " 
	    //  <<  flashggCats_[cat] << std::endl;
	    continueFlag=1;
	  }
	}
      }
      if (continueFlag){ continueFlag=0; continue;}
      RooPlot *plot = plotIt->second.at(cat);
      plot->Draw();

      //cms style
      string sim="Simulation";
      CMS_lumi( canv, 0,0 , sim); // out of frame (0,0) 
      //looks nicer than corner (0,16)

      //legend
      leg->Draw();
      
      //catname
      TLatex *latex = new TLatex();	
      latex->SetTextSize(0.038);
      latex->SetNDC();
      latex->DrawLatex(0.16,0.78,Form("#splitline{%s}{%s}",proc.c_str(),flashggCats_[cat].c_str()));
      latex->DrawLatex(0.16,0.88,Form("Wrong Vertex (#Delta Z #geq 1.)"));

      //save plots
      canv->Print(Form("%s/fTest/wv_%s_%s.pdf",
		       outdir_.c_str(),proc.c_str(),flashggCats_[cat].c_str()));
      canv->Print(Form("%s/fTest/wv_%s_%s.png",
		       outdir_.c_str(),proc.c_str(),flashggCats_[cat].c_str()));
    }
  }
  
  // and the combined plots.
  for (map<string,vector<RooPlot*> >::iterator plotIt=plots.begin();
       plotIt!=plots.end();
       plotIt++){
    string proc = plotIt->first;
    for (int cat=0; cat<ncats_; cat++){
      if ( (considerOnly_[0]).compare("All") != 0 ){
	for (unsigned int j =0; j <considerOnly_.size() ; j++){
	  if ( (considerOnly_[j]).compare(flashggCats_[cat]) != 0) { 
	    //std::cout << " [INFO] skipping " 
	    //  <<  flashggCats_[cat] << std::endl;
	    continueFlag=1;
	  }
	}
      }

      //only make plots we asked for...
      if (continueFlag){ continueFlag=0; continue;}
      
      //actual plotting
      RooPlot *plot = plotIt->second.at(cat);
      plot->Draw();

      //make it a nice CMS style plot!
      string sim="Simulation";
      CMS_lumi( canv, 0, 0, sim ); // CMS prefer option 16 i
                                   //but out of frame (0) looks nicer!!!


      //legend
      leg->Draw();
      
      //catname
      TLatex *latex = new TLatex();	
      latex->SetTextSize(0.038);
      latex->SetNDC();
      latex->DrawLatex(0.16,0.78,Form("#splitline{%s}{%s}",proc.c_str(),flashggCats_[cat].c_str()));
      latex->DrawLatex(0.16,0.88,Form("RV+WV"));

      // save it !
      //canv->Print(Form("%s/fTest/%s_%s.pdf",
      //  outdir_.c_str(),proc.c_str(),
      //  flashggCats_[cat].c_str()));
      //canv->Print(Form("%s/fTest/%s_%s.png",
      //  outdir_.c_str(),proc.c_str(),
      //  flashggCats_[cat].c_str()));
      //  ^ NB at the moment the combiend plot is not terribly useful, so ignore it for now.
    }
  }

  //no memory leaks please!
  delete canv;
  
  //finally, rpint otu recommended options. This is kinda useless right now..
  cout << "[INFO] Recommended options" << endl;
  ofstream output_datfile;

  //write them to a file, I guess..
  output_datfile.open ((datfilename_).c_str());
  if (verbose_) std::cout << "[INFO] Writing to datfilename_ " 
			  << datfilename_ << std::endl;
  output_datfile << "#proc cat nGausRV nGausWV" << std::endl;
  int p =0;

  for (map<string,pair<int,int> >::iterator it=choices.begin();
       it!=choices.end();
       it++){
      
    //print to screen
    cout << "[INFO] \t "  <<" "<< it->first 
	 << " " << it->second.first << " " 
	 << it->second.second << endl;

    //print to file
    output_datfile<< it->first 
		  << " " << it->second.first 
		  << " " << it->second.second << endl;
    p++; // what is p doing ?
  }

  cout << "[TEX]\\end{document}" << endl;
  
  output_datfile.close();
  inWS->Close();
  return 0;
}
