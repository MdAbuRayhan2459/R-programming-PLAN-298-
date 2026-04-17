library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)
pd<-Pedestrian
library(dplyr)
pd$Gender
pd$Gen <- ifelse(pd$Gender == "Male", "M", "F")
pd$Gen
View(pd)
pd$Gender1 <- factor(pd$Gender,levels = c("Male","Female"),labels = c("Man","Women")) 
View(pd)
