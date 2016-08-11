# User Parameters
# ---------------

dir.root = "~/Fantasy-Football/"
reloadRaw = TRUE


# System Parameters
# -----------------

dir.raw.choice = "data/nfl_00-15" 
if (reloadRaw) {
  dir.raw.choice = "data/nfl_sample_data_2015"   
}
dir.raw = paste(dir.root, dir.raw.choice, "/csv/", sep="")
dir.tidy = paste(dir.root, "/tidy/", sep="")

# Preprocessing
# -------------

if (reloadRaw) {
  source( paste(dir.root, "Load-Raw.R", sep=""))
  #BLOCK,CONV,DEFENSE,DRIVE,FGXP,FUMBLE,GAME,INJURY,INTERCPT,KICKER,KOFF,OFFENSE,OLINE,
  #PASS,PENALTY,PLAY,PLAYER,PUNT,REDZONE,RUSH,SACK,SAFETY,SCHEDULE,TACKLE,TD,TEAM
}

RB.PLAY = PLAY[ PLAY$type == "RUSH", ]
RB.PLAY = join( RB.PLAY, RUSH, by="pid", match="first")
RB.PLAY$player = RB.PLAY$bc
RB.PLAY$bc = NULL

RB.PLAY = join( x=RB.PLAY, y=TD[,c("pid","td")], by="pid", match="first")
RB.PLAY[ is.na(RB.PLAY$td), ]$td = 0

RB.PLAY = join( x=RB.PLAY, y=CONV[CONV$type=="RUSH", c("pid", "conv")], by="pid", match="first")
RB.PLAY[ is.na(RB.PLAY$conv), ]$conv = 0

RB.SUMMARY = ddply( RB.PLAY, .(player, gid), summarize, 
  sum.yds = sum(yds), 
  mean.yds = mean(yds), 
  sd.yds = sd(yds), 
  sum.tds = sum(td),
  sum.convs = sum(conv)
)
RB.SUMMARY = join( PLAYER, RB.SUMMARY, by="player", match="first")


# Processing
# ----------

# Reporting
# ---------



















