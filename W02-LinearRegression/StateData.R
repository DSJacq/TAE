### TAE H02 - STATE DATA

# Source: "state" dataset, which has data from the 1970s on all fifty US states




### DATA EXPLORATION  

statedata = read.csv("statedata.csv")
summary(statedata)
names(statedata)

plot(statedata$x,statedata$y, col = "red")
mean(statedata$HS.Grad)
tapply(statedata$HS.Grad,statedata$state.region, mean)

boxplot(statedata$Murder ~ statedata$state.region, col = "orange")

#Outlier
NortheastData = subset(statedata, state.region == "Northeast")
NortheastData$state.abb[which.max(NortheastData$Murder)]






### PREDICTING LIFE EXPECTANCY - AN INITIAL MODEL

names(statedata)
LinReg = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data = statedata)
summary(LinReg)

plot(statedata$Income, statedata$Life.Exp, col = "purple")





###  PREDICTING LIFE EXPECTANCY - REFINING THE MODEL AND ANALYZING PREDICTIONS

## Principle of simplicity
LinReg = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data = statedata)
## Backwards variable selection
# Remove the one with the largest "p-value" first, 
# or the one with the "t value" closest to zero
LinReg2 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data = statedata)
summary(LinReg)

# Which state do we predict to have the lowest life expectancy?
which.min(sort(predict(LinReg)))
statedata$state.name[which.min(sort(predict(LinReg)))]

# Which state actually has the lowest life expectancy? 
statedata$state.name[which.min(statedata$Life.Exp)]

# Which state do we predict to have the highest life expectancy?
which.max(sort(predict(LinReg)))
statedata$state.name[47]
statedata$state.name[which.max(sort(predict(LinReg)))]

# Which state actually has the highest life expectancy?
statedata$state.name[which.max(statedata$Life.Exp)]

# For which state do we make the smallest absolute error?
sort(abs(LinReg$residuals))
sort(abs(statedata$Life.Exp - predict(LinReg)))
statedata$state.name[which.min((abs(statedata$Life.Exp - predict(LinReg))))]

# For which state do we make the largest absolute error?
statedata$state.name[which.max((abs(statedata$Life.Exp - predict(LinReg))))]
