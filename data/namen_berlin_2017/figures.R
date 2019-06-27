
#https://www.r-graph-gallery.com/143-spider-chart-with-saveral-individuals/

library(ggplot2)
p <- ggplot(kreativ, aes(x=anzahl,y=name)) +
  count(aes(fill=name))
p

bp <- ggplot(kreativ, aes(x=anzahl,y=name)) +
  barplot()

coord_polar(theta = "anzahl", direction=1)
bp

zahl<-ggplot(data=kreativ, aes(x=name, y=anzahl)) +
  geom_bar(stat="identity")
zahl

zahl<-ggplot(data=berlin_spdf2, aes(x=name, y=anzahl)) +
  geom_bar(stat="identity")
zahl

hist(kreativ)
head(kreativ)

# spider plot

library(fmsb)

# Create data: note in High school for several students
#set.seed(99)
head(kreativ)
kkreativ<-kreativ[,c(2,1)] # reihenfolge der Kolumnen vertauscht
head(kkreativ)
rownames(kkreativ) <- c() # rownames weg
head(kkreativ)
library(reshape2)
kkkreativ<-t(kkreativ)

colnames(kkkreativ)<- kkreativ$name # die Zeilenbezeichnung wird in eigene VAriable umgewandelt
colnames(kkkreativ)
# make first row to rowname
head(kkkreativ)
clean<- kkkreativ[3:3,]

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
clean=rbind(rep(999,12) , rep(150,12) , clean)
kreativspider<-as.data.frame(kkkkreativ) # numerical array to data frame



rownames(clean)=paste("anzahl")
clean2<-as.numeric(row(clean))

is.numeric(clean$Pankow)
clean3<-matrix(as.numeric(unlist(clean)),nrow=nrow(clean)) 

SFIo <- as.matrix(apply(clean[,-1],2,as.numeric))
row.names(SFIo) <- clean[,1]
SFIo<-as.data.frame(SFIo)

#==================
# Plot 1: Default radar chart proposed by the library:
#kreativspider<-as.data.frame(kkkkreativ) # numerical array to data frame

radarchart(SFIo)


#==================
# Plot 2: Same plot with custom features
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
radarchart( SFIo  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=8 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(150,1000,200), cglwd=0.9,
            #custom labels
            vlcex=0.7 
)

legend(x=0.7, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)

colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
radarchart( SFIo  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(200,1000,200), cglwd=0.8,
            #custom labels
            vlcex=0.8 
)
legend(x=0.7, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)

