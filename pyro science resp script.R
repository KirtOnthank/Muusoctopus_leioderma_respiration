library(remotes)
install_github('KirtOnthank/OTools')

RMR=read.pyro("Rs21 tbcrab 1 and 2 7day 1800 rmr.txt")

plot(RMR$O23,type="l",ylim=c(150,280))
points(RMR$O24,col="red",type="l")

##to trim to usable data
RMR=RMR[100:nrow(RMR),]

RMR$O23=RMR$O21
RMR$O24=RMR$O22

RMR.resp=resp.pyro(RMR,flow1=.05095, flow2=.05095, weight1=21.6, weight2=21.6)

mean(RMR.resp$resp1)
