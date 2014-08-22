# Assumes init.R is sourced
# Assumes play <- getRaw$plays()

library(data.table)

run <- function(df.plays, df.games, df.players)
{
  dt.plays <- buildPlays(df.plays)  
  dt.games <- buildGames(df.games)
  dt.players <- buildPlayers(df.players)
  
  sdCols <- c("PassPlay","PassTD","PassYDS",
              "RecPlay","RecTD","RecYDS",
              "RushPlay", "RushTD","RushYDS", 
              "FFPTS")
  
  dt.gameSums <- dt.plays[, 
    lapply(.SD, sum), 
    .SDcols = sdCols, 
    by = c("PlayerID", "GameID") 
  ]
  
  setkey(dt.gameSums, "GameID")
  setkey(dt.games, "GameID")
  dt.gameSums <- dt.games[dt.gameSums]
  
  setkey(dt.gameSums, "PlayerID")
  setkey(dt.players, "PlayerID")
  dt.gameSums <- dt.players[dt.gameSums]
  
  dt.gameSums$GameCount = 1
  
  dt.yearSums <- dt.gameSums[, 
    lapply(.SD, sum), 
    .SDcols = c(sdCols, "GameCount"), 
    by = c("PlayerID", "Name", "Position", "Season")
  ]
  
  list("gameSums"=dt.gameSums, "yearSums"=dt.yearSums)
}

buildPlayers <- function(df.players)
{
  data.table(
    PlayerID = df.players$PLAYER,
    Name = paste( df.players$LNAME, df.players$FNAME, sep=", "),
    Position = df.players$POS1
  )
}

buildGames <- function(df.games)
{
  data.table(
    GameID = df.games$GID,
    Season = df.games$SEAS,
    Week = df.games$WEEK
  )
}

buildPlays <- function(df.plays)
{
  convData <- df.plays[ df.plays$TYPE=="CONV", 
                        c("PID", "GID", "BC", "PSR", "TRG", "SUCC") ]
  
  rushData <- df.plays[ df.plays$TYPE=="RUSH", 
                        c("PID", "GID", "BC", "FRCV", "YDS", "PTS") ]
  
  passCompData <- df.plays[ (df.plays$TYPE=="PASS") & (df.plays$COMP=="Y"), 
                            c("PID", "GID", "PSR", "TRG", "FRCV", "COMP", "YDS", "PTS")]
  
  passIncompData <- df.plays[ (df.plays$TYPE=="PASS") & (df.plays$COMP!="Y"), 
                              c("PID", "GID", "PSR", "TRG", "FRCV", "COMP", "YDS", "PTS")]
  
  df <- rbind(    
    data.frame(
      PlayID = rushData$PID,
      PlayerID = rushData$BC,
      GameID = rushData$GID,
      PassPlay = 0,
      PassTD = 0,
      PassYDS = 0,
      RecPlay = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 1,
      RushTD = as.numeric((!is.na(rushData$PTS)) & (rushData$PTS>= 6) & (rushData$FRCV=="")),
      RushYDS = rushData$YDS,
      TwoPts = 0,
      FumTD = 0
    ),    
    data.frame(
      PlayID = passCompData$PID,
      PlayerID = passCompData$PSR,
      GameID = passCompData$GID,
      PassPlay = 1,
      PassTD = as.numeric(
        (!is.na(passCompData$PTS)) & (passCompData$PTS>= 6) & (passCompData$FRCV=="")),
      PassYDS = passCompData$YDS,
      RecPlay = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = 0,
      TwoPts = 0,
      FumTD = 0
    ),    
    data.frame(
      PlayID = passIncompData$PID,
      PlayerID = passIncompData$PSR,
      GameID = passIncompData$GID,
      PassPlay = 1,
      PassTD = as.numeric(
        (!is.na(passIncompData$PTS)) & (passIncompData$PTS>= 6) & (passIncompData$FRCV=="")),
      PassYDS = 0,
      RecPlay = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = passIncompData$YDS,
      TwoPts = 0,
      FumTD = 0
    ),  
    data.frame(
      PlayID = passCompData$PID,
      PlayerID = passCompData$TRG,
      GameID = passCompData$GID,
      PassPlay = 0,
      PassTD = 0,
      PassYDS = 0,
      RecPlay = 1,
      RecTD = as.numeric(
        (!is.na(passCompData$PTS)) & (passCompData$PTS>= 6) & (passCompData$FRCV=="")),
      RecYDS = passCompData$YDS,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = 0,
      TwoPts = 0,
      FumTD = 0
    )
  )
  
  df$RushYDS[ is.na(df$RushYDS) ] <- 0
  
  df$FFPTS <- df$PassTD * 4 +
              df$PassYDS / 25 +
              (df$RecTD + df$RushTD) * 6 +
              (df$RecYDS + df$RushYDS) / 10;
  
  data.table(df)
}