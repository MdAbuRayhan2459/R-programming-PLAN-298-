library(readxl)
Pedestrian <- read_excel("C:/Users/GIS_01/Downloads/Pedestrian.xlsx")
View(Pedestrian)

m1<-lm(Speed~Width+Gender+Age+Pattern+Group+Waiting+Traversing+Flow+Yield+Mobile_Usage,data=Pedestrian)
m1
summary(m1)

#always adjusted R squared has to considered; tokoni change hoi jokon necessary kono variable add kori
#but jekono variable add korle adjusted R squared er value barbe na 
#Traversing (β = –0.0336, p < 2e–16)


#step 5
#Stepwise Regression========
install.packages("olsrr")
library(olsrr)
#Forward Regression: p-value

mFP<-ols_step_forward_p(m1,penter=0.05,details = T)
mFP

#Pr(>|t|) vale jar minimum seta add korbe one by one

#Step => 5  theke R value increase hosse so oi variable ta add kortece


#ekon ami p value deke deke add korar por stop korbo jekhane P>0.05 hoye jabe 
# so final model hisabe choose korbo Model     => Speed ~ Traversing + Pattern + Waiting + Width + Age ekhane R2  => 0.778 jeta highest Adj. R-Squared ; er por theke Adj. R-Squared 0.778 theke kom astece so onno var nibo na
# mul kota p value er upor decision nibo eto kicu deka lagbe na





mFP<-ols_step_forward_aic(m1,penter=0.05,details = T)
# Model    => Speed ~ Traversing + Pattern + Waiting + Width + Age + Gender  etai final model
#aic er value always kom howa better 
#aic er real kono meaning nai but jokon 2 tar modde compare korte use kora hoi


mFP<-ols_step_forward_adj_r2(m1,penter=0.05,details = T)

#Adj. R2 jotokhhon barbe tottokhn var add korte thakbo
#Model    => Speed ~ Traversing + Pattern + Waiting + Width + Age + Gender + Group  with highest Adj. R2  => 0.77584



#------Backward Regreesion: p_value-------
mBP<-ols_step_backward_p(m1,prem=0.05,details = T)
mBP<-ols_step_backward_aic(m1,details = T)


#Model    => Speed ~ Width + Gender + Age + Pattern + Waiting + Traversing 
# AIC      => -281.207 etai lowest AIC so ekhanei esei stop hobo and model select korbo


#Stepwise:Both: P-value

mFBP<- ols_step_both_p(m1,penter = 0.05,prem=0.05,details = T)
#final Model     => Speed ~ Traversing + Pattern + Waiting + Width + Age  ; R2 => 0.778 

mFBP<- ols_step_both_aic(m1,penter = 0.05,prem=0.05,details = T)


#---Enter Method-----
enterM<-ols_step_all_possible(m1)
enterM
df<-as.data.frame(enterM$result) #ekhan theke sort kore decision nibo: Max Adju R2 and min AIC
View(df)  #select 850 no observation ;Model-->Width Gender Age Pattern Group Waiting Traversing
plot(enterM)



#consider best subset models
bestM<-ols_step_best_subset(m1)
bestM
plot(bestM)


#Final model selected  (Enter method er Adju R theke chosse korci)
finalM<-lm(Speed~Width+Gender+ Age+ Pattern+ Group+ Waiting+ Traversing,data = Pedestrian)
summary(finalM)
#kon var niye kaj korbo seta select kora done
#Now assumptions check korbo eai model tar upor


#assumption 6 er jonno QQ plot diye normality check korbo 


plot(finalM) #Enter press enter in console 

#eta diye assumption 3 er collectively linear kina bujai . jdi red line ta 0 borabor thake taile collectively linear bujai
#jdi 0 er kasakasi diye linear vabe jai taile assumption ta fulfill kore 

#collectively linear na asle tokon jekono ekta independent variable er sate log/sqrt etc niye aste hbe
# then etar upor(new model) abr sob gulo assumption gulo check korte hbe trial and error kore kore colte thake untill collectively linear
#fanel kora gele homoscedasticity thakbe na
# eta fulfill korte na parle dependent variable e change niye aste hbe log/sqrt

library(car)
ncvTest(finalM)
#Ho=homoscedaticity ase 

#Assumption 5: Influential point; j strem value er jonno line change hoye jai take influential point
#Influential point thakle pblm 
#tokon influential point gulor observations gulo bad diye dibo

library(lmtest)
bptest(finalM)

plot(finalM,4)
plot(finalM,5)
#3 ta outlier paaici but influential na

# Durbin-Watson test for time series data analysis

library(performance)
check_model(finalM)



# practice 
model_C<-lm(Speed~., data=Pedestrian)
model_C
library(olsrr)
model_A<-ols_step_all_possible(model_C)
model_A
dataframe<-as.data.frame(model_A$result)
View(dataframe)
plot(model_A)
Finalmodel_VarSelected<-lm(Speed~Width+Age+Pattern+Group+Waiting+Yield, data=Pedestrian)
summary(Finalmodel_VarSelected)
library(performance)
check_model(Finalmodel_VarSelected)
png("Finalmodel_VarSelected.png",width = 1200,height=1600)
check_model(Finalmodel_VarSelected)
dev.off()
getwd()
setwd("C:/Users/ASUS/OneDrive - BUET/Desktop/R")
getwd()
Finalmodel_VarSelected<-lm(log(Speed)~Width+Age+Pattern+Group+Waiting+Yield,data=Pedestrian)
summary(Finalmodel_VarSelected)
ncvTest(Finalmodel_VarSelected)
bptest(Finalmodel_VarSelected)




model<-lm(log(Speed)~Pattern+Waiting+Flow+Gender+log(Traversing),data=Pedestrian)
summary(model)
library(performance)
png("Finalmodel_Var.png",width = 1200,height=1600)
check_model(model)
check_model(Finalmodel_VarSelected)
dev.off()
getwd()

pede<- Pedestrian[-c(123,345,645),]
View(pede) #influential point remove kore dice


