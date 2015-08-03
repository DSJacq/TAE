### TAE W01 - DEMOGRAPHICS AND EMPLOYMENT IN THE UNITED STATES



### LOADING AND SUMMARIZING THE DATASET  

cps = read.csv("CPSData.csv")
summary(cps)
str(cps)
names(cps)
sort(table(cps$Industry))
which.min(table(cps$State))
which.max(table(cps$State))

table(cps$Citizenship)
citizens.usa = (116639+7073)/(116639+7073+7590)
citizens.usa

table(cps$Race, cps$Hispanic)





### EVALUATING MISSING VALUES

summary(cps)

is.na(cps$Married)
table(cps$Region, is.na(cps$Married))
table(cps$Sex, is.na(cps$Married))
table(cps$Citizenship, is.na(cps$Married))
table(cps$Age, is.na(cps$Married))

table(cps$State, is.na(cps$MetroAreaCode))
table(cps$Region, is.na(cps$MetroAreaCode))

tapply(is.na(cps$MetroAreaCode), cps$State, mean)
sort(tapply(is.na(cps$MetroAreaCode), cps$State, mean))





### INTEGRATING METROPOLITAN AREA DATA  

MetroAreaMap = read.csv("MetroAreaCodes.csv")
MetroAreaMap
CountryMap = read.csv("CountryCodes.csv")

CPS = merge(cps, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
str(CPS)
summary(CPS$MetroArea)

sort(table(CPS$MetroArea))
sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))

sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

which.min(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))





### INTEGRATING COUNTRY OF BIRTH DATA

CPS = read.csv("CPSData.csv")
CPS
CountryMap
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)

table(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country != "United States")
x = 1668/(1668+3736)

sort(tapply(CPS$Country == "India", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country == "Brazil", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country == "Somalia", CPS$MetroArea, sum, na.rm=TRUE))
