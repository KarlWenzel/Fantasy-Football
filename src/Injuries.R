x1 = join( GAME[,c("gid","seas","wk")], INJURY[,c("gid","player","gstat")], by="gid", type="inner")

x2 = ddply( x, .(player, seas), summarize, days.out = sum(gstat=="Out"), days.ques = sum(gstat=="Questionable" ))

x3 = ddply( PRB, .(player, seas), summarize, games = length(unique(gid)))

x4 = join( x3, x2, by=c("player", "seas") )
x4[ is.na(x4$days.out), ]$days.out = 0
x4[ is.na(x4$days.ques), ]$days.ques = 0

x5 = join( x4, PLAYER, by="player")
x5$age = x5$seas - x5$yob
x5$play.ratio = (x5$games - (x5$days.out + x5$days.ques)) / x5$games

lm1 = lm( formula = play.ratio ~ age, data = x5 )