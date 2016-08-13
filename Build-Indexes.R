library(plyr)

stopifnot (exists("dir.tidy"))
stopifnot( exists("PLAY") )
stopifnot( exists("RUSH") )
stopifnot( exists("PASS") )
stopifnot( exists("TD") )
stopifnot( exists("CONV") )

## GP is an index of PLAY (by Game), joined with TD 

GP = PLAY[ PLAY$type %in% c("RUSH", "PASS"), c("gid", "pid", "off", "def", "type", "conv.type", "olid") ]
GP = join( GP, TD[,c("pid","td")], by="pid", match="first")
GP[ is.na(GP$td), ]$td = 0

## GRB is an index of rushing plays, joined with RUSH

GRB = GP[ GP$type == "RUSH", c("gid", "pid", "off", "def", "olid", "td") ]
GRB$type = NULL
GRB = join( GRB, RUSH, by="pid", match="first")
GRB$player = GRB$bc
GRB$bc = NULL

## GQB and GWR and indexes of passing plays joined with PASS. both from the perspective of their respective positions

GQB = GP[ GP$type == "PASS", c("gid", "pid", "off", "def", "olid", "td") ]
GQB$type = NULL
GQB = join( GQB, PASS, by="pid", match="first")
GQB$player = GQB$psr
GQB$psr = NULL

GWR = GP[ GP$type == "PASS" , c("gid", "pid", "off", "def", "olid", "td") ]
GWR$type = NULL
GWR = join( GWR, PASS, by="pid", match="first")
GWR = GWR[!is.na(GWR$trg) & GWR$trg!="", ]
GWR$player = GWR$trg
GWR$trg = NULL

# only creates if doesnt' exists (but would show warning if it does, so surpress)
dir.create(dir.tidy, showWarnings=FALSE)

write.csv(GRB, paste(dir.tidy, "GP.csv", sep=""))
write.csv(GRB, paste(dir.tidy, "GRB.csv", sep=""))
write.csv(GQB, paste(dir.tidy, "GQB.csv", sep=""))
write.csv(GWR, paste(dir.tidy, "GWR.csv", sep=""))







