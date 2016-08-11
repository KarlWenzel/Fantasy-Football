library(plyr)

dir.raw.choice = "nfl_sample_data_2015" 
#dir.raw.choice = "nfl_00-15" 

dir.root = "~/Fantasy-Football/data/"
dir.raw = paste(dir.root, dir.raw.choice, "/csv/", sep="")
dir.tidy = paste(dir.root, "/tidy/", sep="")

PLAYERS = data.frame( 
  read.csv(paste(dir.raw, "PLAYER.csv", sep="")) 
)
PLAYERS$age.yrs = as.numeric(format(Sys.Date(), "%Y")) - PLAYERS$yob
PLAYERS$nfl.yrs = as.numeric(format(Sys.Date(), "%Y")) - PLAYERS$start

GAMES = data.frame(
  read.csv(paste(dir.raw, "GAME.csv", sep=""))
)

GAME.TEAMS = data.frame(
  read.csv(paste(dir.raw, "TEAM.csv", sep=""))
)

PLAYS = data.frame(
  read.csv(paste(dir.raw, "PLAY.csv", sep=""))
)

PASS = data.frame(
  read.csv(paste(dir.raw, "PASS.csv", sep=""))
)
PASS = PASS[PASS$spk == 0,]
PASS$spk = NULL

RUSH = data.frame(
  read.csv(paste(dir.raw, "RUSH.csv", sep=""))
)
RUSH = RUSH[RUSH$kne == 0,]
RUSH$kne = NULL

TDS = read.csv(paste(dir.raw, "TD.csv", sep=""))
TDS = data.frame(
  pid = TDS$pid,
  player = TDS$player
)
TDS$td = 1

# join and aggregate

RB.PLAYS = PLAYS[ PLAYS$type == "RUSH", ]
RB.PLAYS = join( RB.PLAYS, RUSH, by="pid", match="first")
RB.PLAYS = merge( x=RB.PLAYS, y=TDS, by="pid", all.x=TRUE)
RB.PLAYS$pid = RB.PLAYS$pid.x
RB.PLAYS$pid.x = NULL
RB.PLAYS$pid.y = NULL
RB.PLAYS[ is.na(RB.PLAYS$td),]$td = 0

RB.SUMMARY = ddply( RB.PLAYS, .(player, gid), summarize, sum.yds = sum(yds), mean.yds = mean(yds), sd.yds = sd(yds), sum.tds = sum(td) )
RB.SUMMARY = join( RB.SUMMARY, PLAYERS, by="player", match="first")







