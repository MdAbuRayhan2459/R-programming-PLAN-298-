library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)
library(ggplot2)
library(webr)
library(dplyr)


#---Scatter plot----
tab1<- data.frame(Pedestrian$Waiting,Pedestrian$Traversing)
tab1
ggplot(tab1,aes(x=Pedestrian.Waiting,y=Pedestrian.Traversing))+geom_point(color="blue")+labs(title = "Waiting vs Traversing")+theme_classic()+theme(axis.text.x=element_text(face = "bold",angle =45,color="red",size=10,hjust = 1))


ggplot(Pedestrian,aes(x=Waiting,y=Traversing,color=Gender))+geom_point()+facet_wrap(~Gender)+geom_smooth(method = "loess")#facet_grid(Gender~Pattern) # to see diff category wise facet_

#scale_x_continuous(breaks = seq(1,10,1),limits = c(1,10))

#-----Line Plot------

library(readxl)
trenddata <- read_excel("C:/Users/ASUS/Downloads/trenddata.xlsx")
View(trenddata)

ggplot(trenddata,aes(x=Year,y=GDP))+geom_line(color="gray",linewidth = 2)+geom_point(color="blue")


#-----Pie chart-----
tab2<-table(Pedestrian$Intersection)
df23<-data.frame(tab2)
df23
PieDonut(df23,aes(Var1,count=Freq),labelposition=0,showPieName=T)


tab3<-table(Pedestrian$Gender,Pedestrian$Pattern)
df1<-data.frame(tab3)
df1
PieDonut(df1,aes(Var1,Var2,count=Freq),labelposition = 1,explode = c(1),ratioByGroup = T)


#----Bar chart-------
ggplot(df23,aes(x=Var1,y=Freq))+geom_bar(stat = "identity",color="green",fill="blue",width=0.7)+scale_y_continuous(breaks = seq(0,10,25),labels = scales::percent)


#-----Bar chart multiple variable------

df1

ggplot(df1,aes(x=Var1,y=Freq,fill=Var2))+geom_bar(stat = "identity",color="black",size=2,width=0.5,position = "dodge")


#----Tiles plot ------

tab3<-table(Pedestrian$Age,Pedestrian$Intersection)
df2<-data.frame(tab3)
df2
ggplot(df2,aes(x=Var1,y=Var2,fill = Freq))+geom_tile(color="black")+scale_fill_gradient2(low = "blue",high = "red",mid = "yellow")


library(ggplot2)

library(scales)

ggplot(Padestrian,aes(x=speed,y=count))+geom_histogram(color="red")






