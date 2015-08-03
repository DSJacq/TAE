### TAE W01 - STOCK DYNAMICS

# Source: InfoChimps
# URL: http://www.infochimps.com/

IBM = read.csv("IBMStock.csv")
GE = read.csv("GEStock.csv")
CC = read.csv("CocaColaStock.csv")
PG = read.csv("ProcterGambleStock.csv")
Boeing = read.csv("BoeingStock.csv")





### SUMMARY STATISTICS

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CC$Date = as.Date(CC$Date, "%m/%d/%y")
PG$Date = as.Date(PG$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

str(IBM)
IBM$Date[480]
names(IBM)
mean(IBM$StockPrice)
GE$StockPrice[which.min(GE$StockPrice)]
CC$StockPrice[which.max(CC$StockPrice)]
median(Boeing$StockPrice)
sd(PG$StockPrice)



 

### VISUALIZING STOCK DYNAMICS

CC$Date[which.max(CC$StockPrice)]
CC$Date[which.min(CC$StockPrice)]
plot(CC$Date, CC$StockPrice, type="l", col = "red")
lines(PG$Date, PG$StockPrice, col = "blue")
abline(v=as.Date(c("2000-03-01")), lwd=2)

plot(CC$Date[301:432], CC$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
abline(v=as.Date(c("2000-03-01")), lwd=2)
lines(IBM$Date, IBM$StockPrice, col = "blue")
lines(GE$Date, GE$StockPrice, col = "black")
lines(PG$Date, PG$StockPrice, col = "green")
lines(Boeing$Date, Boeing$StockPrice, col = "purple")

abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-11-01")), lwd=2)
abline(v=as.Date(c("2004-01-01")), lwd=2)
abline(v=as.Date(c("2005-01-01")), lwd=2)
