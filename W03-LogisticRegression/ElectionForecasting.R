### TAE W3 - LOGISTIC REGRESSION

# Election Forecasting: Predicting the Winner Before any Votes are Cast

# Source: Real Clear Politics
# URL: http://www.realclearpolitics.com/




# 1.ELECTION PREDICTION





# 2.DEALING WITH MISSING DATA

polling = read.csv("PollingData.csv")
str(polling)
table(polling$Year)
summary(polling)

### Approach to Missing Data
# delete the missing obs
# delete variables with missing values
# fill missing data points with average values

### Multiple Imputation
# filling missing values based on non-missing vallues

install.packages("mice")
library("mice")

simple = polling[c("Rasmussen", "SurveyUSA", "PropR", "DiffCount")]
summary(simple)
set.seed(144)
imputed = complete(mice(simple))
summary(imputed)

polling$Rasmussen = imputed$Rasmussen
polling$SurveyUSA = imputed$SurveyUSA
summary(polling)





# 3.A SOPHISTICATED BASELINE METHOD

Train = subset(polling, Year == 2004 | Year == 2008)
Test = subset(polling, Year == 2012)

table(Train$Republican)

sign(25)
sign(-15)
sign(0)

table(sign(Train$Rasmussen))

table(Train$Republican, sign(Train$Rasmussen))





# 4.LOGISTIC REGRESSION MODELS

str(Train)
cor(Train[c("Rasmussen", "SurveyUSA", "PropR", "DiffCount")])

mod1 = glm(Republican ~ PropR, data = Train, family = "binomial")
summary(mod1)

pred1 = predict(mod1, type = "response")
table(Train$Republican, pred1 >= 0.5)

mod2 = glm(Republican ~ SurveyUSA+DiffCount, data = Train, family = "binomial")
pred2 = predict(mod2, type = "response")
table(Train$Republican, pred2 >= 0.5)
summary(mod2)





# 5.TEST SET PREDICTIONS

table(Test$Republican, sign(Test$Rasmussen))
TestPrediction = predict(mod2, newdata = Test, type = "response")
table(Test$Republican, TestPrediction >= 0.5)

subset(Test, TestPrediction >= 0.5 & Republican == 0)
