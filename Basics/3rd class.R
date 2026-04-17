#---Data Analysis-----
var1<-1:20
var2<-c(1:5,27:29,NA,6:14,NA,NA)
var3<-c("F","M","F","M","M","F","M","M","F","M","M","F","M","F","M","M","F","M","M","F")
var4<-c("X", "X", "Y", "Y", "X", "X", "Y", "Y",
        "X", "X","X", "X", "Y", "Y", "X", "X", "Y",
        "Y", "X", "X")
data1<-data.frame(var1,var2,var3,var4)
data1

View(data1)

mean(data1$var1)
mean(data1$var2,na.rm=TRUE)
summary(data1) # it shows min median ,quartile,max

#to see the total lavel of any categorical data
# class(var3)
# var3<-factor(var3)
# levels(var3)


# fivenum() ফাংশন ডেটার পাঁচটি গুরুত্বপূর্ণ মান বের করে:
# 1. Minimum (সবচেয়ে ছোট মান)
# 2. First Quartile (Q1 / Lower hinge)
# 3. Median (মাঝের মান)
# 4. Third Quartile (Q3 / Upper hinge)
# 5. Maximum (সবচেয়ে বড় মান)
#
# এটি মূলত Tukey-এর five-number summary দেয় এবং boxplot তৈরিতে ব্যবহৃত হয়।


fivenum(data1$var1)

install.packages("Hmisc")
library(Hmisc)
describe(data1)

install.packages("psych")
library("psych")
describe(data1)
describe.by(data1,group=data1$var3)


install.packages("pastecs")
library("pastecs")
stat.desc(data1)
install.packages("summarytools")
library("summarytools")
freq(data1$var4)

#to make table so that we can see the % of any variable
tab1<-table(data1$var3,data1$var4)
tab1

prop.table(tab1,1) # row wise percentage

prop.table(tab1,2) #column wise percantage
prop.table(tab1) # percentage of total



# to save as a csv file 
library(readr)
write.csv(data1,"3rd_lecture.csv")


# to save as a excel file

library(writexl)
# to save any specific path use setwd() 
# otherwise it will save automatically in your R code file
setwd("C:/Users/ASUS/OneDrive - BUET/Desktop") 

write_xlsx(data1,"3rd lecture data frame.xlsx")

