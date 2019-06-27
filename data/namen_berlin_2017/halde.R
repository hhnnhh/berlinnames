#bp <- ggplot(names17, aes(x=vorname, y=anzahl)) +
#  geom_boxplot()
#bp


n17<-spread(names17, key = vorname, value = anzahl)
# Das könnte was sein
n17<- reshape(names17,
              idvar = "kiez",
              # unique identifier
              timevar = "vorname",
              # the column represent the timing of the observations
              v.names = c("anzahl","geschlecht","position"),
              # the columns represent the value of the observation (BP,HR)
              direction = "wide",
              sep = "_"
)
# YEP! Anzahl der Vornamen pro Kiez, ohne Position
nx<- reshape(names17,
             idvar = "vorname",
             # unique identifier
             timevar = "kiez",
             # the column represent the timing of the observations
             v.names = c("anzahl"),
             # the columns represent the value of the observation (BP,HR)
             direction = "wide",
             #sep = "_"
             drop=c("position","geschlecht"),
)
nx$position<-NULL
head(nx)

#library(dplyr)

# Liste_ohne_Kieze --------------------------------------------------------


#so bekommt man einzigartige Namen, aber ohne die Info, in welchem Kiez die sind
einzige<-aggregate(names17$anzahl, by=list(Vorname=names17$vorname), FUN=sum)
names(einzige)[names(einzige)=='x'] <- 'anzahl'
einzige<-filter(einzige,anzahl==1)
summary(einzige)

#-----------------------------
