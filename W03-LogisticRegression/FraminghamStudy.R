### TAE W3 - LOGISTIC REGRESSION

# The Framingham Health Study: Evaluating Risk Factors to Save Lives

# Source: BioLINCC
# URL: https://biolincc.nhlbi.nih.gov/static/studies/teaching/framdoc.pdf


# 1.THE FRAMINGHAM HEART STUDY


# 2.RISK FACTORS


# 3.A LOGISTIC REGRESSION MODEL

framingham = read.csv("framingham.csv ")
str(framingham)

library(caTools)
set.seed(1000)
split = sample.split(framingham$TenYearCHD, SplitRatio = 0.65)

#Internal Validation
train = subset(framingham, split == TRUE)
test = subset(framingham, split == FALSE)
framinghamLog = glm(TenYearCHD ~ ., data = train, family = binomial)
summary(framinghamLog)

predictTest = predict(framinghamLog, type = "response", newdata = test)
table(test$TenYearCHD, predictTest > 0.5)

#accuracy
(1069+11)/(1069+6+187+11)
(1069+6)/(1069+6+187+11)

library(ROCR)
ROCRpred = prediction(predictTest, test$TenYearCHD)
as.numeric(performance(ROCRpred, "auc")@y.values)


# 4.VALIDATING THE MODEL


# External Validation


# 5.INTERVENTIONS


#6.OVERALL IMPACT
