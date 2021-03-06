### TAE H02 - CLIMATE CHANGE

#Source: Climatic Research Unit
#URL: http://www.cru.uea.ac.uk/cru/data/temperature/




# 1.1 CREATING OUR FIRST MODEL  
climate = read.csv("climate_change.csv")
str(climate)
names(climate)
train = subset(climate, Year <= 2006)
test = subset(climate, Year > 2006)
climateLM = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data = train)
summary(climateLM)




# 2.2 UNDERSTANDING THE MODEL
cor(train)




# 3.0 SIMPLIFYING THE MODEL
climateLM2 = lm(Temp ~ MEI + N2O + TSI + Aerosols, data = train)
summary(climateLM2)




# 4.0 AUTOMATICALLY BUILDING THE MODEL
climateStep = step(climateLM)
summary(StepModel)




# 5.0 TESTING ON UNSEEN DATA  
tempPredict = predict(climateStep, newdata = test)
SSE = sum((tempPredict - test$Temp)^2)
SST = sum((mean(train$Temp) - test$Temp)^2)
R2 = 1 - SSE/SST
R2
