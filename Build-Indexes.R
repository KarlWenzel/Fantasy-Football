
library(plyr)

stopifnot (exists("dir.tidy"))
stopifnot( exists("PLAY") )
stopifnot( exists("RUSH") )
stopifnot( exists("PASS") )
stopifnot( exists("TD") )
stopifnot( exists("CONV") )

## PX is an index of rushing and passing PLAY records (pid, and gid), joined with TD and TEAM (get both offense and defense)

PX = PLAY[ PLAY$type %in% c("RUSH", "PASS"), c("gid", "pid", "off", "def", "type", "conv.type", "olid") ]

PX = join( PX, TD[,c("pid","td")], by="pid", match="first")
PX[ is.na(PX$td), ]$td = 0

names(TEAM)[ names(TEAM)=="tname"] = "off"
names(TEAM)[ names(TEAM)=="tid"] = "off.tid"
PX = join( PX, TEAM[,c("off.tid", "gid", "off")], by=c("gid", "off"), match="first" )

names(TEAM)[ names(TEAM)=="off"] = "def"
names(TEAM)[ names(TEAM)=="off.tid"] = "def.tid"
PX = join( PX, TEAM[,c("def.tid", "gid", "def")], by=c("gid", "def"), match="first" )

names(TEAM)[ names(TEAM)=="def"] = "tname"
names(TEAM)[ names(TEAM)=="def.tid"] = "tid"

## PRB is an index of rushing plays, joined with RUSH

PRB = PX[ PX$type == "RUSH", c("gid", "pid", "off", "off.tid", "def", "def.tid", "olid", "td") ]
PRB$type = NULL
PRB = join( PRB, RUSH, by="pid", match="first")
PRB$player = PRB$bc
PRB$bc = NULL

# PQB and PWR and indexes of passing plays joined with PASS. both from the perspective of their respective positions

PQB = PX[ PX$type == "PASS", c("gid", "pid", "off", "off.tid", "def", "def.tid", "olid", "td") ]
PQB$type = NULL
PQB = join( PQB, PASS, by="pid", match="first")
PQB$player = PQB$psr
PQB$psr = NULL

PWR = PX[ PX$type == "PASS" , c("gid", "pid", "off", "off.tid", "def", "def.tid", "olid", "td") ]
PWR$type = NULL
PWR = join( PWR, PASS, by="pid", match="first")
PWR = PWR[!is.na(PWR$trg) & PWR$trg!="", ]
PWR$player = PWR$trg
PWR$trg = NULL

# POL is an index for each offensive lineman's rush and pass plays

OLT = OLINE[, c("olid", "lt")]
names(OLT)[2] = "player"
OLT$lpos = "lt"

OLG = OLINE[, c("olid", "lg")]
names(OLG)[2] = "player"
OLG$lpos = "lg"

OC = OLINE[, c("olid", "c")]
names(OC)[2] = "player"
OC$lpos = "c"

ORG = OLINE[, c("olid", "rg")]
names(ORG)[2] = "player"
ORG$lpos = "rg"

ORT = OLINE[, c("olid", "rt")]
names(ORT)[2] = "player"
ORT$lpos = "rt"

POL = rbind(OLT, OLG, OC, ORG, ORT)
remove(OLT)
remove(OLG)
remove(OC)
remove(ORG)
remove(ORT)

POL = join( PX, POL, by="olid", match="all")

# only creates tidy directory if does not exist (but would show warning if it does exist, so surpress)

dir.create(dir.tidy, showWarnings=FALSE)

write.csv(PX, paste(dir.tidy, "PX.csv", sep=""))
write.csv(PRB, paste(dir.tidy, "PRB.csv", sep=""))
write.csv(PQB, paste(dir.tidy, "PQB.csv", sep=""))
write.csv(PWR, paste(dir.tidy, "PWR.csv", sep=""))
write.csv(POL, paste(dir.tidy, "POL.csv", sep=""))







