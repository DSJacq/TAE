### TAE W01 - UNDERSTANDING FOOD

### THE IMPORTANCE OF FOOD AND NUTRITION




### WORKING WITH DATA IN R

getwd()
usda = read.csv("USDA.csv")
usda
str(usda)
summary(usda)




### DATA ANALYSIS

usda$Sodium
which.max(usda$Sodium)
names(usda)
usda$Description[265]

HighSodium = subset(usda, Sodium > 10000)
nrow(HighSodium) # 10,000 mlg
HighSodium$Description

match("CAVIAR", usda$Description)
usda$Sodium[4154]
usda$Sodium[match("CAVIAR", usda$Description)]

summary(usda$Sodium)
sd(usda$Sodium) # NA not available enters
sd(usda$Sodium, na.rm = TRUE)




### CREATING PLOTS IN R

# Plot
plot(usda$Protein, usda$TotalFat)
plot(usda$Protein, usda$TotalFat, xlab = "Protein", ylab = "Fat", main = "Protein vs Fat", col = "red")

# Histogram
hist(usda$VitaminC, xlab = "Vitamin C (mg)", main = "Histogram of Vitamin C Levels")
# labels + title
hist(usda$VitaminC, xlab = "Vitamin C (mg)", main = "Histogram of Vitamin C Levels", xlim = c(0,100) )
# xlim + breaks
hist(usda$VitaminC, xlab = "Vitamin C (mg)", main = "Histogram of Vitamin C Levels", xlim = c(0,100), breaks = 100)

# Box Plot
boxplot(usda$Sugar, main = "Boxplot of Sugar Levels", ylab = "Sugar (g)")




### ADDING VARIABLES

usda$Sodium[1] > mean(usda$Sodium, na.rm = TRUE)
usda$Sodium[50] > mean(usda$Sodium, na.rm = TRUE)
HighSodium = usda$Sodium > mean(usda$Sodium, na.rm = TRUE)
HighSodium # logical data (true/false)

# change the data to numeric (1/0)
HighSodium = as.numeric(usda$Sodium > mean(usda$Sodium, na.rm = TRUE))
HighSodium
str(HighSodium)

# add vector to data frame
usda$HighSodium = as.numeric(usda$Sodium > mean(usda$Sodium, na.rm = TRUE))
str(usda)
usda$HighProtein = as.numeric(usda$Protein > mean(usda$Protein, na.rm = TRUE))
usda$HighFat = as.numeric(usda$TotalFat > mean(usda$TotalFat, na.rm = TRUE))
usda$HighCarbs = as.numeric(usda$Carbohydrate > mean(usda$Carbohydrate, na.rm = TRUE))
str(usda)




### SUMMARY TABLES

table(usda$HighSodium)
# 4884 lower sodium than average ! 2090 higher sodium than average
table(usda$HighSodium, usda$HighFat)
tapply(usda$Iron, usda$HighProtein, mean, na.rm = TRUE)
tapply(usda$VitaminC, usda$HighCarbs, max, na.rm = TRUE)
tapply(usda$VitaminC, usda$HighCarbs, summary, na.rm = TRUE)
