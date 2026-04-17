

# 1. Basic arithmetic and variables
a <- 10
b <- 3
sum_ab <- a + b
prod_ab <- a * b
quot_ab <- a / b
cat("sum:", sum_ab, "prod:", prod_ab, "quot:", round(quot_ab, 3), "\n")

# 2. Vectors and indexing
v <- c(2, 5, 7, 11, 13)
v[1]        # first element
v[2:4]      # slice
v[length(v)]# last element
seq(1, 10, by = 2)   # sequence
rep("A", 3)          # repeat

# Useful vector functions
sum(v); mean(v); median(v); sd(v); sort(v, decreasing = TRUE)

# Handling missing values
v2 <- c(1, NA, 3)
mean(v2)             # returns NA
mean(v2, na.rm = TRUE)  # ignore NA

# 3. Factors (categorical data)
grades <- factor(c("A", "B", "A", "C", "B"))
levels(grades)
table(grades)

# 4. Lists, matrices
my_list <- list(name = "Sam", age = 28, scores = v)
my_list$scores
mat <- matrix(1:9, nrow = 3)
mat
mat[2, 3]   # row 2, col 3

# 5. Data frames (tabular data)
df <- data.frame(
    id = 1:5,
    height = c(170, 165, 180, 175, 160),
    weight = c(65, 60, 80, 75, 55)
)
head(df)
summary(df)
df$bmi <- df$weight / (df$height/100)^2   # add a column
df[df$bmi > 24, ]                         # subset rows

# Use a built-in dataset
head(mtcars)
summary(mtcars)
aggregate(mpg ~ cyl, data = mtcars, FUN = mean)  # mean mpg by cylinder

# 6. Read and write CSV
tmp <- tempfile(fileext = ".csv")
write.csv(df, tmp, row.names = FALSE)
df2 <- read.csv(tmp)
unlink(tmp)  # clean up temp file

# 7. Functions
square <- function(x) {
    return(x * x)
}
square(4)
# Function with default
greet <- function(name = "friend") {
    paste("Hello,", name)
}
greet("Taylor"); greet()

# 8. Control flow
x <- 7
if (x %% 2 == 0) {
    msg <- "even"
} else {
    msg <- "odd"
}
msg

# Vectorized conditional
nums <- 1:10
ifelse(nums %% 2 == 0, "even", "odd")

# for loop
for (i in 1:5) {
    cat("i =", i, "\n")
}

# while loop
i <- 1
while (i <= 3) {
    cat("while i =", i, "\n")
    i <- i + 1
}

# 9. Apply family
m <- matrix(1:12, nrow = 3)
apply(m, 1, sum)   # row sums
l <- list(a = 1:3, b = 4:6)
lapply(l, mean)
sapply(l, mean)

# 10. Basic plotting (base graphics)
hist(mtcars$mpg, main = "Histogram of mpg", xlab = "mpg", col = "lightblue")
plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "MPG", main = "MPG vs Weight", pch = 19)
abline(lm(mpg ~ wt, data = mtcars), col = "red")

# Optional: ggplot2 (uncomment to use; will install if missing)
# if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
# library(ggplot2)
# ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
#   geom_point(size = 3) + geom_smooth(method = "lm", se = FALSE) +
#   labs(color = "Cylinders")

# 11. Helpful tips
# - Use ?function_name to view help, e.g. ?mean
# - Use str(object) to inspect structure, e.g. str(mtcars)
# - Save workspace with saveRDS(), load with readRDS()

# End of beginner script    
# Additional beginner-friendly examples and tips





# Reproducibility
set.seed(123)

# Simple data manipulation with base R (no extra packages required)
mtcars$model <- rownames(mtcars)           # keep model names as a column
mtcars$power_to_weight <- mtcars$hp / mtcars$wt

# Summaries by group (base R)
aggregate(mpg ~ cyl, data = mtcars, FUN = function(x) c(mean = mean(x), sd = sd(x)))

# Basic filtering and ordering (base R)
mtcars_subset <- mtcars[mtcars$mpg > 20, ]
mtcars_ordered <- mtcars[order(-mtcars$mpg), ]

# Handling missing values: remove rows with any NA
clean_mtcars <- mtcars[complete.cases(mtcars), ]

# Save and load a CSV (example)
write.csv(mtcars, "mtcars_export.csv", row.names = FALSE)
mtcars_loaded <- read.csv("mtcars_export.csv")

# Simple linear model and quick diagnostics
model <- lm(mpg ~ wt + cyl, data = mtcars)
print(summary(model))
# Basic diagnostic plots
old_par <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
plot(model)
par(old_par)

# Save and load R objects
saveRDS(model, file = "lm_mpg_model.rds")
model_copy <- readRDS("lm_mpg_model.rds")

# Optional: tidyverse (install if missing) - uncomment if you want to use it
# if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
# if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
# library(dplyr); library(ggplot2)
# mtcars %>% group_by(cyl) %>% summarise(mean_mpg = mean(mpg), n = n())
# p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) + geom_point() + geom_smooth(method = "lm")
# print(p)
# ggsave("mpg_vs_wt.png", plot = p, width = 6, height = 4)

# Quick interactive input example (useful in R console)
# name <- readline("Enter your name: ")
# cat("Hello,", name, "\n")

# Helpful small commands to explore objects
# str(mtcars); names(mtcars); head(mtcars); summary(mtcars)

# Short note on debugging: use traceback() after an error, or browser() inside a function to step through.