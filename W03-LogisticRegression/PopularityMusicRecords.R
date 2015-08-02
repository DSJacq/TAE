### TAE W3 - LOGISTIC REGRESSION

# H3 - POPULARITY OF MUSIC RECORDS

# Source: Billboard.com, and EchoNest
# URL:




# 1. UNDERSTANDING THE DATA  

songs = read.csv("songs.csv")
str(songs)

table(songs$year == 2010)

MJ = subset(songs, artistname == "Michael Jackson")
str(MJ) 
nrow(MJ)

MJ$Top10
MJ$songtitle[MJ$Top10 == 1]

table(songs$timesignature)
names(songs)
songs$songtitle[which.max(songs$tempo)]





# 2. CREATING OUR PREDICTION MODEL

SongsTrain = subset(songs, year <= 2009)
SongsTest = subset(songs, year == 2010)
nrow(SongsTrain)
nrow(SongsTest)

nonvars = c("year", "songtitle", "artistname", "songID", "artistID")
SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]
SongsLog1 = glm(Top10 ~ ., data = SongsTrain, family = "binomial")
summary(SongsTest)






# 3. MULTICOLLINEARITY ISSUES!  

cor(SongsTrain$loudness, SongsTrain$energy)

SongsLog2 = glm(Top10 ~ . - loudness, data = SongsTrain, family = "binomial")
summary(SongsLog2)

SongsLog3 = glm(Top10 ~ . - energy, data = SongsTrain, family = "binomial")
summary(SongsLog3)



 



# 4. VALIDATING MODEL

testPredict = predict(SongsLog3, newdata = SongsTest, type = "response")        
# confusion matrix with 
table(SongsTest$Top10, testPredict >= 0.45)
# accuracy
a = (309+19)/(309+5+40+19)
a

table(SongsTest$Top10)
a = 314/(314+59)
a

table(SongsTest$Top10, testPredict >= 0.45)
# sensitivity 
sens = 19/(19+40)
sens
# specificity
spec = 309/(309+5)
spec


