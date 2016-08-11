library(plyr)
library(sqldf)

dir.raw.choice = "nfl_sample_data_2015" 
#dir.raw.choice = "nfl_00-15" 

dir.root = "~/Fantasy-Football/data/"
dir.raw = paste(dir.root, dir.raw.choice, "/csv/", sep="")
dir.tidy = paste(dir.root, "/tidy/", sep="")

RAW = read.csv(paste(dir.raw, "PLAYER.csv", sep=""))
PLAYERS = data.frame(
  player.id = RAW$player,
  fname = RAW$fname,
  lname = RAW$lname,
  pos1 = RAW$pos1,
  pos2 = RAW$pos2,
  age.yrs = as.numeric(format(Sys.Date(), "%Y")) - RAW$yob,
  nfl.yrs = as.numeric(format(Sys.Date(), "%Y")) - RAW$start,
  cteam = RAW$cteam
)

RAW = read.csv(paste(dir.raw, "GAME.csv", sep=""))
GAMES = data.frame(
  game.id = RAW$gid,
  seas = RAW$seas,
  wk = RAW$wk,
  v = RAW$v,
  h = RAW$h,
  v.pts = RAW$ptsv,
  h.pts = RAW$ptsh
)

# NOTE that this frame stores the activty of team on a particular game
#RAW = read.csv(paste(dir.raw, "TEAM.csv", sep=""))
#GAME.TEAMS = data.frame(
#  game.id = RAW$gid,
#  tname = RAW$tname,
#  teamid = RAW$tid
#)

RAW = read.csv(paste(dir.raw, "PLAY.csv", sep=""))
PLAYS = data.frame(
    play.id = RAW$pid,
    game.id = RAW$gid,
    type = RAW$type
)

RAW = read.csv(paste(dir.raw, "PASS.csv", sep=""))
PASS = data.frame(
  play.id = RAW$pid,
  qb.id = RAW$psr,
  rec.id = RAW$trg,
  yds = RAW$yds,
  comp = RAW$comp,
  spk = RAW$spk
)
PASS = PASS[PASS$spk == 0,]
PASS$spk = NULL

RAW = read.csv(paste(dir.raw, "RUSH.csv", sep=""))
RUSH = data.frame(
  play.id = RAW$pid,
  player.id = RAW$bc,
  yds = RAW$yds,
  kne = RAW$kne
)
RUSH = RUSH[RUSH$kne == 0,]
RUSH$kne = NULL

RAW = read.csv(paste(dir.raw, "TD.csv", sep=""))
TDS = data.frame(
  play.id = RAW$pid,
  player.id = RAW$player,
  td = 1
)

# join and aggregate

RB.PLAYS = PLAYS[ PLAYS$type == "RUSH", ]
RB.PLAYS = join( RB.PLAYS, RUSH, by="play.id", match="first")
RB.PLAYS = merge( x=RB.PLAYS, y=TDS, by="play.id", all.x=TRUE)
RB.PLAYS$player.id = RB.PLAYS$player.id.x
RB.PLAYS$player.id.x = NULL
RB.PLAYS$player.id.y = NULL
RB.PLAYS[ is.na(RB.PLAYS$td),]$td = 0

RB.SUMMARY = ddply( RB.PLAYS, .(player.id, game.id), summarize, sum.yds = sum(yds), mean.yds = mean(yds), sd.yds = sd(yds), sum.tds = sum(td) )
RB.SUMMARY = join( RB.SUMMARY, PLAYERS, by="player.id", match="first")







