
# STATE DATA REVISITED





# Linear Regression Models

# 1.1

# load data
state = read.csv("statedataSimple.csv")

# convert to a data frame
data(state)
statedata = data.frame(state.x77)
str(statedata)

RegModel = lm(Life.Exp ~., data = statedata)
summary(RegModel)

# 1.2

Predictions = predict(RegModel)

# SSE
sum((statedata$Life.Exp - Predictions)^2)
sum(RegModel$residuals^2)

# 1.3

RegModel2 = lm(Life.Exp ~ Population + Murder + Frost + HS.Grad, data=statedata)
summary(RegModel2)

# 1.4

Predictions2 = predict(RegModel2)

# SSE
sum((statedata$Life.Exp - Predictions2)^2)
sum(RegModel2$residuals^2)

# 1.5

cor(statedata$Life.Exp, statedata$Income)
cor(statedata$Life.Exp, statedata$Illiteracy)
cor(statedata$Life.Exp, statedata$Area)







# CART Models

# 2.1

CARTModel = rpart(Life.Exp ~., data = statedata)
prp(CARTModel)

# 2.2

PredictionsCART = predict(CARTModel)
# SSE
sum((statedata$Life.Exp - PredictionsCART)^2)

# 2.3

CARTmodel2 = rpart(Life.Exp ~ ., data=statedata, minbucket=5)
prp(CARTmodel2)

# 2.5

PredictionsCART2 = predict(CARTmodel2)
# SSE
sum((statedata$Life.Exp - PredictionsCART2)^2)

# 2.6

CARTmodel3 = rpart(Life.Exp ~ Area, data=statedata, minbucket=1)
PredictionsCART3 = predict(CARTmodel3)
sum((statedata$Life.Exp - PredictionsCART3)^2)

# 2.7

prp(CARTmodel3)






# Cross-validation

# 3.1

library(caret)
set.seed(111)

# set up cross-validation
fitControl = trainControl(method = "cv", number = 10)
cartGrid = expand.grid(.cp = seq(0.01, 0.5, 0.01) )

# best value of cp
train(Life.Exp ~ ., data=statedata, method="rpart", trControl = fitControl, tuneGrid = cartGrid)

# 3.2

CARTmodel4 = rpart(Life.Exp ~ ., data=statedata, cp=0.12)
prp(CARTmodel4)

# 3.3

PredictionsCART4 = predict(CARTmodel4)
sum((statedata$Life.Exp - PredictionsCART4)^2)

# 3.4

# The purpose of cross-validation is to pick the tree that will perform the best on a test set (best cp)
# Cross-validation is not designed to improve the fit on the training data, but it won't necessarily make it worse either.
# Cross-validation cannot guarantee improving the SSE on unseen data, although it often helps.

# 3.5

set.seed(111)
train(Life.Exp ~ Area, data=statedata, method="rpart", trControl = fitControl, tuneGrid = cartGrid )
CARTmodel5 = rpart(Life.Exp ~ Area, data=statedata, cp=0.02)
prp(CARTmodel5)

# 3.7

PredictionsCART5 = predict(CARTmodel5)
sum((statedata$Life.Exp - PredictionsCART5)^2)




