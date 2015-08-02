### TAE W4 - TREES

### Judge, Jury, and Classifier: An Introduction to Trees

# Source: Supreme Court Forecasting Project 
# URL: http://wusct.wustl.edu/data.php





# 1. THE SUPREME COURT





# 2. CART
# Dependent Variable | 1 = reverse, 0 = affirm
# Independent Variable (Circuit court, Issue area, Type of petition, Unconstitutional)





# 3. SPLITTING AND PREDICTIONS
# Error Slide 2: 
# the percentage of observations with outcome affirm is 10/(10+2) = 0.83






# 4. CART IN R

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

StevensTree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method = "class", minbucket = 25)
prp(StevensTree)

PredictCart = predict(StevensTree, newdata = Test, type = "class")
table(Test$Reverse, PredictCart)
# Accuracy
(41+71)/(41+36+22+71)

library(ROCR)
PredictROC = predict(StevensTree, newdata = Test)
PredictROC

Pred = prediction(PredictROC[,2], Test$Reverse)
Perf = performance(Pred, "tpr", "fpr")
plot(Perf)

