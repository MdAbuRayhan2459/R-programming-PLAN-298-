library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)
hist(Pedestrian$Traversing)

install.packages("ggpubr")
library(ggpubr)
library(ggplot2)
ggdensity(Pedestrian$Traversing)
hist(Pedestrian$Waiting)
ggdensity(Pedestrian$Waiting)
ggqqplot(Pedestrian$Traversing)

library(nortest)
lillie.test(Pedestrian$Traversing)


#Statistical normal test
# H0= normal
#Ha= non normal sig= 0.05
shapiro.test(Pedestrian$Traversing)
install.packages("tseries")
library(tseries)
jarque.bera.test(Pedestrian$Traversing)




plot1<-ggplot(Pedestrian,aes(y=Speed))+geom_boxplot()


install.packages("plotly")
library(plotly)
ggplotly(plot1)

# outlier dlt kore dewa

D<-Pedestrian
D<-filter(D,Speed<=2.13)
View(D)
ggplot(D,aes(y=Speed))+geom_boxplot()


#outlier replace kora

D2<-Pedestrian
View(D2)
D2<-mutate(D2,SpeedNew=ifelse(Speed>2.13,2.13,Speed))
View(D2)
plot1<-ggplot(D2,aes(y=SpeedNew))+geom_boxplot()
plot1
ggplotly(plot1)



#one sample test 
unique(Pedestrian$Intersection)
D1<-filter(Pedestrian,Pedestrian$Intersection=="Bangla Motor")
View(D1)
shapiro.test(D1$Speed) #p-value = 0.05526 it means fail to reject null H0 mean data narmally distributed
ggplot(D1,aes(y=Speed))+geom_boxplot()

ggplotly(ggplot(D1,aes(y=Speed))+geom_boxplot())

D1<-mutate(D1,Speednew=ifelse(Speed>1.66,1.66,ifelse(Speed<0.79,0.79,Speed)))
View(D1)

ggplot(D1,aes(y=Speednew))+geom_boxplot() #no outlier now

shapiro.test(D1$Speednew) #p-value = 0.01969<0.05 means reject H0 means data is not normal
result<-t.test(D1$Speednew,mu=1.2,alternative = "two.sided")
result
mean(D1$Speednew)
res1<-t.test(D1$Speednew,mu=1.2,alternative = "less")
res1
# we fail to reject H0: mean=1.2
#there is not sufficient evidance to conclude that true mean is less than 1.2

#Exercise of slide 35
D3<-filter(Pedestrian,Pedestrian$Intersection=="Bangla Motor")
View(D3)
shapiro.test(D3$Waiting)
ggplot(D3,aes(y=Waiting))+geom_boxplot() #no outlier
r1<-t.test(D1$Waiting,mu=20,alternative = "less")
r1  #𝐻0:𝜇=20,Ha=𝜇<20
#p-value = 0.9405  
#→ খুব বড় মান, 0.05-এর অনেক উপরে। তাই null hypothesis reject করা যাবে না।
#Confidence interval = (-∞ , 30.94527)   যেহেতু তুমি one-sided test (alternative = "less") চালিয়েছো, তাই lower bound -∞ এসেছে। Upper bound দেখাচ্ছে 30.95।
#অর্থাৎ, তোমার data থেকে কোনো প্রমাণ পাওয়া যায় না যে mean waiting time 20-এর চেয়ে কম। বরং evidence দেখাচ্ছে ean 20-এর চেয়ে বেশি।



