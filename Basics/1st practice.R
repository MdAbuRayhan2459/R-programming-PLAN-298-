travel_database <-data.frame()
travel_database <- edit(travel_database)
travel_database
edit(travel_database)
travel_database
fix(travel_database)
travel_database

View(travel_database)
DF_Matrix <−as.matrix(travel_database)
View(Df_Matrix)
install.packages("readr")
library(readr)
write_csv(travel_database, "travel_database.csv")
getwd()
