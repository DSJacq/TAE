### TAE W4 - TREES

### Judge, Jury, and Classifier: An Introduction to Trees

Source: [Supreme Court Forecasting Project] (http://wusct.wustl.edu/data.php)





##### 1. THE SUPREME COURT





##### 2. CART ((Classification and Regression Trees)

Dependent Variable | 1 = reverse, 0 = affirm
Independent Variable (Circuit court, Issue area, Type of petition, Unconstitutional)





##### 3. SPLITTING AND PREDICTIONS

Error Slide 2: the percentage of observations with outcome affirm is 10/(10+2) = 0.83





##### 4. CART IN R

```coffee
stevens = read.csv("stevens.csv")
str(stevens)

library(caTools)

set.seed(3000)
spl = sample.split(stevens$Reverse, SplitRatio = 0.7)
Train = subset(stevens, spl == TRUE)
Test = subset(stevens, spl == FALSE)

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

StevensTree = rpart(Reverse ~ Circuit 
                    + Issue 
                    + Petitioner 
                    + Respondent 
                    + LowerCourt 
                    + Unconst, 
                    data = Train, 
                    method = "class", 
                    minbucket = 25)
prp(StevensTree)
```
![alt tag] (https://raw.githubusercontent.com/DSJacq/TAE/create-branches/Chart/JudgeJuryClassifier_StevensMin25.jpeg)

```coffee
PredictCart = predict(StevensTree, newdata = Test, type = "class")
table(Test$Reverse, PredictCart)
# Accuracy
(41+71)/(41+36+22+71)

```coffee
library(ROCR)
PredictROC = predict(StevensTree, newdata = Test)
PredictROC

Pred = prediction(PredictROC[,2], Test$Reverse)
Perf = performance(Pred, "tpr", "fpr")
plot(Perf)
```

- AUC
```coffee
as.numeric(performance(Pred, "auc")@y.values)
```

- Splits
```coffee
StevensTree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, method="class", data = Train, minbucket=5)
prp(StevensTree)
```

- Splits
```coffee
StevensTree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, method="class", data = Train, minbucket=100)
prp(StevensTree)
```




##### 5. RANDOM FORESTS

install.packages("randomForest")
library(randomForest)

StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, nodesize = 25, ntree = 200)

Train$Reverse = as.factor(Train$Reverse)
Test$Reverse = as.factor(Test$Reverse)

StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, nodesize = 25, ntree = 200)
PredictForest = predict(StevensForest, newdata = Test)

table(Test$Reverse, PredictForest)
(40+74)/(40+37+19+74)

#
set.seed(100)
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25)
PredictForest = predict(StevensForest, newdata = Test)
table(Test$Reverse, PredictForest)
(43+74)/(43+34+19+74)

#
set.seed(200)
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25)
PredictForest = predict(StevensForest, newdata = Test)
table(Test$Reverse, PredictForest)
(44+76)/(44+33+17+76)





##### 6. CROSS-VALIDATION

install.packages("caret")
library(caret)

install.packages("e1071")
library(e1071)

numFolds = trainControl(method = "cv", number =10)
cpGrid = expand.grid(.cp = seq(0.01, 0.5, 0.01))
train(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method = "rpart", trControl = numFolds, tuneGrid = cpGrid)

StevensTreeCV = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method = "class", cp = 0.18)
PredictCV = predict(StevensTreeCV, newdata = Test, type = "class")
table(Test$Reverse, PredictCV)

- Accuracy
(59+64)/(59+18+29+64)

prp(StevensTreeCV) # 1 split



##### 7. THE MODEL V. THE EXPERTS
