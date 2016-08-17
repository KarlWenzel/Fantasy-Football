

a = PRB[ PRB$wk <= 17, ]
a = ddply(a, .(player,seas), summarize, 
          sum.yds = sum(yds, na.rm=TRUE), 
          mean.yds = mean(yds, na.rm=TRUE), 
          sum.tds = sum(td, na.rm=TRUE))

b = data.frame( player=factor() )

for (s in 2001:2015) {

  a1 = a[ a$seas == (s-1) & a$sum.yds > 500, c("player", "sum.yds", "mean.yds", "sum.tds") ]
  a2 = a[ a$seas == s, c("player", "sum.yds", "mean.yds", "sum.tds") ]
  
  names(a1)[2] = "prev.yds"
  names(a1)[3] = "prev.m.yds"
  names(a1)[4] = "prev.tds"
  names(a2)[2] = "curr.yds"
  names(a2)[3] = "curr.m.yds"
  names(a2)[4] = "curr.tds"
  
  bx = join( a1, a2, by="player", type="inner")
  bx$seas = s
  
  b = rbind( b, bx)

}

b = join( b, PLAYER[,c("player", "height", "weight", "forty", "bench")], by="player", type="inner")

# good lm() docs: http://data.princeton.edu/R/linearModels.html
# http://www.montana.edu/screel/Webpages/conservation%20biology/Interpreting%20Regression%20Coefficients.html#/4

#c.y = lm( formula = curr.yds ~ prev.yds + height + weight + forty + bench, data = b)
c.y = lm( formula = curr.yds ~ prev.yds, data = b)

# how to interpret lm() results: 
#   http://stats.stackexchange.com/questions/5135/interpretation-of-rs-lm-output
#   http://stats.stackexchange.com/questions/59250/how-to-interpret-the-output-of-the-summary-method-for-an-lm-object-in-r

print( summary(c.y) )

# https://susanejohnston.wordpress.com/2012/08/09/a-quick-and-easy-function-to-plot-lm-results-in-r/

gg = ggplot(b, aes(x=prev.yds, y=curr.yds)) + geom_point() + stat_smooth(method="lm", col="red")
gg = gg + ggtitle("Current Year's Yards Over Previous Year's Yards (2001-2015)")
gg = gg + xlab("Prev Year's Total Rushing Yards by Player")
gg = gg + ylab("Current Year's Total Rushing Yards by Player")
plot(gg)
