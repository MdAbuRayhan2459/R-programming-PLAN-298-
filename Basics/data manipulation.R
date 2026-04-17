pd<-data.frame(Pedestrian)
View(pd)
library(dplyr)
pd1<-mutate(pd,new_gen=ifelse(Gender=="Male"|Gender=="Female","Human","Animal"))
pd1
View(pd1)
pd2<-mutate(pd1,cat_waiting=ifelse(Waiting<40,"Good",ifelse(Waiting>40&Waiting<80,"Moderate","Bad")))
View(pd2)

#Filter data
newpd<-select(pd,ID,Age,Pattern,Gender)
View(newpd)
newpd1<-filter(pd,Gender=="Male" & Age=="Young")
View(newpd1)
newpd2<-filter(newpd1,Pattern=="Walking"&(Waiting<30 | Waiting>80))
View(newpd2)
pd1$new_gen<-NULL
pd1<-pd1[-c(2, 4, 6), ]
pd1<-pd1[-c(10:12), ]
pd1<-pd1[-c(17),5]
# 3 নম্বর row, 5 নম্বর column এর value change করা
pd2[3,5]<-"young"
View(pd2)

