### AN ANALYTICAL DETECTIVE



### LOADING DATA

mvt = read.csv("mvtWeek1.csv")
mvt
nrow(mvt)
str(mvt)
mvt$ID[which.max(mvt$ID)]
mvt$Beat[which.min(mvt$Beat)]
table(mvt$Arrest)
table(mvt$LocationDescription == "ALLEY")



### UNDERSTANDING DATES IN R

names(mvt)
mvt$Date[1]

# Convert the variable "Date" into a Date object in R
DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)
median(DateConvert)

# This creates two new variables in our data frame, Month and Weekday, and sets them equal to the month and weekday values 
# that we can extract from the Date object.
mvt$Month = months(DateConvert)
mvt$Weekday = weekdays(DateConvert)
mvt$Date = DateConvert
table(mvt$Month)
which.min(table(mvt$Month))
table(mvt$Weekday)
which.max(table(mvt$Weekday))
table(mvt$Arrest, mvt$Month)



### VISUALIZING CRIME TRENDS  

hist(mvt$Date, breaks=100)
boxplot(mvt$Date ~ mvt$Arrest, main = "Arrest by Date")
# Inter-Quartile Range (IQR) :  the difference between the first and third quartile values, or the height of the box
# Any point that is greater than the third quartile plus the IQR or less than the first quartile minus the IQR is considered an outlier
# For what proportion of motor vehicle thefts in 2001 was an arrest made?
sum(mvt$Year == 2001 & mvt$Arrest == "TRUE")/sum(mvt$Year == 2001)
# For what proportion of motor vehicle thefts in 2007 was an arrest made?
sum(mvt$Year == 2007 & mvt$Arrest == "TRUE")/sum(mvt$Year == 2007)
# For what proportion of motor vehicle thefts in 2012 was an arrest made?
sum(mvt$Year == 2012 & mvt$Arrest == "TRUE")/sum(mvt$Year == 2012)



### POPULAR LOCATIONS

sort(table(mvt$LocationDescription))

Top5 = subset(mvt, 
  LocationDescription=="STREET" | 
  LocationDescription=="PARKING LOT/GARAGE(NON.RESID.)" | 
  LocationDescription=="ALLEY" | 
  LocationDescription=="GAS STATION" | 
  LocationDescription=="DRIVEWAY - RESIDENTIAL")

Top5
nrow(Top5)
str(Top5)
# OR
TopLocations = c("STREET", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", "GAS STATION", "DRIVEWAY - RESIDENTIAL")
Top5 = subset(mvt, LocationDescription %in% TopLocations)
Top5

Top5$LocationDescription = factor(Top5$LocationDescription)
table(Top5$LocationDescription[Top5$Arrest])/table(Top5$LocationDescription)
# or
table(Top5$LocationDescription, Top5$Arrest)

table(Top5$Weekday[Top5$LocationDescription=="GAS STATION"])
# or
table(Top5$LocationDescription, Top5$Weekday)

table(Top5$Weekday[Top5$LocationDescription=="DRIVEWAY - RESIDENTIAL"])
# or
table(Top5$LocationDescription, Top5$Weekday)
