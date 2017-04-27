#ifndef _DataSetFiller_h_
#define _DataSetFiller_h_

#include "RooDataSet.h"
#include "RooArgList.h"

#include "TTree.h"
#include "TNtuple.h"

class DataSetFiller 
{
public:
    DataSetFiller(const char * name, const char * title, const RooArgList & variables, const char *weightVarName=0, bool fillTree=false, bool isGrid=true);
    DataSetFiller(RooDataSet * dset);
    
    void fillFromTree(TTree * tree, const char * weightExpr=0, bool ignoreExpr=false );
    RooArgList & vars() { return vars_; };
    
    std::vector<RooDataSet * > get() { return datasets_; }
    TTree * getTree() { return tree_; }

    void setGrid(std::vector<std::string > obs, std::vector<std::vector<double > > boundaries);
    
    //    std::vector<std::string > datasetNames(std::vector<std::string > names, std::string var, std::vector<double > boundaries);
    std::vector<TString > datasetNames();

    int getDatasetIndex(std::vector<double > obsVals);

    static RooDataHist * throwAsimov( double nexp, RooAbsPdf *pdf, RooRealVar *x, RooDataHist *asimov=0);
    
    
private:
    bool isGrid_;
    std::string name_;
    std::string proc_;
    std::string cat_;
    std::string title_;
    std::string weightVarName_;
    RooArgList vars_;
    std::vector<std::string > obs_;
    std::vector<std::vector<double > > boundaries_;
    //    std::map<std::string, std::vector<double > > observables1_;
    //     std::map<std::string, std::vector<double > > observables2_;
    
    std::vector<RooDataSet * > datasets_;
    TNtuple * tree_;
    std::vector<float> treeBuf_;

};

#include <list>
typedef std::list<RooAbsData *> RooDataSetList;

#endif // _DataSetFiller_h_

// Local Variables:
// mode:c++
// indent-tabs-mode:nil
// tab-width:4
// c-basic-offset:4
// End:
// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4

