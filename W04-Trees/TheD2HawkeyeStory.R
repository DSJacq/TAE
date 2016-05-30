
# Keeping an Eye on Health Care Cost: The D2Hawkeye Story





#### 1. The Story of D2Hawkeye





#### 2. Claims Data

#- rich, structured data source
#- very high dimention
#- doesn't capture all aspects
#- observation period 2001-2003
#- results period 2003-2004





#### 3. The Variables

#- chronic condition cost indicators
#- 269 medically defined risk rules
#- gender and ange





#### 4. Error Measures

# Penalty Error, define "penalty matrix" as the cost of being wrong
# Baseline: predic that the cost in the next period will be the cost in the current period
# Accuracy of 75%
# Penalty Error of 0.56





#### 5. CART to Predict Cost

# Multi-class Classification





#### 6. Claims Data in R

Claims = read.csv("ClaimsData.csv")
str(Claims)

# the number of patients in each bucket
table(Claims$bucket2009)/nrow(Claims)

library(caTools)
set.seed(88)
spl = sample.split(Claims$bucket2009, SplitRatio = 0.6)
ClaimsTrain = subset(Claims, spl == TRUE)
ClaimsTest = subset(Claims, spl == FALSE)

# average age of patients in the training set
mean(ClaimsTrain$age)

# proportion of people in the training set (ClaimsTrain) had at least one diagnosis code for diabetes
table(ClaimsTrain$diabetes)/nrow(ClaimsTrain)





#### 7. Baseline Method and Penalty Matrix

table(ClaimsTest$bucket2009, ClaimsTest$bucket2008)
(110138+10721+2771+1539+104)/nrow(ClaimsTest)

PenaltyMatrix = matrix(c(0,1,2,3,4,2,0,1,2,3,4,2,0,1,2,6,4,2,0,1,8,6,4,2,0), byrow = TRUE, nrow = 5)
PenaltyMatrix
# actual outcomes on the left
# predicted outcomes on the top

# R penalty error for the baseline model?
as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix
sum(as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix) / nrow(ClaimsTest)

# accuracy of baseline method on the test set
table(ClaimsTest$bucket2009)
122978/nrow(ClaimsTest)

# penalty error on the test set
(0*122978 + 2*34840 + 4*16390 + 6*7937 + 8*1057)/nrow(ClaimsTest)





#### 8. Predicting Healthcare Costs in R

library(rpart)
library(rpart.plot)

ClaimsTree = rpart(bucket2009 ~ age 
                   + alzheimers 
                   + arthritis 
                   + cancer 
                   + copd 
                   + depression 
                   + diabetes 
                   + heart.failure 
                   + ihd + kidney 
                   + osteoporosis 
                   + stroke 
                   + bucket2008 
                   + reimbursement2008, 
                   data=ClaimsTrain, 
                   method="class", cp=0.00005)
prp(ClaimsTree)

PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")
table(ClaimsTest$bucket2009, PredictTest)
(114141+16102+16102+118+201+0)/nrow(ClaimsTest)

# Penalty Error
as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix
sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)

ClaimsTree = rpart(bucket2009 ~ age 
                   + alzheimers 
                   + arthritis 
                   + cancer 
                   + copd 
                   + depression 
                   + diabetes 
                   + heart.failure 
                   + ihd + kidney 
                   + osteoporosis 
                   + stroke 
                   + bucket2008 
                   + reimbursement2008, 
                   data=ClaimsTrain, 
                   method="class", 
                   cp=0.00005, 
                   parms = list(loss = PenaltyMatrix))
PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")
table(ClaimsTest$bucket2009, PredictTest)

# Accuracy
(94310+18942+4692+636+2)/nrow(ClaimsTest)

# Penalty Error
sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)





#### 9. Results
