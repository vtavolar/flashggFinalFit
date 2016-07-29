#!/bin/bash
DIR=outdir_HggAnalysis_Moriond2016_example
#DIR=outdir_FiducialXsec_SignalModel_cutPhoID

echo " \documentclass[11pt]{article}" > all.tex
echo " \usepackage{graphicx}	    " >> all.tex
echo " \begin{document}		    " >> all.tex
echo " 				    " >> all.tex
echo " \title{}			    " >> all.tex
echo " \author{}		    " >> all.tex
echo " \date{}			    " >> all.tex
echo " \maketitle                   " >> all.tex

for file in `ls ./$DIR/fTestJobs/sub*.sh.log`; do
    echo $file
    grep TEX $file | awk '{ print substr($0,6) }' > $file.tex

    l=`wc -l $file.tex | awk '{ print $1 }'`
    # echo ${l}  " " $((l+1))
    head -n$((l-1)) $file.tex > $file.tex-1l
    tail -n$((l-1-9)) $file.tex-1l > $file.tex-core
    cat $file.tex-core >> all.tex
    echo " \newpage " >> all.tex 
    rm $file.tex-1l 
    rm $file.tex-core

done

echo " \end{document}		    " >> all.tex

pdflatex all.tex
mv all.pdf $DIR.pdf

rm all.tex
rm all.aux
rm all.log
rm sub*.log.pdf

