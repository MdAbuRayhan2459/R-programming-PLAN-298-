finalM<-lm(Speed~Width+Gender+ Age+ Pattern+ Group+ Waiting+ Traversing,data = Pedestrian)
summary(finalM)
Finalmodel_VarSelected<-lm(Speed~Width+Age+Pattern+Group+Waiting+Yield, data=Pedestrian)
summary(Finalmodel_VarSelected)


Finalmodel_VarSelected<-lm(log(Speed)~Width+Age+Pattern+Group+Waiting+Yield, data=Pedestrian)
summary(Finalmodel_VarSelected)
# homoscasdiscity na manle depedent variable e change ante hbe



#n>20*nmber of indepdent variable hole linear rgression korte parbo










