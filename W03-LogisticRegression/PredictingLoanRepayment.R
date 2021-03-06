### TAE W3 - LOGISTIC REGRESSION

# H3 - PREDICTING LOAN REPAYMENT

# Source: Lending Club Statistics
# URL: https://www.lendingclub.com/info/download-data.action




# 1. PREPARING THE DATASET

loan = read.csv("loans.csv")
str(loan)
table(loan$not.fully.paid)

npif = 1533/(8045+1533)
npif

missing = subset(loan, is.na(log.annual.inc) | is.na(days.with.cr.line) | is.na(revol.util) | is.na(inq.last.6mths) | is.na(delinq.2yrs) | is.na(pub.rec))
nrow(missing) # 62 of 9578 loans have missing data
table(missing$not.fully.paid)

library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loan), "not.fully.pais")
imputed = complete(mice(loan[vars.for.imputation]))
loan[vars.for.imputation] = imputed





# 2. PREDICTION MODELS

library(caTools)
set.seed(144)
split = sample.split(loan$not.fully.paid, 0.7)
train = subset(loan, split == TRUE)
test = subset(loan, split == FALSE)

mod = glm(not.fully.paid ~., data = train, family = "binomial")
summary(mod)

test$predicted.risk = predict(mod, newdata = test, type = "response")
table(test$not.fully.paid, test$predicted.risk > 0.5)

# accuracy of the logistic regression model
alm = 2400/2873
alm

# accuracy of the baseline mode
abm = 2413/2873
abm

# AUC
library(ROCR)
pred = prediction(test$predicted.risk, test$not.fully.paid)
as.numeric(performance(pred, "auc") @ y.values)





# 3. A "SMART BASELINE"

bivariate = glm(not.fully.paid ~ int.rate, data = train, family = "binomial")
summary(bivariate)
cor(train$int.rate, train$fico)

pred.bivariate = predict(bivariate, newdata = test, type = "response")
summary(pred.bivariate)

# AUC
prediction.bivariate = prediction(pred.bivariate, test$not.fully.paid)
as.numeric(performance(prediction.bivariate, "auc") @ y.values)




# 4. COMPUTING THE PROFITABILITY OF AN INVESTMENT  

investment  = c
interest = r
timeyears = t

c = 10
r = 0.06
t = 3

InvesmentValue = c*exp(r*t) 
InvesmentValue

Profit = c * exp(rt) - c





# 5. A SIMPLE INVESTMENT STRATEGY

test$profit = exp(test$int.rate * 3) - 1
test$profit[test$not.fully.paid == 1] = -1
summary(test$profit)




# 6. AN INVESTMENT STRATEGY BASED ON RISK

HighInterest = subset(test, int.rate >= 0.15)
summary(HighInterest$profit)
table(HighInterest$not.fully.paid)

cutoff = sort(HighInterest$predicted.risk, decreasing = FALSE)[100]
SelectedLoans = subset(HighInterest, predicted.risk <= cutoff)
sum(SelectedLoans$profit)
table(SelectedLoans$not.fully.paid)

