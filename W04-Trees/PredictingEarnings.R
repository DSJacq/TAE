
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

# 2.1 + 2.2 + 2.3

library(rpart)
library(rpart.plot)

censustree = rpart(over50k ~., method = "class", data = train)
prp(censustree)

# 2.4

predictTest = predict(censustree, newdata = test, type = "class")
table(test$over50k, predictTest)
(9243+1596)/(9243+470+1482+1596)

# 2.5

# Obs: The breakpoints of the curve correspond to the false and true positive rates when the threshold is set to 
# the five possible probability values.
# The probabilities from the CART model take only a handful of values (five, one for each end bucket/leaf of the tree); 
# the changes in the ROC curve correspond to setting the threshold to one of those values. 

# 2.6

library(ROCR)

predictTest = predict(censustree, newdata = test)
predictTest = predictTest[,2]

# AUC
ROCRpred = prediction(predictTest, test$over50k)
as.numeric(performance(ROCRpred, "auc",)@y.values)





# A Random Forest Model

# 3.1

library(randomForest)
set.seed(1)
trainSmall = train[sample(nrow(train), 2000), ]

# random forest mddel
censusrf = randomForest(over50k ~ ., data = trainSmall)

# predict
predictTest = predict(censusrf, newdata = test)

# accuracy
table(test$over50k, predictTest)
(9614+1050)/nrow(test)

# 3.2

vu = varUsed(censusrf, count = TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(censusrf$forest$xlevels[vusorted$ix]))

# 3.3

varImpPlot(censusrf)






# Selecting cp by Cross-Validation

# 4.1

install.packages("caret")
install.packages("lme4")
install.packages("e1071")

library(caret)
library(e1071)
library(lme4)

set.seed(2)

# k-fold cross validation: k = 10 folds
fitControl = trainControl( method = "cv", number = 10)

# grid of cp values
cartGrid = expand.grid( .cp = seq(0.002, 0.1, 0.002))

train(over50k ~ ., data = train, method = "rpart", trControl = fitControl, tuneGrid = cartGrid)

#  the best value was cp = 0.002, corresponding to the lowest cp value

# 4.2

# CART model
model = rpart(over50k~., data=train, method="class", cp=0.002)

# predict
predictTest = predict(model, newdata = test, type = "class")

# confusion matrix
table(test$over50k, predictTest)

# accuracy
(9178+1838)/(9178+535+1240+1838)

# 4.3

library(rpart.plot)
prp(model)
