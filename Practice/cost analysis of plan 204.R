library(readxl)
cost_data <- read_excel("C:/Users/ASUS/OneDrive - BUET/Desktop/cost data.xlsx")
View(cost_data)
library(dplyr)
cost_data$cost_cat<-ifelse(cost_data$`Roof area for farming (sqft)`<1200,"Low",
                           ifelse(cost_data$`Roof area for farming (sqft)`<=2400,"Medium","High"))
View(cost_data)

db1<-filter(cost_data,cost_cat=="High")
View(db1)

library(plotly)
library(ggplot2)
plot1<-ggplot(db1,aes(y=`Installation Cost (BDT)`))+geom_boxplot()
plot1
plotly(plot1)


# for low category
db2<-filter(cost_data,cost_cat=="Low")
View(db2)

library(plotly)
library(ggplot2)
plot2<-ggplot(db2,aes(y=`Installation Cost (BDT)`))+geom_boxplot()
plot2
ggplotly(plot2)
db2<-mutate(db2,NewInsCost=ifelse(`Installation Cost (BDT)`>100000,100000,`Installation Cost (BDT)`))
View(db2)
plot2<-ggplot(db2,aes(y=NewInsCost))+geom_boxplot()
plot2
ggplotly(plot2)
summary(db2$NewInsCost)


#for medium cat
db3<-filter(cost_data,cost_cat=="Medium")
View(db3)


plot3<-ggplot(db3,aes(y=`Installation Cost (BDT)`))+geom_boxplot()
plot3
ggplotly(plot3)
db3<-mutate(db3,NewInsCost=ifelse(`Installation Cost (BDT)`>200000,200000,`Installation Cost (BDT)`))
View(db3)
plot3<-ggplot(db3,aes(y=NewInsCost))+geom_boxplot()
plot3
ggplotly(plot3)
summary(db3$NewInsCost)

#for high 
db4<-filter(cost_data,cost_cat=="High")
View(db4)


plot4<-ggplot(db4,aes(y=`Installation Cost (BDT)`))+geom_boxplot()
plot4
ggplotly(plot4)
db4<-mutate(db4,NewInsCost=ifelse(`Installation Cost (BDT)`>200000,200000,`Installation Cost (BDT)`))
View(db4)
plot4<-ggplot(db4,aes(y=NewInsCost))+geom_boxplot()
plot4
ggplotly(plot4)
summary(db4$NewInsCost)

