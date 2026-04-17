house <- read.csv("https://raw.githubusercontent.com/amankharwal/Website-data/master/USA_Housing.csv")
head(house)
housing <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv")
head(housing)
View(housing)
life <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/LifeCycleSavings.csv")
head(life)
data(swiss)
head(swiss)
View(swiss)
data(mtcars)
head(mtcars)
View(mtcars)
mpg <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/ggplot2/mpg.csv")
head(mpg)
View(mpg)
housing <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv")
head(housing)
View(housing)

library(GGally)
ggpairs(housing,lower=list(continuous="smooth_lm"))
model_F<-lm(rm~., data=housing)
summary(model_F)
library(olsrr)
library(DAAG)
vif(model_F)
library(performance)
check_model(model_F)

md<-lm(rm~crim+zn+indus+chas+ nox+age +dis+rad+ ptratio+b+lstat+medv,data = housing )
summary(md)

vif(md)
library(performance)
check_model(md)
png("model2_check_md.png", width = 1200, height = 1000)
check_model(md)
dev.off()
getwd()

m<-ols_step_forward_p(md,penter=0.05,details=T)
m1<-lm(rm ~ medv + lstat + b + age + zn + indus + rad ,data = housing)
summary(m1)




all_md<-ols_step_all_possible(md)
all_md
all_md<-as.data.frame(all_md$result)
View(all_md)
plot(all_md)

png("model2_check_all_md.png", width = 1200, height = 1000)
plot(all_md)
dev.off()
getwd()


final_md<-lm(rm~zn+indus+age+rad+b+lstat+medv,data = housing)
summary(final_md)
library(performance)
check_model(final_md)
plot(final_md)
plot(final_md,4)

summary(final_md)
# সব assumptions একসাথে দেখো
par(mfrow = c(2, 2))
plot(final_md)
par(mfrow = c(1, 1))

png("model2.png", width = 1200, height = 1000)
check_model(md)
dev.off()
getwd()

library(car)
ncvTest(final_md)


#now transformation korte hbe 

# Log transformation
final_md_log <- lm(log(rm) ~ zn + indus + age + rad + b + lstat + medv, 
                   data = housing)

summary(final_md_log)
plot(final_md_log)

