#include "../interface/DataSetFiller_vec.h"
#include "RooRealVar.h"
#include "RooDataHist.h"
#include "RooAbsPdf.h"

#include "TTreeFormula.h"

#include <iostream>
#include <iomanip>
#include <sstream>
using namespace std;


RooDataHist* DataSetFiller::throwAsimov( double nexp, RooAbsPdf *pdf, RooRealVar *x, RooDataHist *asimov )
{
    RooArgSet mset( *x );
    if( asimov != 0 ) {
        asimov->reset();
    } else {
        asimov = new RooDataHist(Form("asimov_dataset_%s",pdf->GetName()),Form("asimov_dataset_%s",pdf->GetName()),mset);
    }
    pdf->fillDataHist( asimov, &mset, 1, false );

    for( int i = 0 ; i < asimov->numEntries() ; i++ ) {
        asimov->get( i ) ;

        // Expected data, multiply p.d.f by nEvents
        Double_t w = asimov->weight() * nexp;
        asimov->set( w, sqrt( w ) );
    }

    Double_t corr = nexp / asimov->sumEntries();
    for( int i = 0 ; i < asimov->numEntries() ; i++ ) {
        RooArgSet theSet = *( asimov->get( i ) );
        asimov->set( asimov->weight()*corr, sqrt( asimov->weight()*corr ) );
    }
    
    return asimov;
}

//DataSetFiller::DataSetFiller(const char * name, const char * title, const RooArgList & variables, const char *weightVarName, bool fillTree, bool isGrid) :
DataSetFiller::DataSetFiller(const char * proc, const char * cat, const RooArgList & variables, const char *weightVarName, bool fillTree, bool isGrid) :
    //    name_(Form("%s_%s", (proc,cat) ) ),
    //    title_(title),
    proc_(proc),
    cat_(cat),
    weightVarName_(weightVarName),
    vars_(variables),
    //    datasets_(new RooDataSet(name,title,RooArgSet(variables),weightVarName)),
    tree_(0),
    obs_(),
    boundaries_(),
    isGrid_(isGrid)
{
    name_ = Form("%s_", proc);
    name_ += cat;
    title_ = name_;
    datasets_ = {new RooDataSet(name_.c_str(),title_.c_str(),RooArgSet(variables),weightVarName)};
    if( fillTree ) {
        std::string vars;
        size_t nvar = vars_.getSize();
        for(size_t ivar=0; ivar<nvar; ++ivar) {
            RooRealVar &var = dynamic_cast<RooRealVar &>( vars_[ivar] );
            if( ! vars.empty() ) { vars += ":"; }
            vars += var.GetName();
        }
        tree_ = new TNtuple( ("tree_"+name_).c_str() , ("tree_"+name_).c_str() ,vars.c_str());
        // cout << vars << endl;
        treeBuf_.resize(nvar);
    }
}


DataSetFiller::DataSetFiller(RooDataSet * dset) :
    vars_(*(dset->get())),
    //    datasets_(dset),
    name_(dset->GetName()),
    tree_(0)
{
    datasets_ = {dset};    
}



std::vector<TString > DataSetFiller::datasetNames( ){
    std::string gen = obs_[0];
    //loop over gen boundaries
    std::vector<TString > newnames;
    for(int ib=0; ib < boundaries_[0].size()-1; ib++){
        std::stringstream procname_ss;
        procname_ss << proc_ << "_" << gen << "_"<< std::fixed << std::setprecision(1) << (boundaries_[0][ib]) << "_" << std::fixed<< std::setprecision(1) << (boundaries_[0][ib+1]) ;
        //        string procname =  proc_+"_"+gen+"_"+std::to_string(boundaries_[0][ib])+"_"+std::to_string(boundaries_[0][ib+1]) ;
        TString procname( procname_ss.str() );
        procname.ReplaceAll(".", "p");
        //        std::string procname =  procname_ss.str();
        if(obs_.size()>1 ){
            std::string reco = obs_[1];
            for(int jb=0; jb < boundaries_[1].size()-1; jb++){
                std::stringstream catname_ss;
                catname_ss  << reco << "_" << std::fixed << std::setprecision(1) << (boundaries_[1][jb]) << "_" << std::fixed << std::setprecision(1) << (boundaries_[1][jb+1]) << "_" << cat_ ;
                TString catname(catname_ss.str());
                catname.ReplaceAll(".", "p");
                //            std::string mystr = catname;
                //            string catname =  cat_+"_"+reco+"_"+std::to_string(boundaries_[1][jb])+"_"+std::to_string(boundaries_[1][jb+1]) ;
                newnames.push_back(procname+"_"+catname);
            }
        }
        else{
            newnames.push_back()
        }
    }

    return newnames;

}

//std::vector<std::string > DataSetFiller::datasetNames(std::vector<std::string > names, std::string var, std::vector<double > boundaries){
//    
//    std::vector<std::string > newnames;
//    for(int in=0; in < names.size(); in++){
//        std::string thisname = names[in];
//        for(int ib=0; ib < boundaries.size()-1; ib++){
//           
//            //            newnames.push_back(thisname+"_"+name_+std::to_string(boundaries[ib])+"to"+std::to_string(boundaries[ib+1]));
//            newnames.push_back(thisname+"_"+var+std::to_string(boundaries[ib])+"to"+std::to_string(boundaries[ib+1]));
//            
//        }
//    }
//    return newnames;
//
//}


