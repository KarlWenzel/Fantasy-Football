stopifnot( exists("dir.tidy") )

GP = data.frame(
  read.csv(paste(dir.tidy, "GP.csv", sep="")) 
)

GRB = data.frame(
  read.csv(paste(dir.tidy, "GRB.csv", sep="")) 
)

GQB = data.frame(
  read.csv(paste(dir.tidy, "GQB.csv", sep="")) 
)

GWR = data.frame(
  read.csv(paste(dir.tidy, "GWR.csv", sep="")) 
)