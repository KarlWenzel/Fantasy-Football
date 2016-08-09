library(plyr)

dataDirectory = "~/Fantasy-Football/data/nfl_sample_data_2015/csv/"

RAW = read.csv(paste(dataDirectory, "PLAYER.csv", sep=""))
PLAYERS = data.frame(
  playerid = RAW$player,
  fname = RAW$fname,
  lname = RAW$lname,
  pos1 = RAW$pos1,
  pos2 = RAW$pos2,
  age = as.numeric(format(Sys.Date(), "%Y")) - RAW$yob,
  nflYrs = as.numeric(format(Sys.Date(), "%Y")) - RAW$start,
  cteam = RAW$cteam
)

RAW = read.csv(paste(dataDirectory, "GAME.csv", sep=""))
GAMES = data.frame(
  gameid = RAW$gid,
  seas = RAW$seas,
  wk = RAW$wk,
  v = RAW$v,
  h = RAW$h,
  vpts = RAW$ptsv,
  hpts = RAW$ptsh
)

# NOTE that this frame stores the activty of team on a particular game
#RAW = read.csv(paste(dataDirectory, "TEAM.csv", sep=""))
#GAME_TEAMS = data.frame(
#  gameid = RAW$gid,
#  tname = RAW$tname,
#  teamid = RAW$tid
#)

RAW = read.csv(paste(dataDirectory, "PLAY.csv", sep=""))
PLAYS = data.frame(
    playid = RAW$pid,
    gameid = RAW$gid,
    type = RAW$type
)

RAW = read.csv(paste(dataDirectory, "RUSH.csv", sep=""))
RUSHES = data.frame(
  playid = RAW$pid,
  playerid = RAW$bc,
  yds = RAW$yds,
  kne = RAW$kne
)
RUSHES = RUSHES[RUSHES$kne == 0,]
RUSHES$kne = NULL

RUSH_PLAYS = PLAYS[ PLAYS$type == "RUSH", ]
RUSH_PLAYS = join( RUSH_PLAYS, RUSHES, by="playid", type="left", match="first")








