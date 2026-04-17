library(readxl)
plan_204_with_no_extra_sheet <- read_excel("C:/Users/ASUS/OneDrive - BUET/Desktop/plan 204 with no extra sheet.xlsx")
View(plan_204_with_no_extra_sheet)
library(ggplot2)
library(webr)
library(dplyr)

t1<-table(plan_204_with_no_extra_sheet$Gender,plan_204_with_no_extra_sheet$Occupation)
df2<-data.frame(t1)
df2
PieDonut(df2,aes(Var1,Var2,count=Freq),labelposition = 1,ratioByGroup = TRUE,showRatioPie = TRUE, donutLabelSize = 1.8,pieLabelSize = 3,  showRatioDonut = TRUE,title = "",r0 = 0.2)
View(df2)

t2<-table(plan_204_with_no_extra_sheet$`Educational Qualification`,plan_204_with_no_extra_sheet$Occupation)

df3<-data.frame(t2)
View(df3)
prop.table(t2,1)
prop.table(t2)

summary(plan_204_with_no_extra_sheet$`Duration of farming (years)`)
library(psych)
describe(plan_204_with_no_extra_sheet)

des<-describe(plan_204_with_no_extra_sheet)

des_df<-data.frame(des)
des_df
library(writexl)
write_xlsx(des_df, path = "descriptive_stats.xlsx")
write.csv(des_df, file = "describe_output.csv")

getwd()
describe(plan_204_with_no_extra_sheet$`Duration of farming (years)`)
describe(plan_204_with_no_extra_sheet$`Weekly hours spent on rooftop farming`)
describe(plan_204_with_no_extra_sheet$`Installation Cost (BDT)`)
fivenum(plan_204_with_no_extra_sheet$`Installation Cost (BDT)`)
