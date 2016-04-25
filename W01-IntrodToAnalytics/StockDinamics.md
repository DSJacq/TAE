
## Stock Dinamics


- IBM
- GE
- P&G
- Boeing
- CC (Coca Cola)


```coffee
CC$Date[which.max(CC$StockPrice)]
CC$Date[which.min(CC$StockPrice)]
plot(CC$Date, CC$StockPrice, type="l", col = "red")
lines(PG$Date, PG$StockPrice, col = "blue")
abline(v=as.Date(c("2000-03-01")), lwd=2)
```
![alt tag] (https://raw.githubusercontent.com/DSJacq/Visualization/master/StockDinamics_PG-CC.jpeg)



```coffee
plot(CC$Date[301:432], CC$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
abline(v=as.Date(c("2000-03-01")), lwd=2)
lines(IBM$Date, IBM$StockPrice, col = "blue")
lines(GE$Date, GE$StockPrice, col = "black")
lines(PG$Date, PG$StockPrice, col = "green")
lines(Boeing$Date, Boeing$StockPrice, col = "purple")
```
![alt tag] (https://raw.githubusercontent.com/DSJacq/Visualization/master/StockDinamics_IBM-GE.jpeg)


