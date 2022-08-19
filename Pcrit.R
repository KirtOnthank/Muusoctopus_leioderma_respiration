library(OTools)
library(respirometry)


muus.pc=read.pyro("Trueblood after session /tbocto 1000 pcrit tank 1 and 2 day 7 8-19-21.txt")

plot(muus.pc$O21,type="l",ylim=c(0,280))
points(muus.pc$O22,col="red",type="l")

##to trim to usable data
muus.pc=muus.pc[550:1800,]

muus.resp=resp.closed(muus.pc,volume=10.2,weight=791,smooth=5,channel = 1)

##Prep for Birks method, takes out all the NA's in the data, complete cases looks for 
##lines with an NA in and return False, any line that has data in the row returns true
##will only give lines that have data in levery line. 
muus.resp=muus.resp[complete.cases(muus.resp),]

##Kirts pcrit method uses Weible method
muus.nls=nls(resp~Bm*(1-exp(-(po2/(0.59*Pc))^2)),data=muus.resp,start=list(Bm=1.5,Pc=10))    
coef(muus.nls)[2]


##lookign at how noisy data is
plot(resp~po2,data=muus.resp)

plot_pcrit(muus.resp$po2,avg_top_n = 5,muus.resp$resp)

##bining data
muus.resp$po2bins=(round(muus.resp$po2,1))
binned=aggregate(resp~po2bins,data=muus.resp,FUN="mean")
plot_pcrit(binned$po2bins,avg_top_n = 3,binned$resp)
## birks pcrit method
calc_pcrit(binned$po2bins,avg_top_n = 3,binned$resp)

bins=round(muus.resp$po2)

plot(aggregate(muus.resp$resp~bins,FUN="mean"))

steps=seq(from=1,to=14,by=0.1)
lines(steps,predict(muus.nls,newdata = data.frame(po2=steps)),col="red")

abline(v=coef(muus.nls)[2],col="blue")

