

#Position 1 - 

levels(names17$kiez)

firstname <- filter(names17, position == 1)
head(firstname)

t<-as.table(firstname$anzahl,firstname$kiez)
t
mosaicplot(t)
margin.table(t)
margin.table(t,2)
barplot(t)

p<-table((firstname$anzahl,firstname$kiez),FUN=mean)
p <-aggregate(firstname$anzahl, by=list(firstname$kiez), FUN=mean)
p

firstname$
n<-table(firstname$anzahl,firstname$vorname)
mosaicplot(n)
