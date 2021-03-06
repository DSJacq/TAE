### TAE W1 - AN INTRODUCTION TO ANALYTICS

# INTERNET PRIVACY POLL

# Source: Pew Research Center
# URL: http://www.pewinternet.org/datasets/july-2013-anonymity-omnibus/




# 1.LOADING AND SUMMARIZING THE DATASET

poll = read.csv("AnonymityPoll.csv")
str(poll)

names(poll)
table(poll$Smartphone)

table(poll$Sex, poll$Region)
table(poll$State, poll$Region)
SouthInterviewees = subset(poll, Region=="South")
table(SouthInterviewees$State)





# 2.INTERNET AND SMARTPHONE USERS

table(poll$Internet.Use, poll$Smartphone)
summary(poll)

limited = subset(poll, Internet.Use == 1 | Smartphone == 1)
nrow(limited)





# 3.SUMMARIZING OPINIONS ABOUT INTERNET PRIVACY  

summary(limited)
mean(limited$Info.On.Internet)
table(limited$Info.On.Internet)

table(limited$Worry.About.Info)
table(limited$Anonymity.Possible)
table(limited$Tried.Masking.Identity)
table(limited$Privacy.Laws.Effective)





# 4.RELATING DEMOGRAPHICS TO POLLING RESULTS  

hist(limited$Age)
plot(limited$Age, limited$Info.On.Internet)
table(limited$Age, limited$Info.On.Internet)
max(table(limited$Age, limited$Info.On.Internet))
#avoid points covering each other up
jitter(c(1, 2, 3))
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))

tapply(limited$Info.On.Internet, limited$Smartphone, mean)
tapply(limited$Info.On.Internet, limited$Smartphone, summary)
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)
tapply(limited$Tried.Masking.Identity, limited$Smartphone, summary)

