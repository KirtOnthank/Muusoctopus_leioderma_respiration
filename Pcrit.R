


muus.pc=read.pyro("tbocto 1000 pcrit tank 1 and 2 day 7 8-19-21.txt")

plot(muus.pc$O21,type="l",ylim=c(0,280))
points(muus.pc$O22,col="red",type="l")

##to trim to usable data
muus.pc=muus.pc[50:1380,]

muus.resp=resp.closed(muus.pc,volume=.5,weight=36.3,smooth=20)

muus.nls=nls(resp~Bm*(1-exp(-(po2/(0.59*Pc))^2)),data=muus.resp,start=list(Bm=1.5,Pc=10))
coef(muus.nls)[2]


bins=round(muus.resp$po2)

plot(aggregate(muus.resp$resp~bins,FUN="mean"))

steps=seq(from=1,to=14,by=0.1)
lines(steps,predict(muus.nls,newdata = data.frame(po2=steps)),col="red")

abline(v=coef(muus.nls)[2],col="blue")

