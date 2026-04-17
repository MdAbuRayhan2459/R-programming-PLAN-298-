#-----Preparing a data base-----

#Sadia Mam; Date:13Jan,2026

ID<- c(1,2,3,4,5,6,7,8,9,10)
Gender<-c("Male","Female","Male","Male","Female","Male","Female","Male","Male","Female")
T_experience<-c(1,2,3,2,1,3,2,1,3,2)
# 1=Good,2=Moderate,3= Bad
Income<-c(3000,3002,4562,4656,3653,7676,3545,2333,4553,3444)
db1<-data.frame(ID,Gender,T_experience,Income)
View(db1)



#-----Recoding data-----


as.character(ID)
recode_gen<-factor(db1$Gender,levels = c("Male","Female"),labels = c("Man","Women"))
recode_t_ex<-factor(db1$T_experience,levels = c(1,2,3),labels = c("Good","Moderate","Bad"),ordered = T)
recode_t_ex
db2<-data.frame(ID,Gender,recode_gen,T_experience,recode_t_ex,Income)
View(db2)


#--- Recode Numeric data-----
library(dplyr)

recode_income<-mutate(db1,recode_income=ifelse(db1$Income<3000,"Low Income",ifelse(db1$Income>=3000 & db1$Income<5000,"Middle Income","High Income")))
recode_income

#------Transforming variable----

income25<- mutate(db1,new_income=db1$Income*1.5)
income25

#----Filtering------

#to select row or observations
newdb<- filter(db1,db1$Gender=="Male" & db1$Income<5000)
newdb


#to select columns or variables
newdb2<-select(db1,ID,Gender,Income)
newdb2

#---- Data base merge-----

mergedb<-merge(db1,db2,by="ID",all = TRUE)
mergedb



#-----Delete/discard-----

db1$Gender<-NULL
View(db1    )


db2$recode_gen<-NULL
View(db2)

attach(db1)


ndb1<-db1[-c(2,4,6),]
View(ndb1)


