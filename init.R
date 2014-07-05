library(data.table)

fRoot <- "./NFLData_2012_WK1-8/"

fPath <- list(
  plays   = paste(fRoot, 'FLAT FILE.csv', sep=""),
  games   = paste(fRoot, 'GAMES.csv', sep=""),
  players = paste(fRoot, 'PLAYERS.csv', sep="")
)

getRaw <- list(
  plays   = function() read.csv(fPath$plays),
  games   = function() read.csv(fPath$games),
  players = function() read.csv(fPath$players)
)

basePlaysCols <- c(
  "GID",  "PID",  "DETAIL",  "OFF",  "DEF",
  "DSEQ",  "LEN",  "QTR",  "MIN",  "SEC",
  "PTSO",  "PTSD",  "TIMO",  "TIMD",  "DWN",
  "YTG",  "YFOG",  "ZONE",  "YDS",  "SUCC",
  "FD",  "SG",  "NH",  "PTS"  
)

rushPlayCols <- c(
  basePlaysCols,
  "BC", "KNE", "DIR", "RTCK1", "RTCK2",
  "FUM", "FRCV", "FRY", "FORC", "SAF",
  "LT", "LG", "C", "RG", "RT"  
)

passPlayCols <- c(
  basePlaysCols,
  "PSR", "COMP", "SPK", "LOC", "TRG",
  "DFB", "PTCK1", "PTCK2", "SK1", "SK2",
  "INT", "IRY",
  "FUM", "FRCV", "FRY", "FORC", "SAF",
  "LT", "LG", "C", "RG", "RT"  
)

getRushPlays <- function()
{
  plays <- getRaw$plays()
  plays[ plays$TYPE=="RUSH", rushPlayCols ]
}

getPassPlays <- function()
{
  plays <- getRaw$plays()
  plays[ plays$TYPE=="PASS", passPlayCols ]
}

plot3downConvs <- function(rushPlays)
{
  fd <- na.omit(rushPlays[ rushPlays$DWN==3, "FD" ])  
  size <- length( fd )
  succ <- length( fd[ fd=='Y' ] )
  prob <- succ / size
  x <- seq(0, size)
  plot( x/size, dbinom(x, size, prob) )
}
