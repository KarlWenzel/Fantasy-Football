
stopifnot( exists("dir.tidy") )

PX = data.frame(
  read.csv(paste(dir.tidy, "PX.csv", sep="")) 
)

PRB = data.frame(
  read.csv(paste(dir.tidy, "PRB.csv", sep="")) 
)

PQB = data.frame(
  read.csv(paste(dir.tidy, "PQB.csv", sep="")) 
)

PWR = data.frame(
  read.csv(paste(dir.tidy, "PWR.csv", sep="")) 
)

POL = data.frame(
  read.csv(paste(dir.tidy, "POL.csv", sep="")) 
)