#include "TMath.h"

float DeltaPhi(float phi1, float phi2){
  float phi12 = phi1 - phi2;
  if(phi12 >= TMath::Pi() ) phi12 -= (2*TMath::Pi());
  if(phi12 < -TMath::Pi() ) phi12 += (2*TMath::Pi());
  return phi12;

}
