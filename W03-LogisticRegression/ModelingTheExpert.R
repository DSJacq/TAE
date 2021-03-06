### TAE W3 - LOGISTIC REGRESSION

# Modeling the Expert: An Introducstion to Logistic Regression

# Source:
# URL:

# 1. REPLICATING EXPERT ASSESSMENT

# 2. BUILDING THE DATASET
# Variable:  
# Categorical
# Binary

# 3. LOGISTIC REGRESSION
# Logistic regression predicts the probability of the outcome variable being true.
# Bo = -1.5, B1 = 3, B2 = -0.5
# x1 = 1, x2 = 5
# log(Odds) = -1.5 + 3*1 - 0.5*5 = -1
# P(y = 1) = 1/(1 + e^(-Logit)) = 1/(1 + e^(1)) = 0.2689414.

# 4. LOGISTIC REGRESSION IN R

quality = read.csv("quality.csv")
str(quality)

table(quality$PoorCare)
98/131

install.packages("caTools")
library(caTools)

set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
split
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
nrow(qualityTrain)
nrow(qualityTest)

names(qualityTrain)
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, family = binomial, data = qualityTrain)
summary(QualityLog)
coef(QualityLog)

predictTrain = predict(QualityLog, type = "response")
summary(predictTrain)
tapply(predictTrain, qualityTrain$PoorCare, mean)

Model = glm(PoorCare ~ StartedOnCombination + ProviderCount, data=qualityTrain, family=binomial)
coef(Model)

# 5. THRESHOLDING

# Confusion Matrix

table(qualityTrain$PoorCare, predictTrain > 0.5)
# Sensitivity
10/25
# Specificity
70/74

table(qualityTrain$PoorCare, predictTrain > 0.7)
# Sensitivity
8/25
# Specificity
73/74

table(qualityTrain$PoorCare, predictTrain > 0.2)
# Sensitivity
16/25
# Specificity
54/74

# 6. ROC CURVES (Receiver Operator Characteristic curve)

# high threshold vs low threshold

install.packages("ROCR")
library(ROCR)

ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf)
plot(ROCRperf, colorize = TRUE)
plot(ROCRperf, colorize = TRUE, print.cutoffs.at = seq(0,1,0.1), text.adj = c(-0.2, 1.7))

# 7. INTERPRETING THE MODEL

# AUC (Area Under the ROC Curve)

predictTest = predict(QualityLog, type="response", newdata=qualityTest)
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)
auc
