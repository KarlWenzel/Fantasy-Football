---
title: "Age vs Injury"
author: "Karl Wenzel"
date: "August 22, 2016"
output: html_document
---



Investigate how age affects injury rates.

### Running Backs

Since I don't have good records on injury status, I will naively count the number of games played by each player per year.
(Note that my data set does include injury status, but only for 2015, so I can't use it to do year-to-year analysis.)


```r
library(plyr)
GAME = data.frame(read.csv("C:/Users/karl/Documents/Fantasy-Football/data/nfl_00-15/csv//GAME.csv"))
PLAYER = data.frame(read.csv("C:/Users/karl/Documents/Fantasy-Football/data/nfl_00-15/csv//PLAYER.csv"))
PRB = data.frame(read.csv("C:/Users/karl/Documents/Fantasy-Football/data/tidy/full/PRB.csv"))

a = ddply( PRB, .(player, seas), summarize, games = length(unique(gid)))

b = data.frame(player = factor())

for (s in 2001:2015) {
  
  a1 = a[ a$seas == (s-1), c("player", "games")]
  a2 = a[ a$seas == s, c("player", "games") ]  
  
  names(a1)[2] = "prev.games"
  names(a2)[2] = "curr.games"
  
  bx = join( a1, a2, by="player", type="inner")
  bx$seas = s  
  b = rbind( b, bx)
}

x = join( b, PLAYER, by="player")
x$age = x$seas - x$yob

lm0 = lm( formula = curr.games ~ age, data = x)
lm1 = lm( formula = curr.games ~ prev.games, data = x )
lm2 = lm( formula = curr.games ~ prev.games + age, data = x )

lm0.percent = round(summary(lm0)$r.squared * 100, digits=2)
lm1.percent = round(summary(lm1)$r.squared * 100, digits=2)
lm2.percent = round(summary(lm2)$r.squared * 100, digits=2)
```
#### Results

- 0.59 % of variance games played per season explained by player's age
- 41.6 % of variance games played per season explained by previous year's games played
- 42.23 % of variance games played per season explained by previous year's games played AND player age

Wow.. So basically < 1% improvement to our model by accounting for age.  This finding matches what the stat guys determined at [rotoworld](http://www.rotoworld.com/articles/nfl/55671/81/the-injury-age-misconception).
