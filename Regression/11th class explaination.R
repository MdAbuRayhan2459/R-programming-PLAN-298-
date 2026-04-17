y=m1x1+m2x2+m3x3....mnxn+c

#vif>5 hole onno ekta variable sate strong relation ase (multicollinearity)


library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)

library(dplyr)
D<-select(Pedestrian,-ID)
View(D)

model1<-lm(Speed~.,data = D)
summary(model1)
install.packages("DAAG")
library(DAAG)
vif(model1)  #VIF মাপে — একটা variable কি অন্য variables এর সাথে বেশি correlated?
#এই সমস্যাকে বলে Multicollinearity — যখন দুটো variable প্রায় একই জিনিস measure করে, তখন regression confused হয়ে যায়।
#সম্ভবত Width আর Intersection একসাথে highly correlated — কারণ প্রতিটা intersection এর নিজস্ব width আছে। একটা থাকলে অন্যটা predict করা যায়।
#মূল কথা: Multicollinearity থাকলে coefficient এর value বিশ্বাসযোগ্য না — তাই model এ রাখার আগে এটা fix করা জরুরি।

#VIF দেখে সিদ্ধান্তের Rule
#VIF Valueমানেকরণীয়1 - 5✅ ভালো, কোনো সমস্যা নেইরাখো 5 - 10⚠️ সতর্কতা, moderate সমস্যাবিবেচনা করো10 এর বেশি❌ মারাত্মক Multicollinearityবাদ দাও বা fix করো



library(car)
vif(model1)
#GVIF Output ব্যাখ্যা

# আগেরটার সাথে পার্থক্য কী?
#   আগে তুমি VIF দেখেছিলে — সেটা প্রতিটা dummy variable আলাদা আলাদা করে দেখাচ্ছিল।
# এখন GVIF দেখাচ্ছে — এটা পুরো categorical variable কে একসাথে দেখাচ্ছে।
# 
# যেমন Age এর ৩টা dummy (Young, Old, Middle Aged) আলাদা না দেখিয়ে Age হিসেবে একটাই value দিচ্ছে।
# 

# GVIF^(1/2Df)✅ এটাই আসল comparison value — সব variable কে সমান scale এ আনে


# GVIF^(1/2Df) দিয়ে সিদ্ধান্ত
# 
# Rule: এই value এর square করো → সেটাই VIF এর সমতুল্য অথবা সরাসরি: > √10 = 3.16 হলে সমস্যা
# গুরুত্বপূর্ণ পর্যবেক্ষণ
# Yield এর ব্যাপারে — আগে আলাদা dummy দেখলে GVIF বড় ছিল, কিন্তু এখন পুরো Yield variable হিসেবে দেখলে মাত্র 1.43 — কোনো সমস্যা নেই! এটাই GVIF ব্যবহারের সুবিধা।
# 
# সিদ্ধান্ত — কী করবে?
#   🚨 Width বাদ দাও অথবা Intersection বাদ দাও
# ⚠️ Gap একটু দেখো (7.65) — রাখা যাবে, তবে সতর্ক থাকো
# ✅ বাকি সব variables ঠিক আছে
# 
# মূল কথা: GVIF categorical variables এর জন্য VIF এর চেয়ে বেশি সঠিক। তোমার model এ শুধু Width একটাই আসল সমস্যা। 🎯
# library(rms) ignore this one 
# vif(model1) 

install.packages("performance")
library(performance)
check_model(model1)
install.packages("see")
library(see)
check_model(model1)
check_model(model1)

dev.off()
plot(1:10)

check_model(model1)

packageVersion("performance")
packageVersion("see")
class(model1)
p <- check_model(model1)
print(p)

model2<-lm(Speed~Width+Gender+Age+Pattern+Group+Waiting+Traversing+V_speed+Gap+Flow+Yield+Mobile_Usage,data = Pedestrian)
summary(model2)

check_model(model2)


dev.off()

model3<-lm(Speed~Width+Gender+Age+Pattern+Group+Waiting+Traversing+V_speed+Gap+Flow+Mobile_Usage,data = Pedestrian)
summary(model3)
png("model3", width = 1200, height = 1000)
check_model(model3)
dev.off()
getwd()
p<-check_model(model3)
library(qqplotr)
plot(p)
print(p)
#Step1

mydata1<-Pedestrian[,c(3,8:13)]
library(GGally)
ggpairs(mydata1)# -V_speed,Gap
#step 2
Finaldata<-Pedestrian[,c(2:10,13:15)]
View(Finaldata)
model4<-lm(Speed~.,data = Finaldata)
summary(model4)
#step 3 multicollinearity

check_model(model4)
model2<-lm(Speed~Width+Gender+Age+Pattern+Group+Waiting+Traversing+Flow+Yield+Mobile_Usage,data = Finaldata)
summary(model2)
check_model(model2)

png("temp_test.png", width = 1200, height = 1000)
check_model(model2)
dev.off()
getwd()
#তারপর RStudio Restart R Session দাও (Ctrl+Shift+F10)।
library(performance)
library(see)
check_model(model2)
library(ggplot2)
library(ggplot2)

# PDF-তে save
pdf("model2_check_model.pdf", width = 10, height = 8)
check_model(model2)
dev.off()

# অথবা PNG-তে save
png("model2_check_model.png", width = 1200, height = 1000)
check_model(model2)
dev.off()


#check_model style diagnostic plots manual ggplot code বানাচ্ছি
library(ggplot2)
library(dplyr)

# residuals, fitted, leverage, cooks
res <- residuals(model2)
fitted <- fitted(model2)
std_res <- rstandard(model2)
cooks <- cooks.distance(model2)
lev <- hatvalues(model2)

# 1️⃣ Residuals vs Fitted
p1 <- ggplot(data.frame(fitted, res), aes(x = fitted, y = res)) +
  geom_point() +
  geom_smooth(se = FALSE, color = "red") +
  labs(title = "Residuals vs Fitted", x = "Fitted values", y = "Residuals") +
  theme_minimal()

# 2️⃣ Normal Q-Q plot
qq <- qqnorm(res, plot.it = FALSE)
qq_df <- data.frame(theoretical = qq$x, sample = qq$y)
p2 <- ggplot(qq_df, aes(x = theoretical, y = sample)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(title = "Normal Q-Q Plot", x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_minimal()

# 3️⃣ Scale-Location plot (sqrt of standardized residuals vs fitted)
p3 <- ggplot(data.frame(fitted, sqrt_std_res = sqrt(abs(std_res))), aes(x = fitted, y = sqrt_std_res)) +
  geom_point() +
  geom_smooth(se = FALSE, color = "red") +
  labs(title = "Scale-Location Plot", x = "Fitted values", y = "Sqrt(|Standardized residuals|)") +
  theme_minimal()

# 4️⃣ Cook's Distance plot
p4 <- ggplot(data.frame(seq_along(cooks), cooks), aes(x = seq_along(cooks), y = cooks)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Cook's Distance", x = "Observation", y = "Cook's Distance") +
  theme_minimal()

# Show plots individually
p1
p2
p3
p4

# ✅ Optionally, save all plots to PDF
pdf("model2_diagnostics_manual.pdf", width = 10, height = 8)
print(p1)
print(p2)
print(p3)
print(p4)
dev.off()

getwd()
