### TAE W02 - LINEAR REGRESSION

### Playing Moneyball in the NBA

# Source: Sports Reference
# URL: http://www.basketball-reference.com/


### THE DATA

NBA = read.csv("NBA_train.csv")
str(NBA)




### PLAYOFFS AND WINS

table(NBA$W, NBA$Playoffs)

NBA$PTSdiff = NBA$PTS - NBA$oppPTS
plot(NBA$PTSdiff, NBA$W)

WinsReg = lm(W ~ PTSdiff, data = NBA)
summary(WinsReg)

W = 41 + 0.0326*PTSdiff
PTSdiff = (42 - 41) / 0.0326
PTSdiff





### POINTS SCORED

PointsReg = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + TOV + STL + BLK, data = NBA)
summary(PointsReg)

PointsReg$residuals
SEE = sum(PointsReg$residuals^2)
SEE

RMSE = sqrt(SEE/nrow(NBA))
RMSE

mean(NBA$PTS)

summary(PointsReg)
PointsReg2 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + STL + BLK, data = NBA)
summary(PointsReg2)
PointsReg3 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL + BLK, data = NBA)
summary(PointsReg3)
PointsReg4 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL, data = NBA)
summary(PointsReg4)

SSE4 = sum(PointsReg$residuals^2)
RMSE4 = sqrt(SSE4/nrow(NBA))
SSE4
RMSE4





### MAKING PREDICTIONS

NBA_test = read.csv("NBA_test.csv")
summary(NBA_test)

PointsPredictions = predict(PointsReg4, newdata = NBA_test)
SSE = sum((PointsPredictions - NBA_test$PTS)^2)
SST = sum((mean(NBA$PTS) - NBA_test$PTS)^2)
R2 = 1 - SSE/SST
R2
RMSE = sqrt(SSE/nrow(NBA_test))
RMSE
