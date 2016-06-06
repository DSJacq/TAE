

# UNDERSTANDING WHY PEOPLE VOTE



# 1.1 Exploration and Logistic Regression

gerber = read.csv("gerber.csv")
str(gerber)

table(gerber$voting)
voted = 108696/(108696+235388)
voted

# 1.2

tapply(gerber$voting, gerber$civicduty, mean)
tapply(gerber$voting, gerber$hawthorne, mean)
tapply(gerber$voting, gerber$neighbors, mean)
tapply(gerber$voting, gerber$self, mean)

# 1.3

LogModel = glm(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, family = "binomial")
summary(LogModel)

# 1.4

predictLog = predict(LogModel, type = "response")
 + table(gerber$voting, predictLog > 0.3)
Accuracy = (134513 + 51966) / (135413 + 100875 + 56730 + 51966)
Accuracy
as.numeric(performance(ROCRpred, "auc")@y.values)
# 1.5

library(ROCR)
ROCRpred = prediction(predictLog, gerber$voting)





# 2.1 Trees

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber)
prp(CARTmodel)

# 2.2

CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, cp = 0.0)
prp(CARTmodel2)

# 2.4

CARTmodel3 = rpart(voting  ~ civicduty + hawthorne + self + neighbors + sex, data = gerber, cp = 0.0)
prp(CARTmodel3)





# 3.1 interaction Terms

CARTcontrol = rpart(voting ~ control, data = gerber, cp = 0.0)
CARTsex = rpart(voting ~ sex, data = gerber, cp = 0.0 )
prp(CARTcontrol)
prp(CARTsex)

# 3.2

prp(CARTcontrol, digits = 6)
prp(CARTsex, digits = 6)

# 3.3

LogModelSex = glm(voting ~ control + sex, data = gerber, family = "binomial")
summary(LogModelSex)

# 3.4

Possibilities = data.frame(sex = c(0,0,1,1), control = c(0,1,0,1))
predict(LogModelSex, newdata = Possibilities, type = "response")

CARTtreeWC = 0.290456
LogModelW = 0.2908065
Dif = CARTtreeWC - LogModelW
Dif

# 3.5

LogModel2 = glm(voting ~ sex + control + sex:control, data = gerber, family = "binomial")
summary(LogModel2)

# 3.6

predict(LogModel2, newdata = Possibilities, type = "response")

# 3.7

# possible interaction terms in a logistic regression model should NOT be used due to overfitting
