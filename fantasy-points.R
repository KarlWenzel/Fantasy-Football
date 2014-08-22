# Assumes init.R is sourced
#
# Assumes df.play <- getRaw$plays()
#         df.games <- getRaw$games()
#         df.players <- getRaw$players()

library(data.table)

run <- function(df.plays, df.games, df.players)
{
  dt.plays <- buildPlays(df.plays)  
  dt.games <- buildGames(df.games)
  dt.players <- buildPlayers(df.players)
  
  sdCols <- c("PassPlay","PassComp", "PassTD","PassYDS",
              "RecPlay","RecComp", "RecTD","RecYDS",
              "RushPlay", "RushTD","RushYDS", 
              "TwoPts", "FumTD", "FFPTS")
  
  dt.gameSums <- dt.plays[, 
    lapply(.SD, sum), 
    .SDcols = sdCols, 
    by = c("PlayerID", "GameID") 
  ]
  
  setkey(dt.gameSums, "GameID")
  setkey(dt.games, "GameID")  
  dt.gameSums <- dt.games[dt.gameSums] #dt.games provides (Season, Week)  
  
  setkey(dt.gameSums, "PlayerID")
  setkey(dt.players, "PlayerID")  
  dt.gameSums <- dt.players[dt.gameSums] #dt.players provides (Name, Position)
  
  dt.gameSums$GameCount = 1
  
  dt.yearSums <- dt.gameSums[, 
    lapply(.SD, sum), 
    .SDcols = c(sdCols, "GameCount"), 
    by = c("PlayerID", "Name", "Position", "Season")
  ]
  
  write.csv(dt.gameSums, file="./data/GameSums.csv")
  write.csv(dt.yearSums, file="./data/YearSums.csv")
  
  list("gameSums"=dt.gameSums, "yearSums"=dt.yearSums)
}

buildBestPlayers <- function(dt.yearSums, season)
{
  dt.topQBs <- build_X_best_Y_pos(dt.yearSums, 25, "QB", season)
  dt.topRBs <- build_X_best_Y_pos(dt.yearSums, 50, "RB", season)
  dt.topWRs <- build_X_best_Y_pos(dt.yearSums, 50, "WR", season)
  dt.topTEs <- build_X_best_Y_pos(dt.yearSums, 25, "TE", season)
  
  list(dt.topQBs, dt.topRBs, dt.topWRs, dt.topTEs)
}

build_X_best_Y_pos <- function(dt.gameSums, dt.yearSums, topX, positionY, season)
{
  q <- (dt.yearSums$Position == positionY) & 
       (dt.yearSums$Season == season) & 
       (!is.na(dt.yearSums$FFPTS)) 
  
  dt.best <- dt.yearSums[ q, list(PlayerID, FFPTS)]  
  dt.best <- dt.best[ order(-FFPTS) ]
  dt.best <- dt.best[ 1:topX ,]
  
  setkey(dt.best, "PlayerID")
  setkey(dt.yearSums, "PlayerID")
  dt.best <- dt.yearSums[ dt.best, ]
  
  setkey(dt.gameSums, "PlayerID")
  dt.bestGames <- dt.gameSums[ dt.best, ]
  dt.bestVar <- dt.bestGames[, list(varFFPTS = var(FFPTS), avgFFPTS = mean(FFPTS)), by=PlayerID ]
  
  setkey(dt.bestVar, "PlayerID")
  dt.best[ dt.bestVar, ]
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
  df.2conv <- df.plays[ df.plays$TYPE=="CONV",]  
  df.rush <- df.plays[ df.plays$TYPE=="RUSH",]  
  df.goodPass <- df.plays[ (df.plays$TYPE=="PASS") & (df.plays$COMP=="Y") ,]  
  df.badPass <- df.plays[ (df.plays$TYPE=="PASS") & (df.plays$COMP!="Y") ,]
  
  df <- rbind(    
    # Rusher
    data.frame(
      PlayID = df.rush$PID,
      PlayerID = df.rush$BC,
      GameID = df.rush$GID,
      PassPlay = 0,
      PassComp = 0,
      PassTD = 0,
      PassYDS = 0,
      RecPlay = 0,
      RecComp = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 1,
      RushTD = as.numeric(
        (!is.na(df.rush$PTS)) & (df.rush$PTS>= 6) & (df.rush$FRCV=="")),
      RushYDS = df.rush$YDS,
      TwoPts = 0,
      FumTD = 0
    ),
    # Passer (Completed Pass Plays)
    data.frame(
      PlayID = df.goodPass$PID,
      PlayerID = df.goodPass$PSR,
      GameID = df.goodPass$GID,
      PassPlay = 1,
      PassComp = 1,
      PassTD = as.numeric(
        (!is.na(df.goodPass$PTS)) & (df.goodPass$PTS>= 6) & (df.goodPass$FRCV=="")),
      PassYDS = df.goodPass$YDS,
      RecPlay = 0,
      RecComp = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = 0,
      TwoPts = 0,
      FumTD = 0
    ),    
    # Passer (Incomplete Pass Plays)
    data.frame(
      PlayID = df.badPass$PID,
      PlayerID = df.badPass$PSR,
      GameID = df.badPass$GID,
      PassPlay = 1,
      PassComp = 0,
      PassTD = as.numeric(
        (!is.na(df.badPass$PTS)) & (df.badPass$PTS>= 6) & (df.badPass$FRCV=="")),
      PassYDS = 0,
      RecPlay = 0,
      RecComp = 0,
      RecTD = 0,
      RecYDS = 0,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = 0, # NFL stats rules for sack yardage (see http://en.wikipedia.org/wiki/Quarterback_sack)
      TwoPts = 0,
      FumTD = 0
    ),  
    # Wide Receiver (Completed Pass Plays)
    data.frame(
      PlayID = df.goodPass$PID,
      PlayerID = df.goodPass$TRG,
      GameID = df.goodPass$GID,
      PassPlay = 0,
      PassComp = 0,
      PassTD = 0,
      PassYDS = 0,
      RecPlay = 1,
      RecComp = 1,
      RecTD = as.numeric(
        (!is.na(df.goodPass$PTS)) & (df.goodPass$PTS>= 6) & (df.goodPass$FRCV=="")),
      RecYDS = df.goodPass$YDS,
      RushPlay = 0,
      RushTD = 0,
      RushYDS = 0,
      TwoPts = 0,
      FumTD = 0
    ), 
    # Wide Receiver (Incomplete Pass Plays)
    data.frame(
      PlayID = df.badPass$PID,
      PlayerID = df.badPass$TRG,
      GameID = df.badPass$GID,
      PassPlay = 0,
      PassComp = 0,
      PassTD = 0,
      PassYDS = 0,
      RecPlay = 1,
      RecComp = 0,
      RecTD = as.numeric(
        (!is.na(df.badPass$PTS)) & (df.badPass$PTS>= 6) & (df.badPass$FRCV=="")),
      RecYDS = df.badPass$YDS,
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
  
  data.table( df[ df$PlayerID != "", ] )
}