### TAE W3 - LOGISTIC REGRESSION

# H3 - PREDICTING PAROLE VIOLATORS

# Source: USA 2004 National Corrections Reporting Program
# URL: http://www.icpsr.umich.edu/icpsrweb/NACJD/series/38/studies/26521?archive=NACJD&sortBy=7




# 1. LOADING THE DATASET

parole = read.csv("parole.csv")
str(parole)
table(parole$violator)




# 2. PREPARING THE DATASET

parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)
summary(parole$state)
summary(parole$crime)




# 3. SPLITTING INTO A TRAINING AND TESTING SET

set.seed(144)
library(caTools)
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)




# 4. BUILDING A LOGISTIC REGRESSION MODEL

mod = glm(violator ~., data = train, family = "binomial")
summary(mod)

male=1
race=1
age=50
state2=0
state3=0
state4=0
time.served=3
max.sentence=12
multiple.offenses=0
crime2=1
crime3=0
crime4=0

LogOfOdds = (-4.2411574 + 0.3869904*male + 0.8867192*race - 0.0001756*age + 0.4433007*state2 + 0.8349797*state3 - 3.3967878*state4 - 0.1238867*time.served + 0.0802954*max.sentence + 1.6119919*multiple.offenses + 0.6837143*crime2 - 0.2781054*crime3 - 0.0117627*crime4)
LogOfOdds

OddsRatio = exp(-1.700629)
OddsRatio

PredictedProbability = 1/(1+exp(1.700629))
PredictedProbability




# 5. EVALUATING THE MODEL ON THE TESTING SET

predictions = predict(mod, newdata = test, type = "response")
summary(predictions)

table(test$violator, as.numeric(predictions >= 0.5))
# accuracy: percentage of values on the diagonal
acc = (167+12)/202
acc
# sensitivity: proportion of the actual violators we got correct
sen = 12/(11+12)
sen
# specificity: proportion of the actual non-violators we got correct
spe = 167/(167+12)
spe

# AUC value
library(ROCR)
pred = prediction(predictions, test$violator)
as.numeric(performance(pred, "auc")@y.values)




# 6. IDENTIFYING BIAS IN OBSERVATIONAL DATA
