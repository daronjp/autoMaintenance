gas <- read.csv("../subaruGas.csv")
payments <- read.csv("../subaruPayments.csv")
insurance <- read.csv("../subaruInsurance.csv")
maintenance <- read.csv("../subaruMaintenance.csv")
gas$mpg <- round(gas$Miles/gas$Gallons,2)
gas$X <- NULL
gas$total <- NULL
gas$total[1] <- 0

y <- nrow(gas)
x <- 2
z <- 1
while(x <= y){
  gas$odo[x] <- gas$odo[z] + gas$Miles[x]
  gas$total[x] <- gas$total[x-1] + gas$cost[x]
  x <- x + 1
  z <- z + 1
}

gas$type <- "gas"
gas$Date <- as.Date(gas$Date, format='%m/%d/%Y')
gas$costMile <- round(gas$cost/gas$Miles,3)

payments$Date <- as.Date(payments$Date, format='%m/%d/%Y')
colnames(payments)[2] <- "totalPmt"
payments$balance <- 1
y <- nrow(payments)
x <- 2
z <- 1
payments$balance[1] <- 21062
payments$total <- NULL
payments$total[1] <- payments$totalPmt[1]

while(x <= y){
  payments$balance[x] <- payments$balance[z] - payments$Principal[x]
  payments$total[x] <- payments$total[x-1] + payments$totalPmt[x]
  x <- x + 1
  z <- z + 1
}

payments$type <- "payment"


maintenance$type <- "maintenance"
maintenance$Date <- as.Date(maintenance$Date, format='%m/%d/%Y')
maintenance$total <- NULL
y <- nrow(maintenance)
x <- 1
while(x <= y){
  if(x == 1){
    maintenance$total[1] <- maintenance$cost[1]
  } else {
    maintenance$total[x] <- maintenance$cost[x] + maintenance$total[x-1]
  }
  x <- x + 1
}

insurance$type <- "insurance"
insurance$Date <- as.Date(insurance$Date, format='%m/%d/%Y')
insurance$cost <- round(insurance$cost,2)
insurance$total <- NULL
y <- nrow(insurance)
x <- 1
while(x <= y){
  if(x == 1){
    insurance$total[1] <- insurance$cost[1]
  } else {
    insurance$total[x] <- insurance$total[x-1] + insurance$cost[x]
  }
  x <- x + 1
    
}

insFormat <- insurance[,c(1,2,3,4)]
maintFormat <- maintenance[,c(1,2,4,5)]
payFormat <- payments[,c(1,2,7,6)]
colnames(payFormat)[2] <- "cost"
gasFormat <- gas[,c(1,5,8,9)]

costs <- rbind(insFormat, maintFormat)
costs <- rbind(costs, payFormat)
costs <- rbind(costs, gasFormat)

costs <- costs[order(costs$Date),]
y <- nrow(costs)
x <- 2
costs$sum[1] <- costs$cost[1]
while(x <= y){
  costs$sum[x] <- costs$cost[x] + costs$sum[x-1]
  x <- x + 1
}
costs$type2 <- "cost"