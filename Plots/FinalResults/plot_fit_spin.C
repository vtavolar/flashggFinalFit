{
	using namespace RooFit;

	gSystem->Load("libHiggsAnalysisCombinedLimit");
	//	gSystem->Load("libdiphotonsUtils");
	
	// RooAbsData * data = w->data("data_obs");
	RooAbsData * data = _file0->Get("toys/toy_asimov");
	_file0->cd();
	
	w->loadSnapshot("GenerateOnly");
	//	_file1->cd();
	//w->loadSnapshot("MultiDimFit");
	w->exportToCint("ws");
	std::cout<<w->GetName()<<std::endl;
	RooCategory & cat = ws::CMS_channel;
	cat->Print();

	RooSimultaneousOpt & sim = ws::model_s;
	
        TList *datasets = data->split(cat, true);
        TIter next(datasets);
	// ws::mgg.setBins(25,"plotBinning");	
	
	std::map<std::string,std::string> names;

////        for (RooAbsData *ds = (RooAbsData *) next(); ds != 0; ds = (RooAbsData *) next()) {
////		
////            RooAbsPdf *pdfi  = sim->getPdf(ds->GetName());
////	    std::cout<<"this is the pdf"<<std::endl;
////	    pdfi->Print();
////	    RooArgSet * vars = pdfi->getDependents(ds->get());
////	    std::cout<<"these are the vars"<<std::endl;
////	    vars->Print();
////	    RooRealVar * obs = RooArgList(*vars).at(0);
////	    obs->SetTitle("m_{#gamma #gamma}");
////	    obs->setUnit("GeV");
////	    
////	    std::cout<<ds->GetName()<<std::endl;
////	    TString name =  ds->GetName() ;
////	    std::cout<<"this is the name"<<std::endl;
////	    std::cout<<name<<std::endl;
////
////	    // RooRealVar * data_obs = 
////	    // obs->setMin(500); obs->setMax(920);
////	    // obs->setBins( int( ( obs->getMax() - obs->getMin() ) / 20. ) );
////	    obs->setBins( 160 );
////	    // RooPlot * framei = obs->frame(Title(ds->GetName()),Range("plotBinning"));
////	    RooPlot * framei;
////	    std::cout<<"after framei"<<std::endl;
////	    framei=obs->frame();
//////	    if( name == "EBEE" ) {
//////		    framei = obs->frame(330,1610,65);
//////	    } else {
//////		    framei = obs->frame(230,1600,69);
//////	    }
////
////	    /// RooPlot * framei = ws::mgg.frame(Title(ds->GetName()),Range("plotBinning"));
////	    
////	    
////	    ds->plotOn(framei,DataError(RooAbsData::Poisson));
////	    std::cout<<"after ds ploton"<<std::endl;
////	    pdfi->plotOn(framei,LineColor(kBlue));//,ProjectionRange("sig_region"));
////	    pdfi->plotOn(framei,LineColor(kBlue),LineStyle(7),Components("*bkg*"));
////	    /// pdfi->plotOn(framei,LineColor(kRed),Components("*pf*"));//,ProjectionRange("sig_region"));
////	    /// pdfi->plotOn(framei,LineColor(kOrange),Components("*ff*"));//,ProjectionRange("sig_region"));
////	    
////	    TCanvas * canvi = new TCanvas(ds->GetName(),ds->GetName(),1400,700);
////
//////	    if( name == "ch1_Name0" ) { name =  "EBEB_HighR9_8TeV"; }
//////	    if( name == "ch1_Name1" ) { name =  "EBEB_NotHighR9_8TeV"; }
//////	    if( name == "ch1_Name2" ) { name =  "NotEBEB_HighR9_8TeV"; }
//////	    if( name == "ch1_Name3" ) { name =  "NotEBEB_NotHighR9_8TeV"; }
//////	    if( name == "ch2_ch1_EBEB" ) { name  = "EBEB_13TeV_38T"; }
//////	    if( name == "ch2_ch1_EBEE" ) { name  = "EBEE_13TeV_38T"; }
//////	    if( name == "ch2_ch2_EBEB0T" ) { name  = "EBEB_13TeV_0T"; }
//////	    if( name == "ch2_ch2_EBEE0T" ) { name  = "EBEE_13TeV_0T"; }
////
//////	    TCanvas * canvi = new TCanvas("canvas","canvas",600,600);
////	    
//////	    canvi->SetLogy();
////	    /// canvi->SetLogx();
////	    
////	    // framei->GetYaxis()->SetRangeUser(1e-5,700);
////	    // framei->GetYaxis()->SetRangeUser(1e-1,10);
////	    framei->GetXaxis()->SetMoreLogLabels();
////	    
////	    framei->Draw();
////	    
////	    canvi->SaveAs(Form("asimov_postfit_test_plot_new__%s.png", canvi->GetName()));
////	    canvi->SaveAs(Form("asimov_postfit_test_plot_new__%s.root", canvi->GetName()));
////	    /// canvi->SaveAs(Form("template_%s.png", canvi->GetName()));
////	}
}

	    
