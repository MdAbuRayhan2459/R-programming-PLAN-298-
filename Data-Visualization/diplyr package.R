# ==============================
# Load package
# ==============================
library(dplyr)

# ==============================
# Sample dataset
# ==============================
data <- data.frame(
  id = 1:6,
  name = c("Rahim", "Karim", "Sadia", "Rafi", "Mitu", "Anika"),
  gender = c("M", "M", "F", "M", "F", "F"),
  age = c(22, 25, 21, 23, 24, 22),
  department = c("CSE", "EEE", "CSE", "URP", "EEE", "URP"),
  cgpa = c(3.6, 3.2, 3.9, 3.4, 3.7, 3.8)
)

View(data)
# ==============================
# select() - column select
# ==============================
select(data, name, cgpa)

# ==============================
# filter() - row filter
# ==============================
filter(data, cgpa > 3.5)

# ==============================
# arrange() - sorting
# ==============================
arrange(data, cgpa)
arrange(data, desc(cgpa))

# ==============================
# mutate() - new column
# ==============================
data2 <- mutate(data,
                status = ifelse(cgpa >= 3.5, "Good", "Average")
)
View(data2)
# ==============================
# rename() - rename column
# ==============================
rename(data2, GPA = cgpa)

# ==============================
# summarise() - summary
# ==============================
summarise(data,
          avg_cgpa = mean(cgpa),
          max_cgpa = max(cgpa),
          min_cgpa = min(cgpa)
)

# ==============================
# group_by() + summarise()
# ==============================
data %>%
  group_by(department) %>%
  summarise(
    avg_cgpa = mean(cgpa),
    total_student = n()
  )

# ==============================
# distinct() - unique value
# ==============================
distinct(data, department)

# ==============================
# count() - frequency
# ==============================
count(data, department)

# ==============================
# slice() - specific rows
# ==============================
slice(data, 1:3)

# ==============================
# slice_max() & slice_min()
# ==============================
slice_max(data, cgpa, n = 2)
slice_min(data, cgpa, n = 2)

# ==============================
# pull() - column as vector
# ==============================
pull(data, name)

# ==============================
# if_any()
#if_any() একাধিক কলামের মধ্যে যেকোনো একটিতে শর্ত পূরণ হলে সেই row নির্বাচন করে।
# ==============================
filter(data, if_any(c(age, cgpa), ~ . > 23))

# ==============================
# across()
# ==============================
summarise(data,
          across(c(age, cgpa), mean)
)

# ==============================
# Pipe (%>%) full example
#%>% pipe আগের function-এর output পরের function-এর input হিসেবে ব্যবহার করে।
#“এই data নাও → এটা filter করো → তারপর সাজাও → তারপর নতুন column দাও → শেষে দেখাও”
# ==============================
data %>%
  filter(gender == "F") %>%
  arrange(desc(cgpa)) %>%
  mutate(result = ifelse(cgpa >= 3.7, "Excellent", "Good")) %>%
  select(name, department, cgpa, result)
