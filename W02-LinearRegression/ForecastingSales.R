### TAE H02 - FORECASTING ELANTRA SALES (OPTIONAL)

# Source: monthly sales of the Hyundai Elantra in the United States




# 1.0 LOADING THE DATA  
Elantra = read.csv("elantra.csv")
str(elantra)

ElantraTrain = subset(elantra, Year <= 2012)
ElantraTest = subset(elantra, Year > 2012)

nrow(elantraTrain)

# 2.1 A LINEAR REGRESSION MODEL  
names(elantra)
LinReg = lm(ElantraSales ~ Unemployment + CPI_all + CPI_energy + Queries, data = elantraTrain)
summary(LinReg)

# 3.1 MODELING SEASONALITY
names(Elantra)
LinReg2 = lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy + Queries, data = elantraTrain)
summary(LinReg2)

# 3.3 UNDERSTANDING THE MODEL
M1 = 3-1
M2 = 5-1
PredictElantraSales = 110.69*M2
PredictElantraSales

# 3.4 NUMERIC VS. FACTORS
# we must convert Month to a factor variable before adding it to the model.
# By modeling Month as a factor variable, the effect of each calendar month is not restricted to be linear in the numerical coding of the month. 

# 4.1 A NEW MODEL
ElantraTrain$MonthFactor = as.factor(ElantraTrain$Month)
ElantraTest$MonthFactor = as.factor(ElantraTest$Month)
ElantraLM = lm(ElantraSales ~ Unemployment + Queries + CPI_energy + CPI_all + MonthFactor, data=ElantraTrain)
summary(ElantraLM)

# 5.1 MULTICOLINEARITY  & 5.2 CORRELATIONS  
cor(ElantraTrain[c("Unemployment","Month","Queries","CPI_energy","CPI_all")])

# 6.1 A REDUCED MODEL
summary(ElantraLM)
ElantraLM = lm(ElantraSales ~ Unemployment + CPI_energy + CPI_all + MonthFactor, data=ElantraTrain)
summary(ElantraLM)

# 6.2 TEST SET PREDICTIONS
PredictTest = predict(ElantraLM, newdata=ElantraTest)
SSE = sum((PredictTest - ElantraTest$ElantraSales)^2)
SSE

# 6.3 COMPARING TO A BASELINE
names(ElantraTrain)
mean(ElantraTrain$ElantraSales)

# 6.4 TEST SET R-SQUARED  
SST = sum((mean(ElantraTrain$ElantraSales) - ElantraTest$ElantraSales)^2)
R2 = 1 - (SSE/SST)
R2

# 6.5 ABSOLUTE ERRORS
max(abs(PredictTest - ElantraTest$ElantraSales))

# 6.6 MONTH OF LARGEST ERROR  
which.max(abs(PredictTest - ElantraTest$ElantraSales))
