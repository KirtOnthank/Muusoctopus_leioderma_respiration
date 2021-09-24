install_github(KirtOnthank/OTools)
library(devtools)
library(remotes)
library(OTools)
library(seacarb)
spec=read.csv("Building SpH.csv")

specpH(salinity=spec$S,temp=spec$T,A434=spec$A434,A578=spec$A578,A730=spec$A730,
        B434=spec$B434,B578=spec$B578,B730=spec$B730)

pH=specpH(salinity=spec$S,temp=spec$T,A434=spec$A343,A578=spec$A578,A730=spec$A730,
          B434=spec$B343,B578=spec$B578,B730=spec$B730)


