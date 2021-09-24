library(remotes)
install_github('KirtOnthank/OTools')

muus=read.pyro("gr3 muus 1000 7-20-21.txt")
plot(muus$O21,type="l",ylim=c(150,280))
points(muus$O22,col="red",type="l")

##to trim to usable data
muus=muus[1000:nrow(muus),]

muus$O23=muus$O21
muus$O24=muus$O22

muus.resp=resp.pyro(muus,flow1=.0476, flow2=.0476, weight1=70, weight2=70)

mean(muus.resp$resp1)
