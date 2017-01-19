MASSES="124.5
124.6
124.7
124.8
124.9
125.0
125.1
125.2
125.3
125.4
125.5
125.6
125.7
125.8
125.9
126.0
126.1
126.2
126.3
126.4
126.5
126.6
126.7
126.8
126.9
127.0
127.1
127.2
127.3
127.4
127.5"


#MASSES="125.8
#125.9
#126.0
#126.1
#126.2
#126.3
#126.4
#126.5
#126.6
#126.7
#126.8
#126.9
#127.0
#127.1
#127.2
#127.3
#127.4
#127.5"

OUTS=()

for MH in $MASSES:
do
MHcut=$(echo ${MH} | sed 's/\.0//g' | sed 's/://g' )
echo ${MHcut}
MH=$(echo ${MH} | sed 's/://g' )
./makeCombinePlots.py -f higgsCombineFiducialXsec_2016_ICEHP_2ndTopup_obs_mH${MH}_new.MultiDimFit.mH${MHcut}.root --probMeas  --xaxis 10.0,140.0 --xlab "#sigma_{fid} (fb)" --mu --muExpr "r*fxs_InsideAcceptance_13TeV*fbr_13TeV*0.59*1000" -t "12.9 fb^{-1} (13 TeV)" -o fidXsec_mHFloat_mh${MH}_obs_xsec_fromScript_BFexpval | tee scan.txt
OUT=$( cat scan.txt | grep "best fit" | cut -f2 -d":" | awk '{ printf "%f, %f, %f", $1,$2,$3}')
printf "\n"
echo "script output"
echo ${OUT}
echo ${OUT}
OUTS+=("${MH}: ${OUT}")
done


printf "%s\n" "${OUTS[@]}" > xsecVsMass.txt


for i in "${OUTS[@]}"
do
echo "$i"
done