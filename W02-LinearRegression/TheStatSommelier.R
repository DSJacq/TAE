### TAE W02 - LINEAR REGRESSION

### The Statistical Sommelier: An Introduction to Linear Regression

# Source: Data and Results for Wine Regressions as Reported in Chance Magazine by Ashenfelter, Ashmore and Lalonde
# URL: http://www.liquidasset.com/winedata.html




### LINEAR REGRESSION IN R

wine = read.csv("wine.csv")
names(wine)
str(wine)
summary(wine)

# lm >> Linear Model

model1 = lm(Price ~ AGST, data=wine)
summary(model1)
model1$residuals
SSE = sum(model1$residuals^2)
SSE

model2 = lm(Price ~ AGST + HarvestRain, data = wine)
summary(model2)
SSE = sum(model2$residuals^2)
SSE

model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data = wine)
summary(model3)
SSE = sum(model3$residuals^2)
SSE

modelQ = lm(Price ~ HarvestRain + WinterRain, data = wine)
summary(model4)






### UNDERSTANDING THE MODEL

model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data = wine)
summary(model4)





### CORRELATION AND MULTICOLLINEARITY

# multicollinearity : when two independent viriabes are highly corrlated
# cor >> Correlation

cor(wine$WinterRain, wine$Price)
cor(wine$Age, wine$FrancePop)
cor(wine$HarvestRain, wine$WinterRain)
cor(wine)

model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data = wine)
summary(model5)





### MAKING PREDICTIONS

wineTest = read.csv("wine_test.csv")
str(wineTest)
#Prediction
predictTest = predict(model4, newdata = wineTest)
predictTest

# R Squarred    1 - (SSE / SST)
SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST
