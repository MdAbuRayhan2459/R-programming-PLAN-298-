library(ggplot2)
install.packages("scales")
library(scales)

library(readxl)

Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)
ggplot(Pedestrian,aes(x=Speed,y=..count../sum(..count..)))+geom_histogram(color="red",fill="green",bins=5)+scale_y_continuous(labels = scales::percent)+geom_vline(aes(xintercept=mean(Speed),color="black",linetype = "dashed",size=0.5))


#----Karnel Density Plot----------
ggplot(Pedestrian,aes(x=Speed,y=..density..))+geom_histogram(color="yellow",fill="blue",bins = 5)+geom_density()


library(plyr)
v_mean<-ddply(Pedestrian,"Gender",summarise,grp.mean=mean(Speed))
v_mean

ggplot(Pedestrian,aes(x=Speed,fill = Gender))+geom_density()+geom_vline(data =v_mean,aes(xintercept =grp.mean,color=Gender))

#-----Sankey Diagram-----
install.packages("networkD3")
library(networkD3)
nodes<-data.frame(name=c("coal","Oil","gas","Electricity","industry","residential","commercial"))
links<-data.frame(source=c(0,1,2,3,3,3),target=c(3,3,3,4,5,6),value=c(50,30,10,80,20,20))

sankey<-sankeyNetwork(Links = links,Nodes = nodes,Source = "source",Target = "target",Value = "value",NodeID = "name",fontSize = 20)
sankey



