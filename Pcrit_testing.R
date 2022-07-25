library(respirometry)
library(OTools)
#library(dplyr)

muus.pc=read.pyro("Tbocto 1000 pcrti tank 1 and 2 8-11-21.txt")

plot(O21~times,data=muus.pc,type="l",ylim=c(0,280))
points(muus.pc$O22,col="red",type="l")

##to trim to usable data
muus.pc=muus.pc[50:nrow(muus.pc),]
muus.pc2=muus.pc

O21.lo=loess(O21~times,data=muus.pc,span=0.1)
O22.lo=loess(O22~times,data=muus.pc,span=0.1)
O21.smooth=predict(O21.lo, data.frame(times = muus.pc$times))
O22.smooth=predict(O22.lo, data.frame(times = muus.pc$times))
plot(O21~times,data=muus.pc,type="l",ylim=c(0,280))
points(muus.pc$times,O21.smooth,col="red",type="l")
plot(O22~times,data=muus.pc,type="l",ylim=c(0,280))
points(muus.pc$times,O22.smooth,col="red",type="l")

muus.pc$O21=O21.smooth
muus.pc$O22=O22.smooth
##Prep for Birks method, takes out all the NA's in the data, complete cases looks for 
##lines with an NA in and return False, any line that has data in the row returns true
##will only give lines that have data in levery line. 
muus.resp=resp.closed(muus.pc,volume=10.2,weight=791,smooth=1,channel = 1)
muus.resp=muus.resp[complete.cases(muus.resp),]
muus.resp2=resp.closed(muus.pc2,volume=10.2,weight=791,smooth=50,channel = 1)
muus.resp2=muus.resp2[complete.cases(muus.resp2),]

##Kirts pcrit method uses Weible method
##muus.nls=nls(resp~Bm*(1-exp(-(po2/(0.59*Pc))^2)),data=muus.resp,start=list(Bm=1.5,Pc=10))    
##coef(muus.nls)[2]

## birks pcrit method
plot_pcrit(muus.resp$po2,muus.resp$resp)
plot_pcrit(muus.resp2$po2,muus.resp2$resp)

muus.resp=resp.closed(muus.pc,volume=10.2,weight=791,smooth=1,channel = 1)
muus.resp=muus.resp[complete.cases(muus.resp),]
muus.resp$po2bins=round(muus.resp$po2,2)
binned=aggregate(resp~po2bins,data=muus.resp,FUN="mean")
plot(resp~po2,data=muus.resp)
plot(resp~po2bins,data=binned)
plot_pcrit(binned$po2bins,avg_top_n = 3,binned$resp,xlim=c(0,17),ylim=c(0,1))

resp.lo=loess(resp~po2,data=muus.resp,span=0.05,se.)
steps=seq(from=0,to=17,length.out=1000)
#plot(resp~po2,data=muus.resp,ylim=c(0,1))
#lines(steps,predict(resp.lo, data.frame(po2 = steps)),col="red")

plot_pcrit(steps,avg_top_n = 3,predict(resp.lo, data.frame(po2 = steps)),MR=0.6)


hist(muus.resp$resp)
abline(v=quantile(muus.resp$resp,c(.025,.975)),col="red")
median(muus.resp$resp)+3*mad(muus.resp$resp,constant=1)
bins=round(muus.resp$po2)

plot(aggregate(muus.resp$resp~bins,FUN="mean"))

steps=seq(from=1,to=14,by=0.1)
lines(steps,predict(muus.nls,newdata = data.frame(po2=steps)),col="red")

abline(v=coef(muus.nls)[2],col="blue")

