
# HOW TO RUN THIS PROGRAM
# -----------------------
#
# First time: 
#   - make sure dir.root is set to the root diretory of this project
#   - set first.time.run to TRUE
#   - unless you feel lucky, you should probably set use.sample.data=TRUE also (full data takes minutes to run)
#
# Thereafter: if successfully run, much of the processing is saved in intermediary files, plus the original
#   data is still in memory (unless cleared by the user), so you can set the User Parameters as you like.
#

# User Parameters
# ---------------

dir.root = "~/Fantasy-Football/"
first.time.run = FALSE

use.sample.data = FALSE
load.raw = FALSE
build.indexes = FALSE
load.indexes = TRUE

# Notice below that most of your user settings will be clobbered (appropriately) if first.time.run is TRUE

if (first.time.run) {
  load.raw = TRUE
  build.indexes = TRUE
  load.indexes = FALSE
}

# System Parameters
# -----------------

# Only change these if necessary.  These values make assumption about the raw data file structure.

dir.src = paste(dir.root, "src/", sep="")

dir.raw.choice = "data/nfl_00-15/" 
if (use.sample.data) {
  dir.raw.choice = "data/nfl_sample_data_2015/"   
}
dir.raw = paste(dir.root, dir.raw.choice, "csv/", sep="")

dir.tidy = paste(dir.root, "data/tidy/full/", sep="")
if (use.sample.data) {  
  dir.tidy = paste(dir.root, "data/tidy/sample/", sep="")
}

# Preprocessing
# -------------

total.start.time = proc.time()

# This step will load a bunch of global variable into memory.

if (load.raw) {
  # Loads the following raw data object with a few additional processing steps:
  # -------
  # BLOCK,CONV,DEFENSE,DRIVE,FGXP,FUMBLE,GAME,INJURY,INTERCPT,KICKER,KOFF,OFFENSE,OLINE,
  # PASS,PENALTY,PLAY,PLAYER,PUNT,REDZONE,RUSH,SACK,SAFETY,SCHEDULE,TACKLE,TD,TEAM
  
  print("Loading raw data...")
  start.time = proc.time()
  source( paste(dir.src, "Load-Raw.R", sep=""))
  end.time = proc.time() - start.time
  print( paste("  ...Done. Run time:", end.time["elapsed"], "seconds"))
  
}

if (build.indexes) {
  # Builds and saves some indexes that join together some key data
  # ----
  # PX, PRB, PQB, PWR, POL
  print("Buiding indexes...")
  start.time = proc.time()
  source( paste(dir.src, "Build-Indexes.R", sep=""))
  end.time = proc.time() - start.time
  print( paste("  ...Done. Run time:", end.time["elapsed"], "seconds"))
}

if (load.indexes) {
  # Same result as rebuilding the indexes, except that loads from file rather than processing from raw
  print("Loading indexes...")
  start.time = proc.time()
  source( paste(dir.src, "Load-Indexes.R", sep=""))
  end.time = proc.time() - start.time
  print( paste("  ...Done. Run time:", end.time["elapsed"], "seconds"))
}

# Processing
# ----------

print("Processing...")
start.time = proc.time()

# GS = Game Summary

PRB.GS = ddply( PRB, .(player, gid), summarize, 
 sum.yds = sum(yds, na.rm=TRUE), 
 mean.yds = mean(yds, na.rm=TRUE), 
 sd.yds = sd(yds, na.rm=TRUE), 
 sum.tds = sum(td, na.rm=TRUE)
)
PRB.GS = join( PRB.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

PQB.GS = ddply( PQB, .(player, gid), summarize, 
 sum.yds = sum(yds, na.rm=TRUE), 
 mean.yds = mean(yds, na.rm=TRUE), 
 sd.yds = sd(yds, na.rm=TRUE), 
 sum.tds = sum(td, na.rm=TRUE)
)
PQB.GS = join( PQB.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

PWR.GS = ddply( PWR, .(player, gid), summarize, 
  sum.yds = sum(yds, na.rm=TRUE), 
  mean.yds = mean(yds, na.rm=TRUE), 
  sd.yds = sd(yds, na.rm=TRUE), 
  sum.tds = sum(td, na.rm=TRUE)
)
PWR.GS = join( PWR.GS, PLAYER[,c("player","pname","pos1","cteam")], by="player", type="left", match="first")

end.time = proc.time() - start.time
print( paste("  ...Done. Run time:", end.time["elapsed"], "seconds"))

# Reporting
# ---------

total.end.time = proc.time() - total.start.time
print( paste(" Total run time:", total.end.time["elapsed"], "seconds"))


















