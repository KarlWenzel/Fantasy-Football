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

getRushPlays <- function()
{
  plays <- getRaw$plays()
  splitPlays <- split( plays, plays$TYPE ) # { CONV|FGXP|KOFF|NOPL|ONSD|PASS|PUNT|RUSH }
  rushPlays <- splitPlays$RUSH
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
