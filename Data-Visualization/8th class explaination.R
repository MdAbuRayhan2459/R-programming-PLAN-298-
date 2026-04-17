library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)

#one variable Chi Square Godness of fit test
observedVar<- c(80, 62)
expectedVar<- c(0.65, 0.35)
result<- chisq.test(observedVar, p=expectedVar)
result
result$expected

#exercise of lec slide
unique(Pedestrian$Group)
library(summarytools)
freq(Pedestrian$Group)
o<-c(393,54,99)
ex<-c(.6,.1,.3)
res<- chisq.test(o, p=ex) #Ho=same hbe jeta expect korci
res
res$expected
393+54+99
546*.6
#it differs significantly

#Association test(Multiple categorical variable)
#Multiple categorical variable:--> Chi Square Test of Independence
table1<-table(Pedestrian$Intersection,Pedestrian$Pattern)
table1
r1<-chisq.test(table1)
r1 #H0: "[Variable 1] is not associated with [Variable 2]"
# P<0.05 so reject Ho and we can say that significantly(5%) has association of these two var
r1$expected
r1$residuals

#Association test
t2<-table(Pedestrian$Age,Pedestrian$Pattern)
t2
r2<-chisq.test(t2)  #80% cell e 5 er kom value thakle tokon incorrect dekai mane vul aste pare
r2$expected
#expected freq e 5 er kom value cole asce ektai so fisher text korte hbe ekon
f<-fisher.test(t2)
f

#Comparison test(Group Difference test)

#independent sample T test
#outlier thakte parbe na
#Sobar age oulier check kore seta treat kore then normality check korbo r jdi n>30 hoi taile na korleo hbe

library(dplyr)
mydb<-filter(Pedestrian,Pedestrian$Intersection=="Bangla Motor")
View(mydb)

library(ggplot2)
library(plotly)
r<-ggplot(mydb, aes(x=Gender, y=Speed, color=Gender))+ geom_boxplot()
ggplotly(r)

mydb<-mutate(mydb,SpNew=ifelse(Speed<0.64 & Gender=="Male",0.64,ifelse(Speed>1.88 & Gender=="Male",1.88,Speed)))

View(mydb)

r1<-ggplot(mydb, aes(x=Gender, y=SpNew, color=Gender))+ geom_boxplot() #to check outliear
ggplotly(r1)  #no outlier now

library(dplyr)
d_m<-filter(mydb,Gender=="Male") #normality check korar jonno filter kore nicci
View(d_m)
d_f<-filter(mydb,Gender=="Female")
View(d_f)


#Normality test

shapiro.test(d_m$SpNew) #P>0.05 means normally distributed
shapiro.test(d_f$SpNew)


#Levene's test for equality of variance
install.packages("car")
library(car)
l<-leveneTest(SpNew ~ Gender, data = mydb)
l

#p>0.05 so, Ho accepted so equal variance(homogenity of variance) so now we can do t test

result<-t.test(SpNew~Gender,data = mydb,var.equal=TRUE,alternative="two.sided")
result

result1<-t.test(SpNew~Gender,data = mydb,var.equal=TRUE,alternative="less")
result1

result1<-t.test(SpNew~Gender,data = mydb,var.equal=TRUE,alternative="greater")
result1

#jdi variance gulo same na tahole 

#Welch t-test
result3<-t.test(SpNew~Gender,data = mydb,var.equal=FALSE,alternative="two.sided")
result3


#wilcoxn rank test  (Non parametric test)
#if data is not normally distributed then Wilcoxn rank test
result4<-wilcox.test(Speed~Gender,data = Pedestrian,exact=FALSE,alternative="two.sided")

#result4<-wilcox.test(Var1 ~ Var2, data = mydata, exact = FALSE, alternative= "less")
result4

#Slide Exercise:• You take 14 pedestrian sample from Bangla Motor, Dhaka. Does the mean of pedestrian waiting time in 
#Bangla Motor differ between male and female?

samle_db<-mydb[sample(nrow(mydb),14),]
View(samle_db)
#here n<30 so wilcox test
res1<-wilcox.test(Waiting~Gender,data = samle_db,exact=FALSE,alternative="two.sided")
res1

#Slide Exercise
#• You take 142 pedestrian sample from Bangla Motor, Dhaka. Does the mean of pedestrian crossing speed 
#in Bangla Motor differ with crosswalk usage behavior? (check normality)
shapiro.test(mydb$Speed)
#p>0.05 so fail to reject H0. at 5% significance level the crossing speed is normally distributed
#n>30 and normallity so  t test korte hbe

#Levene's test for equality of variance
l<-leveneTest(Speed~Pattern,data = mydb)
l #p>0.05 null accepted so equal variances so independence sample t test

r2<- t.test(Speed~Pattern,data = mydb,var.equal=TRUE,alternative="two.sided")
r2

#p<0.05 so we reject Ho. at 5% significance level there is not enough evidence to conclude to say that the mean of group Running and group Walking is equal 


