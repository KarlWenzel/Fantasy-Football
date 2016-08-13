
library(plyr)

stopifnot( exists("dir.raw") )

CONV = data.frame(
  read.csv(paste(dir.raw, "CONV.csv", sep="")) 
)

BLOCK = data.frame(
  read.csv(paste(dir.raw, "BLOCK.csv", sep=""))
)

CONV = data.frame(
  read.csv(paste(dir.raw, "CONV.csv", sep=""))
)

DEFENSE = data.frame(
  read.csv(paste(dir.raw, "DEFENSE.csv", sep=""))
)

DRIVE = data.frame(
  read.csv(paste(dir.raw, "DRIVE.csv", sep=""))
)

FGXP = data.frame(
  read.csv(paste(dir.raw, "FGXP.csv", sep=""))
)

FUMBLE = data.frame(
  read.csv(paste(dir.raw, "FUMBLE.csv", sep=""))
)

GAME = data.frame(
  read.csv(paste(dir.raw, "GAME.csv", sep=""))
)

INJURY = data.frame(
  read.csv(paste(dir.raw, "INJURY.csv", sep=""))
)

INTERCPT = data.frame(
  read.csv(paste(dir.raw, "INTERCPT.csv", sep=""))
)

KICKER = data.frame(
  read.csv(paste(dir.raw, "KICKER.csv", sep=""))
)

KOFF = data.frame(
  read.csv(paste(dir.raw, "KOFF.csv", sep=""))
)

OFFENSE = data.frame(
  read.csv(paste(dir.raw, "OFFENSE.csv", sep=""))
)

OLINE = data.frame(
  read.csv(paste(dir.raw, "OLINE.csv", sep=""))
)

PASS = data.frame(
  read.csv(paste(dir.raw, "PASS.csv", sep=""))
)
PASS = PASS[PASS$spk == 0,]
PASS$spk = NULL

PENALTY = data.frame(
  read.csv(paste(dir.raw, "PENALTY.csv", sep=""))
)

PLAY = data.frame(
  read.csv(paste(dir.raw, "PLAY.csv", sep=""))
)
names(CONV)[ names(CONV)=="type"] = "conv.type"
PLAY = join(PLAY, CONV[, c("pid", "conv.type")], by="pid", match="first")
levels(PLAY$conv.type)[ length(levels(PLAY$conv.type)) + 1] = "NONE"
PLAY[ is.na(PLAY$conv.type), ]$conv.type = "NONE"
names(CONV)[ names(CONV)=="conv.type"] = "type"

PLAYER = data.frame(
  read.csv(paste(dir.raw, "PLAYER.csv", sep=""))
)
PLAYER$age.yrs = as.numeric(format(Sys.Date(), "%Y")) - PLAYER$yob
PLAYER$nfl.yrs = as.numeric(format(Sys.Date(), "%Y")) - PLAYER$start

PUNT = data.frame(
  read.csv(paste(dir.raw, "PUNT.csv", sep=""))
)

REDZONE = data.frame(
  read.csv(paste(dir.raw, "REDZONE.csv", sep=""))
)

RUSH = data.frame(
  read.csv(paste(dir.raw, "RUSH.csv", sep=""))
)
RUSH = RUSH[RUSH$kne == 0,]
RUSH$kne = NULL

SACK = data.frame(
  read.csv(paste(dir.raw, "SACK.csv", sep=""))
)

SAFETY = data.frame(
  read.csv(paste(dir.raw, "SAFETY.csv", sep=""))
)

TACKLE = data.frame(
  read.csv(paste(dir.raw, "TACKLE.csv", sep=""))
)

TD = read.csv(paste(dir.raw, "TD.csv", sep=""))
TD = data.frame(
  pid = TD$pid,
  player = TD$player
)
TD$td = 1

TEAM = data.frame(
  read.csv(paste(dir.raw, "TEAM.csv", sep=""))
)