void DataSetFiller::setGrid(std::vector<std::string > obs, std::vector<std::vector<double > > boundaries){
    if(!isGrid_){
        std::cout<<"Trying to specify grid vars and boundaries on this filler, but this object does not support it. Redeclare it with isGrid=1."<<std::endl;
        std::cout<<"Grid will NOT be applied"<<std::endl;
        return;
    }
    else{
        obs_ = obs;
        boundaries_ = boundaries;

        datasets_ =  std::vector<RooDataSet * >();
        std::vector<TString > dsNames;
        dsNames = datasetNames();
//        dsNames.push_back(name_);
//        int nobs = obs_.size();
//        while(nobs>0){
//            dsNames = datasetNames(dsNames, obs_[obs_.size() - nobs ].GetName(), boundaries_[boundaries_.size() - nobs ] ) ;
//            --nobs;
//        }
        

        for(auto dsname : dsNames){
            std::cout<<"pushing back this dataset "<<dsname<<std::endl;
            //            datasets_.push_back(new RooDataSet(dsname.Data(),title_.c_str(),RooArgSet(vars_),weightVarName_.c_str()));
            datasets_.push_back(new RooDataSet(dsname.Data(),dsname.Data(),RooArgSet(vars_),weightVarName_.c_str()));
        }
        return;
    }

}




//void DataSetFiller::fillFromTree(TTree * tree, const char * weightExpr, bool ignoreExpr, bool reduced)
void DataSetFiller::fillFromTree(TTree * tree, const char * weightExpr, bool ignoreExpr)
{

    
    size_t nvar = vars_.getSize();
    std::vector<TTreeFormula *> formulas(nvar);
    TTreeFormula * weight = (weightExpr != 0 ? new TTreeFormula("weight",weightExpr,tree) : 0);
    for(size_t ivar=0; ivar<nvar; ++ivar){
        RooRealVar &var = dynamic_cast<RooRealVar &>( vars_[ivar] );
        if( std::string(var.GetName()) == "weight" ) { 
            formulas[ivar] = weight;
        } else{
            formulas[ivar] = new TTreeFormula( var.GetName(), (ignoreExpr ? var.GetName() : var.GetTitle()), tree );
            //            std::cout<<"formula for "<<var.GetName()<<std::endl;
        }
    }

    std::vector<TTreeFormula *> formulas_obs(obs_.size());
    for(size_t iobs=0; iobs<obs_.size(); ++iobs){
        formulas_obs[iobs] = new TTreeFormula( obs_[iobs].c_str(), obs_[iobs].c_str(), tree );
        //        std::cout<<"formula for "<<obs_[iobs]<<std::endl;
    }
    
    

    for(int iev=0; iev<tree->GetEntries(); ++iev) {
        tree->GetEntry(iev);
        float wei = 1.;
        if( weight ) {
            wei = weight->EvalInstance();
        }
        if( wei == 0. ) { continue; }
        bool keep = true;
        for(size_t ivar=0; ivar<nvar; ++ivar){
            double val = formulas[ivar]->EvalInstance();
            RooRealVar & var = dynamic_cast<RooRealVar &>( vars_[ivar] );
            if( (var.hasMin() && val < var.getMin()) || (var.hasMax() && val > var.getMax()) ) { keep = false; break; }
            var.setVal( val  );
            if( tree_ ) { treeBuf_[ivar] = val; }
        }
        std::vector<double > obsVals;
        for(size_t iobs=0; iobs<obs_.size(); ++iobs){
            //            std::cout<<"evaluating formula for "<<obs_[iobs]<<std::endl;
            //            std::cout<<"val =  "<< formulas_obs[iobs]->EvalInstance()  <<std::endl;
            obsVals.push_back( formulas_obs[iobs]->EvalInstance() );
        }
        if( keep ) {
            if( tree_ ) { 
                tree_->Fill( &treeBuf_[0] );
            } else {
                //                std::cout<<"about to retrieve ds index for these obs values"<<std::endl;
                int ids = getDatasetIndex(obsVals);
                //                std::cout<<"the dataset index is "<<ids<<std::endl;
                datasets_[ids]->add( RooArgSet(vars_), wei );
            }
        }
    }
    
    for(size_t ivar=0; ivar<nvar; ++ivar){
        delete formulas[ivar];
    }
    //// if( weight ) { delete weight; }
}


int DataSetFiller::getDatasetIndex(std::vector<double > obsVals){
    std::vector<int > indexes;
    for(int io=0; io<obs_.size(); io++){
        //        std::cout<<"ds index search: obs index "<<io<<std::endl;
        indexes.push_back( ( std::lower_bound(boundaries_[io].begin(), boundaries_[io].end(), obsVals[io]) - boundaries_[io].begin() ) -1  );
        //        std::cout<<"index pushed for this obs is: "<<indexes[indexes.size()-1]<<std::endl;
    }
    int index = 0;
    //    std::cout<<"index calc: "<<index<<std::endl;
    for(int io=0; io<obs_.size(); io++){
        int isize = 1;
        //        std::cout<<"io "<<io<<std::endl;
        //        std::cout<<"index "<<index<<std::endl;
        for(int i=io+1; i<obs_.size(); i++){
            isize *= boundaries_[i].size() -1;
            //            std::cout<<"i "<<i<<std::endl;
            //            std::cout<<"isize "<<isize<<std::endl;
        }
        index += indexes[io]*isize;
        //        std::cout<<"index calc: "<<index<<std::endl;
    }
    return index;


}


// Local Variables:
// mode:c++
// indent-tabs-mode:nil
// tab-width:4
// c-basic-offset:4
// End:
// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4

