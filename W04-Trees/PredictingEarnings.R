
# PREDICTING EARNINGS FROM CENSUS DATA



# A Logistic Regression Model

# 1.1 

census = read.csv("census.csv")
str(census)

# split data
library(caTools)
set.seed(2000)
spl = sample.split(census$over50k, SplitRatio = 0.6)
train = subset(census, spl == TRUE)
test = subset(census, spl == FALSE)

# logistic regression model
censusglm = glm(over50k ~ ., family = "binomial", data = train)
summary(censusglm)

# 1.2 

# accuracy of the model on the testing set
predictTest = predict(censusglm, newdata = test, type = "response")
table(test$over50k, predictTest >=0.5)
(9051+1888)/(9051+662+1190+1888)

# 1.3

# baseline accuracy for the testing set
table(train$over50k)
table(test$over50k)
9713/(9713+3078)

# 1.4 

# area-under-the-curve (AUC) for this model on the test set
library(ROCR)
ROCRpred = prediction(predictTest, test$over50k)
as.numeric(performance(ROCRpred, "auc")@y.values)






# A CART Model

# 2.1

library(rpart)
library(rpart.plot)

censustree = rpart(over50k ~., method = "class", data = train)
prp(censustree)

# 2.2
