library(readxl)
Pedestrian <- read_excel("C:/Users/GIS_01/Downloads/Pedestrian.xlsx")
View(Pedestrian)

# Pearson Correlations (numeric vs. numeric + normally distributed)
# both var er outlier check korte hbe 
  
library(ggplot2)
ggplot(Pedestrian, aes(x=Speed,y=Traversing))+geom_point()+geom_smooth(method = lm) 

res <- cor.test(Pedestrian$Speed,Pedestrian$Traversing, method ="pearson") #method 3 type hote pare 
res         #-ve relationship 0.5<r it means strong relationship 


# assumtions (normally distributed na hole) non parametric test
#Spearman test / Kendall test

res1 <- cor.test(Pedestrian$Speed,Pedestrian$Traversing, method ="spearman")

res1
#Kendall test 
res1 <- cor.test(Pedestrian$Speed,Pedestrian$Traversing, method ="kendall")

res1

#interpretion same thakbe r er value er moto

#multiple var er modde correlation dekte cassi ekbare
data1<-Pedestrian[,c(3,8:13)]   #1st e row selection then column selection. #3, 8-13 no column select kora holo
View(data1)
res2<-cor(data1,use="everything",method = "pearson")
res2  #without p value output dibe but amdr to p value lagbe significance dekte

library(Hmisc)
#data set k  matrix e transfer kore nite hbe
mat1<-as.matrix(data1)
res3<-rcorr(mat1,type = "pearson")
res3

# ekon egulo visually dekao jai 

install.packages("corrplot")
library(corrplot)
r<-cor(mat1)
corrplot(r)

install.packages("GGally")
library(GGally)
ggpairs(Pedestrian)
ggpairs(Pedestrian[,8:13])

#output graph corr er upor * thakle  significance  bujai joto besi star toto besi significant
# it means p value is less than alpha value(significance level)

#now categorical var er modde relaion dekao
ggpairs(Pedestrian[,2:7])


#select sample from data set

sample_dataset<-Pedestrian[1:25,] #1st 25 row
sample_dataset

View(sample_dataset)

smpD<-Pedestrian[sample(nrow(Pedestrian),25),] #jekono 25 ta r sob gulo column
View(smpD)

smpD<-Pedestrian[sample(nrow(Pedestrian),25,replace = FALSE),] #replace fnctn jeno kno row repeat na kore
View(smpD)


# Lecture 3 Regression Analysis
# linear regression
# reference category te emon ekta cat newa ucit jeta nile data interpret kora easy hbe
res<-lm(Speed~Gender+Waiting+Age+Traversing,data = Pedestrian) #alphabatically jeta age asbe take reference hisabe dhorbe
res
summary(res)

#multiple R squared ki mean kore? independent variable  ta kotota ( 0.064) explain korte partece; Model কতটুকু variance explain করে

#model er modde jegulo significant variable segulo k impactful var bole

res2<-lm(Speed~.,data = Pedestrian) # speed bade baki sob gulo k independent var baniye model
summary(res2)

#m1<-lm(Speed~Intersection+Gender+Age+Width+Yield, data=Pedestrian)
m1<-lm(Speed~Intersection+Gender+Age+Width+Yield, data=Pedestrian)
summary(m1)
summary(m1)










































