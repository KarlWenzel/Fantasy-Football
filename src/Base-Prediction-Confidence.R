

a = PRB[ PRB$wk <= 17, ]
a = ddply(a, .(player,seas), summarize, sum.yds = sum(yds, na.rm=TRUE), sum.tds = sum(td, na.rm=TRUE))
#a = a[ a$sum.yds > 200, ]

b = data.frame( player=factor(), y1=integer(), t1=integer(), y2=integer(), t2=integer() )

for (s in 2001:2015) {

  a1 = a[ a$seas == (s-1), c("player", "sum.yds", "sum.tds") ]
  a2 = a[ a$seas == s,     c("player", "sum.yds", "sum.tds") ]
  
  names(a1)[2] = "y1"
  names(a1)[3] = "t1"
  names(a2)[2] = "y2"
  names(a2)[3] = "t2"
  
  bx = join( a1, a2, by="player", type="inner")
  b = rbind( b, bx)

}

c.y = lm( y1 ~ y2, data=b)
c.t = lm( t1 ~ t2, data=b)

# how to interpreti lm() results: 
#   http://stats.stackexchange.com/questions/5135/interpretation-of-rs-lm-output
#   http://stats.stackexchange.com/questions/59250/how-to-interpret-the-output-of-the-summary-method-for-an-lm-object-in-r

print( summary(c.y) )
#print( summary(c.t) )

