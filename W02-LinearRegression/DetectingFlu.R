### TAE H02 - DETECTING FLU EPIDEMICS VIA SEARCH ENGINE QUERY DATA 

# Source: Google
# URL: https://www.google.org/flutrends/us/#US




# 1.1 UNDERSTANDING THE DATA
FluTrain = read.csv("FluTrain.csv")
str(FluTrain)
names(FluTrain)
FluTrain$Week[which.max(FluTrain$ILI)]
ILImax = subset(FluTrain, ILI == max(ILI))
ILImax

# 1.2 UNDERSTANDING THE DATA
hist(FluTrain$ILI, col = "light blue", main = "Influenza-Like Illness (ILI)")

# 1.3 UNDERSTANDING THE DATA
# Log
# When handling a skewed dependent variable, it is often useful to predict the 
# logarithm of the dependent variable instead of the dependent variable itself 
#-- this prevents the small number of unusually large or small observations 
#from having an undue influence on the sum of squared errors of predictive models.
plot(FluTrain$Queries, log(FluTrain$ILI), col = "blue")
# Visually, there is a positive, linear relationship between log(ILI) and Queries.

# 2.1 LINEAR REGRESSION MODEL
# log(ILI) = intercept + coefficient x Queries, 
# where the coefficient is positive log(ILI) = intercept + coefficient x Queries, 
# where the coefficient is positive - correct

# 2.2 LINEAR REGRESSION MODEL  
FluTrend1 = lm(log(FluTrain$ILI) ~ Queries, data = FluTrain)
summary(FluTrend1)
# R-squared = Correlation^2 

# 3.1 PERFORMANCE ON THE TEST SET  
FluTest = read.csv("FluTest.csv")
str(FluTest)
PredTest1 = exp(predict(FluTrend1, newdata=FluTest))
which(FluTest$Week == "2012-03-11 - 2012-03-17")
PredTest1[11]

# 3.2 PERFORMANCE ON THE TEST SET
# (Observed ILI - Estimated ILI)/Observed ILI
FluTest$ILI[11]
PredTest1[11]
PerfTest = (2.293422 - 2.187378)/2.293422
PerfTest

# 3.3 PERFORMANCE ON THE TEST SET
SSE = sum((PredTest1-FluTest$ILI)^2)
RMSE = sqrt(SSE / nrow(FluTest))
RMSE
# or
RMSE = sqrt(mean((PredTest1-FluTest$ILI)^2))
RMSE

# 4.1 TRAINING A TIME SERIES MODEL
install.packages("zoo")
# "zoo" package >> provides a number of helpful methods for time series models
library(zoo)
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)
# In these commands, the value of -2 passed to lag means to return 2 observations before the current one; 
# a positive value would have returned future observations. 
# The parameter na.pad=TRUE means to add missing values for the first two weeks of our dataset, 
# where we can't compute the data from 2 weeks earlier.
summary(ILILag2)

# 4.2 TRAINING A TIME SERIES MODEL
plot(ILILag2, FluTrain$ILI, col = "orange")

# 4.3 TRAINING A TIME SERIES MODEL
FluTrend2 = lm(log(ILI)~Queries+log(ILILag2), data=FluTrain)
summary(FluTrend2)

# 5.1 EVALUATING THE TIME SERIES MODEL IN THE TEST SET
ILILag2 = lag(zoo(FluTest$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 = coredata(ILILag2)
summary(FluTest$ILILag2)

# 5.3 EVALUATING THE TIME SERIES MODEL IN THE TEST SET
FluTest$ILILag2[1] = FluTrain$ILI[416]
FluTest$ILILag2[2] = FluTrain$ILI[417]
FluTest$ILILag2[1]
FluTest$ILILag2[2]

# 5.4 EVALUATING THE TIME SERIES MODEL IN THE TEST SET
# We can obtain the test-set predictions with:   
PredTest2 = exp(predict(FluTrend2, newdata=FluTest))
# And then we can compute the RMSE with the following commands:      
SSE = sum((PredTest2-FluTest$ILI)^2)
RMSE = sqrt(SSE / nrow(FluTest))
RMSE
# Alternatively, you could use the following command to compute the RMSE:      
RMSE = sqrt(mean((PredTest2-FluTest$ILI)^2))
RMSE
