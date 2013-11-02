data <- read.csv("../subaru.csv")
data$mpg <- round(data$Miles/data$Gallons,2)


y <- nrow(data)
x <- 2
z <- 1
while(x <= y){
  data$odo[x] <- data$odo[z] + data$Miles[x]
  x <- x + 1
  z <- z + 1
}

data$fill <- "gas"
data$Date <- as.Date(data$Date, format='%m/%d/%Y')