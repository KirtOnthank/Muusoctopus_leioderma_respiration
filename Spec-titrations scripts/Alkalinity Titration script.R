library(seacarb)
alk=read.csv("Building AK.csv")

at(S=alk$S[1],T=alk$T,C=alk$C[1],pHTris=alk$pHTris[1],ETris=alk$ETris[1],
             weight=alk$weight[1],E=alk$E,volume=alk$Volume)[1]

titration=at(S=alk$S[1],T=alk$T,C=alk$C[1],pHTris=alk$pHTris[1],ETris=alk$ETris[1],
   weight=alk$weight[1],E=alk$E,volume=alk$Volume)[1]

