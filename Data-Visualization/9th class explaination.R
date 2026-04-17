library(readxl)
Pedestrian <- read_excel("C:/Users/ASUS/Downloads/Pedestrian.xlsx")
View(Pedestrian)
#ANOVA Test
#must treat group wise outlier
library(ggplot2)
plot1<-ggplot(Pedestrian,aes(x=Age,y=Speed))+geom_boxplot()
plot1
library(plotly)
ggplotly(plot1)
#now replace outlier with upper and lower fence
#young er lower fence 0.45 & 
db<-mutate(Pedestrian,NewSpeed=ifelse(Speed<0.45 & Age=="Young",0.45,ifelse(Speed>2.11 & Age=="Young",2.11,Speed)))
View(db)
plot1<-ggplot(db,aes(x=Age,y=NewSpeed))+geom_boxplot()
plot1
ggplotly(plot1)
# evabe ek ek kore sob gulo grop er jonno treat kora jabe but time consuming so...
library(dplyr)

db <- Pedestrian %>%
  mutate(
    NewSpeed = case_when(
      # Young group
      Age == "Young" & Speed < 0.45 ~ 0.45,
      Age == "Young" & Speed > 2.11 ~ 2.11,
      
      # Middle group (তোমার fence value বসাও)
      Age == "Middle Aged" & Speed < 0.4 ~ 0.4,
      Age == "Middle Aged" & Speed > 2 ~ 2,
      
      # Old group (তোমার fence value বসাও)
      Age == "Old" & Speed > 1.63 ~ 1.63,
      
      TRUE ~ Speed   # বাকি সব original রাখো
    )
  )

View(db)
plot1<-ggplot(db,aes(x=Age,y=NewSpeed))+geom_boxplot()
plot1
ggplotly(plot1) # jehetu outlier nai so plotly diye dekar dekr nai

#must check group wise normality then Homogenity of variance test

shapiro.test(db$NewSpeed[db$Age == "Young"])

