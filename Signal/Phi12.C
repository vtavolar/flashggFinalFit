#include "TMath.h"

float Phi12(float x1, float y1, float x2, float y2 ){
  float phi12 =  (atan( (y1 + y2) / (x1 + x2) ) ) ;
  if ( (x1+x2 < 0)  ) phi12 += ( (y1 + y2) /abs( (y1 + y2) ) )*TMath::Pi();
			//  ( ( (x1 + x2) <0)*( (y1 + y2) /abs( (y1 + y2) ) )*TMath::Pi() + (TMath::atan( (y1 + y2) / (x1 + x2) ) ) )
  return phi12;
}
