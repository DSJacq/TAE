### TAE W02 - LINEAR REGRESSION

### Moneyball: The Power of Sports Analytics

# Source: Sports Reference > Baseball Reference
# URL: http://www.baseball-reference.com/




###  MAKING IT TO THE PLAYOFFS

baseball = read.csv("baseball.csv")
str(baseball)

moneyball = subset(baseball, Year < 2002)
str(moneyball)

moneyball$RD = moneyball$RS - moneyball$RA # RD Run Difference
str(moneyball)

plot(moneyball$RD, moneyball$W)

WinsReg = lm(W ~ RD, data = moneyball)
summary(WinsReg)

# W = 80.8814 + 0.1058(RD)
# RD >= 95
# 80.8814 + 0.1058(RD) >= 95
# RD >= (95 - 80.8814) / 0.1058 = 133.4 ~ 135

# If a baseball team scores 713 runs and allows 614 runs, how many games do we expect the team to win?
RD = 713 - 614
W = 80.8814 + (0.1058*RD)
W





### PREDICTING RUNS

str(moneyball)

RunReg = lm(RS ~ OBP + SLG + BA, data = moneyball)
summary(RunReg)
RunReg = lm(RS ~ OBP + SLG, data = moneyball)
summary(RunReg)

# If a baseball team's OBP is 0.311 and SLG is 0.405, how many runs do we expect the team to score?
OBP = 0.311
SLG = 0.405
RS = -804.63 + 2737.77*OBP + 1584.91*SLG
RS

# If a baseball team's opponents OBP (OOBP) is 0.297 and oppenents SLG (OSLG) is 0.370, how many runs do we expect the team to allow?
RunReg = lm(RA ~ OOBP + OSLG, data = moneyball)
summary(RunReg)
OOBP = 0.297
OSLG = 0.370
RA = -837.38 + 2913.60*OOBP + 1514.29*OSLG
RA




### WINNING THE WORLD SERIES

# 
teamRank = c(1,2,3,3,4,4,4,4,5,5)
wins2012 = c(94, 88, 95, 88, 93, 94, 98, 97, 93, 94)
wins2013 = c(97, 97, 92, 93, 92, 96, 94, 96, 92, 90)
# What is the correlation between teamRank and wins2012?
cor(teamRank, wins2012)
# What is the correlation between teamRank and wins2013?
cor(teamRank, wins2013)
