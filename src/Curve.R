a = PRB[ PRB$wk <= 17, c("player", "seas", "gid", "yds") ]

b = ddply(a, .(player, seas), summarize, yds = sum(yds), games = length(unique(gid)) )

d = join( b, PLAYER[,c("player", "pos1", "yob", "start")], by="player", type="left", match="first")
d = d[ d$pos1=="RB", ]
d$year = d$seas - d$start + 1
d$age = d$seas - d$yob

first.year.players = d[ d$year==1, "player" ]
seven.year.players = d[ d$year==4, "player" ]

e = d[ d$player %in% first.year.players & d$player %in% seven.year.players, ]

f = ddply(e, .(player), summarize, max.yds = max(yds) )
f = f[ f$max.yds > 500, ]

g = join( e, f, by="player", type="inner")
g$norm.yds = g$yds / g$max.yds

#h = ddply(g, .(year), summarize, m.yds = mean(norm.yds) )

max.year = max(g$year)
player.df = unique( g[,c("player", "start")] )
h = data.frame( player=rep(player.df$player, max.year), start=rep(player.df$start, max.year), year=rep(1:max.year, nrow(player.df)))
h$drop = h$year + h$start <= 2016

i = join( h[,c("player","year","drop")], g, by=c("player","year"))
i[ is.na(i$norm.yds) & !(i$drop), ]$norm.yds = 0

j = ddply(i, .(year), summarize, m.yds = mean(norm.yds, na.rm=TRUE) )



