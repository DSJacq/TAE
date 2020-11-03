
# LETTER RECOGNITION




# 1.1 Predicting B or not B

letters = read.csv("letters_ABPR.csv")
str(letters)

# create new variable
letters$isB = as.factor(letters$letter == "B")

# split the data

install.packages("caTools")
library(caTools)

set.seed(1000)
spl = sample.split(letters$isB, SplitRatio = 0.5)

train = subset(letters, spl == TRUE)
test = subset(letters, spl == FALSE)

# accuracy

table(test$isB)
accuracy = (1175)/(1175+383)
accuracy

# 1.2

# CART tree
library(rpart)
CARTb = rpart(isB ~ letter, data = train, method = "class")

# predict function
predictions = predict(CARTb, newdata = test, type="class")

# confusion matrix
table(test$isB, predictions)

# accuracy 'test set'
(1118+340)/nrow(test)

# 1.3

# Random Forest Model
install.packages("randomForest")
library(randomForest)

set.seed(1000)
RFb = randomForest(isB ~ xbox + ybox + width + height + onpix + xbar + ybar + x2bar + y2bar + xybar + x2ybar + xy2bar + xedge + xedgeycor + yedge + yedgexcor, data=train)
RFb = randomForest(isB ~ . - letter, data=train)

# predict function
predictions = predict(RFb, newdata = test)

# confusion matrix
table(test$isB, predictions)

# accuracy
(1165+376)/nrow(test)





# 2.1 Predicting the letters A, B, P, R

# converting letter in the original data set (letters) to a factor
letters$letter = as.factor(letters$letter)

# split
set.seed(2000)
spl = sample.split(letters$letter, SplitRatio = 0.5)
train2 = subset(letters, spl == TRUE)
test2 = subset(letters, spl == FALSE)

# accuracy of the baseline method on the test seT
table(test2$letter) 
(401)/nrow(test)


# 2.2

# classification tree to predict "letter"
CARTletter = rpart(letter ~. - isB, data = train2, method = "class")
#predict function
predictLetter = predict(CARTletter, newdata=test2, type="class")
# confusion matrix
table(test2$letter, predictLetter)
# accuracy
(348+318+363+340)/nrow(test2)

# 2.3

# random forest model on the training data
set.seed(1000)
RFletter = randomForest(letter ~. - isB, data = train2)
predictLetter = predict(RFletter, newdata = test2)
table(test2$letter, predictLetter)
(390+380+393+364)/nrow(test2)
