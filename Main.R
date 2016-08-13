# User Parameters
# ---------------

# HOW TO RUN THIS PROGRAM
#
# First time: make sure dir.root is set to the root diretory of this project, and set first.time.run to TRUE
# Thereafter: if successfully run, much of the processing is saved in intermediary files, plus the original
#   data is still in memory (unless cleared by the user), so you can set the User Parameters as you like.
#
#

dir.root = "~/Fantasy-Football/"
first.time.run = FALSE

use.sample.data = TRUE
reload.raw = TRUE
rebuild.indexes = FALSE
reload.indexes = TRUE

# Notice that most of your user settings will be clobbered (appropriately) if first.time.run is TRUE
if (first.time.run) {
  use.sample.data = TRUE
  reload.raw = TRUE
  rebuild.indexes = TRUE
  reload.indexes = FALSE
}

# System Parameters
# -----------------

dir.raw.choice = "data/nfl_00-15/" 
if (use.sample.data) {
  dir.raw.choice = "data/nfl_sample_data_2015/"   
}
dir.raw = paste(dir.root, dir.raw.choice, "csv/", sep="")
dir.tidy = paste(dir.root, "data/tidy/", sep="")

# Preprocessing
# -------------

if (reload.raw) {
  source( paste(dir.root, "Load-Raw.R", sep=""))
  #BLOCK,CONV,DEFENSE,DRIVE,FGXP,FUMBLE,GAME,INJURY,INTERCPT,KICKER,KOFF,OFFENSE,OLINE,
  #PASS,PENALTY,PLAY,PLAYER,PUNT,REDZONE,RUSH,SACK,SAFETY,SCHEDULE,TACKLE,TD,TEAM
}

if (rebuild.indexes) {
  source( paste(dir.root, "Build-Indexes.R", sep=""))
  #GP
  #GRB -- Game results for RB index (pid,gid,off,def,olid,is.conv,dir,yds,succ,player,td,conv)
  #GQB
  #GWR
}

if (reload.indexes) {
  source( paste(dir.root, "Load-Indexes.R", sep=""))
  # Same result as rebuilding the indexes, except that loads from file rather than processing from raw
}

# Processing
# ----------

# GS = Game Summary

GRB.GS = ddply( GRB, .(player, gid), summarize, 
 sum.yds = sum(yds, na.rm=TRUE), 
 mean.yds = mean(yds, na.rm=TRUE), 
 sd.yds = sd(yds, na.rm=TRUE), 
 sum.tds = sum(td, na.rm=TRUE)
)
GRB.GS = join( GRB.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

GQB.GS = ddply( GQB, .(player, gid), summarize, 
 sum.yds = sum(yds, na.rm=TRUE), 
 mean.yds = mean(yds, na.rm=TRUE), 
 sd.yds = sd(yds, na.rm=TRUE), 
 sum.tds = sum(td, na.rm=TRUE)
)
GQB.GS = join( GQB.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

GWR.GS = ddply( GWR, .(player, gid), summarize, 
  sum.yds = sum(yds, na.rm=TRUE), 
  mean.yds = mean(yds, na.rm=TRUE), 
  sd.yds = sd(yds, na.rm=TRUE), 
  sum.tds = sum(td, na.rm=TRUE)
)
GWR.GS = join( GWR.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

# Reporting
# ---------



















