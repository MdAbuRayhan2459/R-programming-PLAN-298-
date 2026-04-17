# it 1st class on R 
# class was taken by Ankhi mam

#Date:7 Jan,2026


ID<-c(1,2,3,4,5,6)
ID
class(ID)
length(ID)
Name<-c("Rayhan","Roni","Raja","Nafi",'Lipi',"Rima")
Name
Gen<-c("M","M","M","M","F","F")
Gen
db1<-data.frame(ID,Name,Gen)
db1
View(db1)
str(db1)
dim(db1)
head(db1,4)
tail(db1,4)
install.packages("writexl")

library(writexl)
write_xlsx(db1,"database1.xlsx")

# to save data frame as excel file
setwd("C:/Users/ASUS/OneDrive - BUET/Desktop/R")
getwd()



library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)

install.packages("dplyr")
library(dplyr)
class

pd<-Pedestrian
View(pd)
pd$Gender
class(pd$Gender)

#to convert data type
pd$Gender<-as.factor(pd$Gender)
class(pd$Gender)

pd$Gen<-as.factor(pd$Gender)

View(pd)
class(pd$Gen)
