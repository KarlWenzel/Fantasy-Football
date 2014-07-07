library(data.table)

fRoot <- "./NFLData_2012_WK1-8/"

fPath <- list(
  plays   = paste(fRoot, "FLAT FILE.csv", sep=""),
  games   = paste(fRoot, "GAMES.csv", sep=""),
  players = paste(fRoot, "PLAYERS.csv", sep=""),
  teams   = paste(fRoot, "TEAM.csv", sep="")
)

getRaw <- list(
  plays   = function() read.csv(fPath$plays),
  games   = function() read.csv(fPath$games),
  players = function() read.csv(fPath$players),
  teams   = function() read.csv(fPath$teams)
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
  plays[ plays$TYPE=="RUSH" & plays$KNE!="Y", rushPlayCols ]
}

getPassPlays <- function()
{
  plays <- getRaw$plays()  
  plays[ plays$TYPE=="PASS" & plays$SPK!="Y", passPlayCols ]
}

plotTeamRushYPC <- function(rushPlays, games)
{
  p <- merge( rushPlays, games[, c("GID","SEAS")], by="GID" )
  p <- split( p, list( p$OFF, p$SEAS) )
  teamYPC <- sapply(p, function(x) mean( x[ !is.na(x$YDS), "YDS" ] ) )
  teamYPC <- sort(teamYPC)
  plotNormDist( teamYPC, min(teamYPC)-1, max(teamYPC)+1, "Yards per Carry", "YPC Distribution" )
}

plotNthDownConvs <- function(plays, down)
{
  size <- nrow( plays[ plays$DWN==down, ] )
  succ <- nrow( plays[ plays$DWN==down & plays$FD=="Y", ] )
  plotBinomLikelihood(size, succ, paste("Likelihood of Probability of First Down Occuring when Down =", down) )
}

plotNormDist <- function(values, minX, maxX, xLabel, plotTitle)
{  
  u <- mean(values)
  s <- sqrt( var(values) )
  domain <- seq(minX, maxX, length.out=1000)
  range <- dnorm(domain, u, s)
  
  plot(
    x = domain,
    y = range,
    type = "l",
    xlab = xLabel,
    ylab = "Density"
  )
  title(plotTitle)
  abline( v=u, col=3 )
}

plotBinomLikelihood <- function(size, successes, plotTitle="")
{  
  # Recall that likelihood is merely a relative measure (and unit-less).
  # The Maximum Likelihood Estimate may be used to scale the range into [0,1]  
  # Crank out a sequence of probability quantiles from [0,1] as the domain for our plot
  # and create a vector of their relative likelihoods
  
  mle <- successes / size
  domain <- seq(0, 1, length.out=1000)
  likeMax <- dbinom(successes, size, mle)
  likeRange <- (1/likeMax) * dbinom(successes, size, domain)  
  
  plot(
    x = domain,
    y = likeRange,
    type = "l",
    xlab = paste( "Probability (note MLE =", as.character(mle), ")"),
    ylab = "Normalized Likelihood"
  )
  title(plotTitle)
  abline( v=mle, col=3 )
}
