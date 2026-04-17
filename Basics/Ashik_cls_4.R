### graph

library("ggplot2")
x<-c(1,2,3,4)
y<-c(4,5,6,7)
category<-c("A","B","A","B")

data1<-data.frame(x,y,category)
data1

ggplot(data=data1,aes(x=x,y=y,colour = category))+geom_point(size=3)

# ggplot(data = data1,aes(x=x,y=y,colour = category)+geom_point(size=3))

# library(readxl)
# Pedestrian <- read_excel("C:/Users/GIS_10/Downloads/Pedestrian.xlsx")
View(Pedestrian)
Pedestrian
library("dplyr")
library("webr")

table<-table(Pedestrian$Intersection) ###table create 
table
mydata2<-data.frame(table)
mydata2

PieDonut(mydata2,aes(Var1,count=Freq),labelposition = 0,explode =c(2,4,6),showPieName = TRUE)