# Middle Aged
shapiro.test(db$NewSpeed[db$Age == "Middle Aged"])
# R এ officially n = 3 to 5000 পর্যন্ত allow করে, কিন্তু practically 2000 এর বেশি হলে Shapiro-Wilk reliable না।
### কোনটা বেছে নেবে?
```
# n < 50          → Shapiro-Wilk
# 50 < n < 2000   → Anderson-Darling
# n > 2000        → Lilliefors অথবা শুধু Q-Q Plot

# Old
shapiro.test(db$NewSpeed[db$Age == "Old"])


library(nortest)
ad.test(db$NewSpeed[db$Age == "Old"]) #Anderson-Darling Test
lillie.test(db$NewSpeed[db$Age == "Old"]) #Lilliefors Test

#Q-Q plot diye normality check
ggplot(db, aes(sample = NewSpeed)) +
  stat_qq(color = "steelblue", size = 2) +
  stat_qq_line(color = "red", linewidth = 1) +
  facet_wrap(~ Age) +
  labs(
    title = "Q-Q Plot — Group-wise Normality Check",
    x     = "Theoretical Quantiles",
    y     = "Sample Quantiles"
  ) +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))





#ekhon ekhane deka jasse group gula kono ektar data normally distributed na. যেকোনো একটা p < 0.05 Kruskal-Wallis Test করো

#r jdi Normality thake (all p vale>0.05) then next step levene test kora lagbe

#Levene Test
unique(Pedestrian$Age)
library(car)
l<-leveneTest(Speed~Age,data = Pedestrian) #age grp gulor modde speed er variance check kora holo
l
#variance same so One way ANOVA test kora lagbe

res<-aov(Speed~Age,data = Pedestrian)

res
summary(res) #p<0.05  means reject H0; so, kono ekta group er modde mean value differ kortece
#konta differ kortece seta ekon ber korte hbe
plot(res,2)   ##Test normality of residual by QQ plot (not possible for Welch ANOVA)


#post HOC test . deklm kno ek grp er differ kortece ekon konta differ kortece seta dekte eai test

TukeyHSD(res)
# nicher 2 ta significantly differ kortece cz P<0.05, reject H0 and accept alternative hypothesis
# H0= Differ kore na and Ha= Differ kortece eai 2 ta group



# homogenaty of variance na thakle tokon Wells anova test korbo
res1<-oneway.test(Speed~Age,data = Pedestrian)
res1
#p<0.05 null reject so accept Ha mean at least one grp significantly differ from others

#konta differ kortece seta ekon deka lagbe so...
#r Welch ANOVA test e konta differ kortece deka hoi Games Howell test diye

library(rstatix)

games_howell_test(Pedestrian,Speed~Age)  #post HOC test 
# last 2 ta significant


# jdi variable normally distributed na hoi tokon (Non_normally Distributed)

kruskal.test(Speed~Age,data = Pedestrian)

#Post HOC test (konta er jonno mean differ kortce or variance astece seta dekte eai test kora hoi)
# H0= mean differ kore na ,Ha= At least one grouper mean differ kore 
pairwise.wilcox.test(Pedestrian$Speed,Pedestrian$Age,p.adjust.method = "BH")




#--------Comparison Test: Group Difference-------
#-----Numeric vs Binary Categorical(Paired test korar jonno)-------

library(readxl)
Sales <- read_excel("C:/Users/ASUS/Downloads/Sales.xlsx")
View(Sales)

unique(Sales$Group)

st<-filter(Sales,Group=="Treatment")
View(st)

st<-mutate(st,diff=Sales_Before-Sales_After)
View(st)
library(ggplot2)
plot1<-ggplot(st, aes(y=diff))+geom_boxplot()+labs(y="differnce(before-after)") #outlier gulo treat korte hbe
plot1
library(plotly)
ggplotly(plot1)

st<-mutate(st,new_diff=ifelse(diff< -192.18,-192.18,ifelse(diff>-33.26,33.26,diff)))
View(st)

#shapiro test n<5000 hole korte parbo#shapiro test n<5000 hole korte parbo diff()
library(nortest)
lillie.test(st$diff) #normality check korar jonno let Normality pailam taile ekon Paired t test korte parbo r na hole Paired Wilcoxon test kora lagto

#Paired test korlam(Before After related problem)
t1<-t.test(st$Sales_Before,st$Sales_After,paired = TRUE,
           alternative = "two.sided")   #less alpabetically order nibe like F age so Female<Male eai take nibe


#তুমি comment-এ লিখেছ "less alphabetically order নিবে" — এটা আসলে character/factor variable-এর ক্ষেত্রে প্রযোজ্য।
t.test(score ~ gender, alternative = "less") # its not a paired test
# Female আগে (F < M alphabetically)
# তাই R করে: Female - Male
# "less" মানে Female < Male
# অর্থাৎ Female-এর score কম
#jdi Male>Female dekte cai taile "less" likbo 



#কিন্তু তোমার ক্ষেত্রে দুটো আলাদা column দিয়েছ, তাই:
t.test(st$Sales_Before, st$Sales_After, paired = TRUE)
# R করে: Before - After
# "B" আগে "A"-এর পরে alphabetically
# কিন্তু এখানে তুমি সরাসরি column দিয়েছ
# তাই order হলো: প্রথম argument - দ্বিতীয় argument
# = Before - After

### কোন situation-এ কী লিখবে?

# ধরো সবসময় R করছে: **প্রথম − দ্বিতীয়**
#   ```
# প্রশ্ন: After > Before কিনা দেখতে চাই
# → Before - After হবে negative
# → তাই alternative = "less" লিখব
# (প্রথমটা কম দ্বিতীয়টার চেয়ে)
# ```
# ```
# প্রশ্ন: Before > After কিনা দেখতে চাই
# → Before - After হবে positive
# → তাই alternative = "greater" লিখব
# (প্রথমটা বেশি দ্বিতীয়টার চেয়ে)
# ```
# ```

#Before 1st e ase  so Before comes first so "less" dile( Before- After ) korci so eta asce. after>before (-ve ) value -113.52 asce
#sales after e increase hoice eai jonno _ve asce 


t1

sc<-filter(Sales,Group=="Control")
View(sc)

sc<-mutate(sc,diff=Sales_Before-Sales_After)

t2<-t.test(sc$Sales_Before,sc$Sales_After,paired = TRUE,alternative = "two.sided")
t2
#sales after e increase hoice eai jonno -ve asce 

#jdi n<30 and normally distributed na thake tokon non parametric test

wilcox.test(st$Sales_Before,st$Sales_After,paired = T) #Ho= Rank gulo equal, Ha= rank gulo equal na

# diff বানাও (Before - After)
# ↓
# n >= 30?
#   ↙        ↘
# YES          NO
# ↓            ↓
# t-test     Normality check করো
            # (lillie.test বা shapiro.test)
            # ↙         ↘
            # Normal        Not Normal
            # ↓               ↓
            # t-test      Wilcoxon test ✓




# Step 1: diff বানাও
# ↓
# Step 2: Outlier check করো
# (boxplot বা গ্রাফ দিয়ে দেখো)
# ↓
# Step 3: Outlier treat করো (যদি থাকে)
# ↓
# Step 4: Normality check করো
# (lillie.test / shapiro.test)
# ↓
# Step 5: Normal না হলে → Wilcoxon
# Normal হলে → t-test
