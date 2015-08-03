### TAE W01 - Working with Data

sd(c(5,8,12))
which.min(c(4,1,6))
?sqrt




### VECTORS AND DATA FRAMES

# A VECTOR  is a series of numbers or characters stored as the same object.
c(2,3,5,8,13)
Country = c("Brazil","China","India","Switzerland","USA")
Country
LifeExpectancy = c(74,76,65,83,79)
LifeExpectancy
Country[1] # get the first element
LifeExpectancy[3] # get the third element

seq(0,100,2) # range + sequence interval

CountryData = data.frame(Country,LifeExpectancy)
CountryData
CountryData$Population = c(199000, 1390000, 1240000, 7997, 318000) # $ add variable
CountryData

Country = c("Australia","Greece")
LifeExpectancy = c(82, 81)
Population = c(23050,11125)
NewCountryData = data.frame(Country, LifeExpectancy, Population)
NewCountryData

AllCountryData= rbind(CountryData, NewCountryData)
AllCountryData

# rbind >> add new observations to a data frame
# data.frame >> combine two vectors into a data frame
# $ >> add a variable to your data frame




### LOADING DATA FILES

getwd()
WHO = read.csv("WHO.csv")
WHO
str(WHO)
summary(WHO)

# subset
WHO_Europe = subset(WHO, Region == "Europe")
WHO_Europe
str(WHO_Europe)

# crete csv file
write.csv(WHO_Europe, "WHO_Europe.csv")
ls()

# remove csv file
rm(WHO_Europe)
ls()




### DATA ANALYSIS - SUMMARY STATISTICS & SCATTERPLOTS

WHO$Under15
mean(WHO$Under15)
sd(WHO$Under15)
summary(WHO$Under15)
which.min(WHO$Under15)
WHO$Country[86]
which.max(WHO$Under15)
WHO$Country[124]

# Plot + Outliers
plot(WHO$GNI, WHO$FertilityRate)
Outliers = subset(WHO, GNI > 10000 & FertilityRate > 2.5)
nrow(Outliers)
Outliers[c("Country", "GNI", "FertilityRate")]

# What is the mean value of the "Over60" variable?
mean(WHO$Over60)

# Which country has the smallest percentage of the population over 60?
which.min(WHO$Over60)
WHO$Country[183]

# Which country has the largest literacy rate?
which.max(WHO$LiteracyRate)
WHO$Country[44]




### DATA ANALYSIS - PLOTS AND SUMMARY TABLES

# Hitrogram 
hist(WHO$CellularSubscribers)

# Box Plot (good to analyse the statistical range of variables)
boxplot(WHO$LifeExpectancy ~ WHO$Region)
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab="", ylab="Life Expectancy", main= "Life Expectancy of Countries by Regions")

# Table (obs in each cathegory)
table(WHO$Region)
tapply(WHO$Over60, WHO$Region, mean) # apply the third argument
tapply(WHO$LiteracyRate, WHO$Region, min)
tapply(WHO$LiteracyRate, WHO$Region, min, na.rm = TRUE) # remove the NA or missing values

# Which region has the lowest average child mortality rate across all countries in that region?
names(WHO)
tapply(WHO$ChildMortality, WHO$Region, mean, na.rm = TRUE)
