---
title: "Age Production Curve"
author: "Karl Wenzel"
date: "August 18, 2016"
output: html_document
---



Investigate how age affects performance.

### Running Backs


```r
library(plyr)
PLAYER = data.frame(read.csv("C:/Users/karl/Documents/Fantasy-Football/data/nfl_00-15/csv//PLAYER.csv"))
PRB = data.frame(read.csv("C:/Users/karl/Documents/Fantasy-Football/data/tidy/full/PRB.csv"))
a = PRB[ PRB$wk <= 17, c("player", "seas", "gid", "yds") ]

b = ddply(a, .(player, seas), summarize, yds = sum(yds), games = length(unique(gid) )) 
b = join( b, PLAYER[,c("player", "yob")], by="player")
b$age = b$seas - b$yob

x = ddply( b[b$yds>100,], .(age), summarize, yds = mean(yds))
plot(x)
title(main="Average RB Yards Per Season By Age (Min 100 yards)")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

### Wide Receivers

This one seems fishy.  Needs more investigation.

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

### Quarterbacks

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


