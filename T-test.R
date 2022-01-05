install.packages("ggplot2") ##Packages you'll need if you don't already have for T-test and box plot
install.packages("pastecs")

library

Crab.rmr<-read.csv("Crab Master Data Sheet - RMR (1).csv", header = TRUE)

attach(Crab.rmr) ##The database is attached to the R search path. 
                 ##This means that the database is searched by R when 
                 ##evaluating a variable, so objects in the database 
                 ##can be accessed by simply giving their names.

names(Crab.rmr) ## gives the names of all columns in your data set

sapply(Crab.rmr, class) ##lets you see the class of your data

class(Pco2.treatment) ## lets you see the "class" of each column, i.e. number, interger, factor etc,...

class(RMR)

Crab.rmr$Pco2.treatment = as.factor(Crab.rmr$Pco2.treatment)## how I changed the class Pco2.treatment from 
                                                            ##interger to factor

##make box plot
boxplot(RMR ~ Pco2.treatment)

## two-sided test
## assume none-equal varienaces

t.test(RMR~Pco2.treatment, mu=0, alt="two.sided", conf=0.95, var.eq=F, paired=F)
