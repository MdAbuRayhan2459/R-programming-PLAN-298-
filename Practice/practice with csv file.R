library(readr)
salaries <- read_csv("D:/salaries.csv")
View(salaries)

describe(salaries)
library("psych")
describe(salaries)






 # to save description as a csv file or excel
desc_sala<-describe(salaries)
View(desc_sala)
desc_df<-as.data.frame(desc_sala)
setwd("C:/Users/ASUS/OneDrive - BUET/Desktop/R")
write.csv(desc_df,"description of salries.csv")








describe.by(salaries,group=salaries$salary_currency)

freq(salaries$salary_currency)

#to show all details descriptive statistics
stat.desc(salaries)


freq(salaries$job_title)

# class(salaries$company_size)
# company_size<- factor(company_size)
# levels(salaries$company_size)

# library(ggplot2)
# ggplot(salaries,aes(x=salary_in_usd)+geom_histogram(bins = 20,fill = "orange", color = "red"))
# 
# 
# library(ggplot2)
# 
# ggplot(salaries, aes(x = salary_in_usd)) +
#   geom_histogram(bins = 20, binwidth = 2, fill = "orange", color = "red")
# 
# class(salaries)
# 



