

## Limiting to Teams Making the Playoffs

# 1.1

baseball = read.csv("baseball.csv")
str(baseball)
nrow(baseball)

# 1.2

table(baseball$Year)
length(table(baseball$Year))

# 1.3

baseball = subset(baseball, Playoffs == 1)
str(baseball)
nrow(baseball)

# 1.4

table(baseball$Year)
table(table(baseball$Year))





## Adding an Important Predictor

# 2.1

PlayoffTable = table(baseball$Year)
str(names(PlayoffTable))

# 2.2 Given a vector of names, the table will return a vector of frequencies. Which function call returns the number of playoff teams in 1990 and 2001? 

PlayoffTable[c("1990","2001")]

# 2.3

# as.character() is needed to convert the Year variable in the dataset to a string
baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)]

# 2.4 How many playoff team/year pairs are there in our dataset from years where 8 teams were invited to the playoffs?

table(baseball$NumCompetitors)





## Bivariate Models for Predicting World Series Winner


# 3.1 WorldSeries takes value 1 if a team won the World Series in the indicated year and a 0 otherwise. How many observations do we have in our dataset where a team did NOT win the World Series?


baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
table(baseball$WorldSeries)

# 3.2

summary(glm(WorldSeries~Year, data=baseball, family="binomial"))





# Multivariate Models for Predicting World Series Winner

# 4.1

LogModel = glm(WorldSeries ~ Year + RA + RankSeason + NumCompetitors, data=baseball, family=binomial)
summary(LogModel)

# 4.2

cor(baseball[c("Year","RA","RankSeason","NumCompetitors")])

# 4.3

Model1 = glm(WorldSeries ~ Year + RA, data=baseball, family=binomial)
Model2 = glm(WorldSeries ~ Year + RankSeason, data=baseball, family=binomial)
Model3 = glm(WorldSeries ~ Year + NumCompetitors, data=baseball, family=binomial)
Model4 = glm(WorldSeries ~ RA + RankSeason, data=baseball, family=binomial)
Model5 = glm(WorldSeries ~ RA + NumCompetitors, data=baseball, family=binomial)
Model6 = glm(WorldSeries ~ RankSeason + NumCompetitors, data=baseball, family=binomial)


