
CREATE TABLE block (
  pid int NOT NULL PRIMARY KEY,
  blk varchar(7) NOT NULL,
  brcv varchar(7) DEFAULT NULL
) 

CREATE TABLE chart (
  pid int NOT NULL PRIMARY KEY,
  rb tinyint NOT NULL,
  te tinyint NOT NULL,
  drp tinyint NOT NULL,
  mbt tinyint NOT NULL,
  yac int NOT NULL
  --,yaco int NOT NULL,
  --scrn tinyint NOT NULL,
  --bdef int NOT NULL,
  --press tinyint NOT NULL,
  --qbh tinyint NOT NULL,
  --qbfl tinyint NOT NULL,
  --qbta tinyint NOT NULL
) 

CREATE TABLE conv (
  pid int NOT NULL PRIMARY KEY,
  [type] varchar(4) NOT NULL,
  bc varchar(7) DEFAULT NULL,
  psr varchar(7) DEFAULT NULL,
  trg varchar(7) DEFAULT NULL,
  conv tinyint NOT NULL
)

CREATE TABLE defense (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  player varchar(7) NOT NULL,
  solo decimal(3,1) NOT NULL,
  comb decimal(3,1) NOT NULL,
  sck decimal(2,1) NOT NULL,
  saf tinyint NOT NULL,
  blk tinyint NOT NULL,
  ints tinyint NOT NULL,
  pdef tinyint NOT NULL,
  frcv tinyint NOT NULL,
  forc tinyint NOT NULL,
  tdd tinyint NOT NULL,
  rety int NOT NULL,
  tdret tinyint NOT NULL,
  peny tinyint NOT NULL,
  snp tinyint NOT NULL,
  fp decimal(4,2) NOT NULL,
  fp2 decimal(4,2) NOT NULL,
  game tinyint NOT NULL,
  seas tinyint NOT NULL,
  [year] int NOT NULL,
  team varchar(3) NOT NULL,
  posd varchar(8) NOT NULL,
  jnum tinyint NOT NULL,
  dcp tinyint NOT NULL,
  INDEX IX_defense_gid NONCLUSTERED(gid),
  INDEX IX_defense_player NONCLUSTERED(player)
)

CREATE TABLE drive (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  fpid int NOT NULL,
  tname varchar(3) NOT NULL,
  drvn tinyint NOT NULL,
  obt varchar(4) DEFAULT NULL,
  qtr tinyint NOT NULL,
  [min] tinyint NOT NULL,
  sec tinyint NOT NULL,
  yfog tinyint NOT NULL,
  plays tinyint NOT NULL,
  succ tinyint NOT NULL,
  rfd tinyint NOT NULL,
  pfd tinyint NOT NULL,
  ofd tinyint NOT NULL,
  ry int NOT NULL,
  ra tinyint NOT NULL,
  py int NOT NULL,
  pa tinyint NOT NULL,
  pc tinyint NOT NULL,
  peyf tinyint NOT NULL,
  peya tinyint NOT NULL,
  net int NOT NULL,
  res varchar(4) DEFAULT NULL,
  INDEX IX_drive_gid NONCLUSTERED(gid),
  INDEX IX_drive_fpid NONCLUSTERED(fpid),
  INDEX IX_drive_tname NONCLUSTERED(tname)
)

CREATE TABLE fgxp (
  pid int NOT NULL PRIMARY KEY,
  fgxp varchar(2) NOT NULL,
  fkicker varchar(7) NOT NULL,
  dist tinyint NOT NULL,
  good tinyint NOT NULL,
  INDEX IX_fgxp_fgxp NONCLUSTERED(fgxp)
)

CREATE TABLE fumble (
  pid int NOT NULL PRIMARY KEY,
  fum varchar(7) NOT NULL,
  frcv varchar(7) DEFAULT NULL,
  fry int NOT NULL,
  forc varchar(7) DEFAULT NULL,
  INDEX IX_fumber_fum NONCLUSTERED(fum)
)

CREATE TABLE game (
  gid int NOT NULL PRIMARY KEY,
  seas int NOT NULL,
  wk tinyint NOT NULL,
  [day] varchar(3) NOT NULL,
  v varchar(3) NOT NULL,
  h varchar(3) NOT NULL,
  stad varchar(45) NOT NULL,
  temp varchar(4) DEFAULT NULL,
  humd varchar(4) DEFAULT NULL,
  wspd varchar(4) DEFAULT NULL,
  wdir varchar(4) DEFAULT NULL,
  cond varchar(15) DEFAULT NULL,
  surf varchar(30) NOT NULL,
  ou decimal(3,1) NOT NULL,
  sprv decimal(3,1) NOT NULL,
  ptsv tinyint NOT NULL,
  ptsh tinyint NOT NULL,
  INDEX IX_game_seas NONCLUSTERED(seas)
)

CREATE TABLE injury (
  gid int NOT NULL,
  player varchar(7) NOT NULL,
  team varchar(3) NOT NULL,
  details varchar(25) DEFAULT NULL,
  pstat varchar(35) DEFAULT NULL,
  gstat varchar(255) DEFAULT NULL
)

CREATE TABLE intercpt (
  pid int NOT NULL PRIMARY KEY,
  psr varchar(7) NOT NULL,
  ints varchar(7) NOT NULL,
  iry tinyint NOT NULL,
  INDEX IX_intercpt_psr NONCLUSTERED(psr),
  INDEX IX_intercpt_ints NONCLUSTERED(ints)
)

CREATE TABLE kicker (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  player varchar(7) NOT NULL,
  pat tinyint NOT NULL,
  fgs tinyint NOT NULL,
  fgm tinyint NOT NULL,
  fgl tinyint NOT NULL,
  fp decimal(3,1) NOT NULL,
  game tinyint NOT NULL,
  seas tinyint NOT NULL,
  [year] int NOT NULL,
  team varchar(3) NOT NULL,
  INDEX IX_kicker_gid NONCLUSTERED(gid),
  INDEX IX_kicker_player NONCLUSTERED(player)
)

CREATE TABLE koff (
  pid int NOT NULL PRIMARY KEY,
  kicker varchar(7) NOT NULL,
  kgro tinyint NOT NULL,
  knet tinyint NOT NULL,
  ktb tinyint NOT NULL,
  kr varchar(7) DEFAULT NULL,
  kry tinyint NOT NULL,
  INDEX IX_kicker NONCLUSTERED(kicker)
)

CREATE TABLE offense (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  player varchar(7) NOT NULL,
  pa tinyint NOT NULL,
  pc tinyint NOT NULL,
  py int NOT NULL,
  ints tinyint NOT NULL,
  tdp tinyint NOT NULL,
  ra tinyint NOT NULL,
  sra tinyint NOT NULL,
  ry int NOT NULL,
  tdr tinyint NOT NULL,
  trg tinyint NOT NULL,
  rec tinyint NOT NULL,
  recy int NOT NULL,
  tdrec tinyint NOT NULL,
  ret tinyint NOT NULL,
  rety int NOT NULL,
  tdret tinyint NOT NULL,
  fuml tinyint NOT NULL,
  peny tinyint NOT NULL,
  conv tinyint NOT NULL,
  snp tinyint NOT NULL,
  fp decimal(4,2) NOT NULL,
  fp2 decimal(4,2) NOT NULL,
  fp3 decimal(4,2) NOT NULL,
  game tinyint NOT NULL,
  seas tinyint NOT NULL,
  [year] int NOT NULL,
  team varchar(3) NOT NULL,
  posd varchar(8) NOT NULL,
  jnum tinyint NOT NULL,
  dcp tinyint NOT NULL,
  INDEX IX_offense_gid NONCLUSTERED(gid),
  INDEX IX_offense_player NONCLUSTERED(player)
)

CREATE TABLE pass (
  pid int NOT NULL PRIMARY KEY,
  psr varchar(7) NOT NULL,
  trg varchar(7) DEFAULT NULL,
  loc varchar(2) NOT NULL,
  yds tinyint NOT NULL,
  comp tinyint NOT NULL,
  succ tinyint NOT NULL,
  spk tinyint NOT NULL,
  dfb varchar(7) DEFAULT NULL,
  INDEX IX_pass_psr NONCLUSTERED(psr),
  INDEX IX_pass_trg NONCLUSTERED(trg)
)

CREATE TABLE penalty (
  [uid] int NOT NULL PRIMARY KEY,
  pid int NOT NULL,
  ptm varchar(3) NOT NULL,
  pen varchar(7) DEFAULT NULL,
  [desc] varchar(40) NOT NULL,
  cat tinyint NOT NULL,
  pey tinyint NOT NULL,
  act varchar(1) NOT NULL,
  INDEX IX_penalty_pid NONCLUSTERED(pid)
)

CREATE TABLE play (
  gid int NOT NULL,
  pid int NOT NULL PRIMARY KEY,
  [off] varchar(3) NOT NULL,
  def varchar(3) NOT NULL,
  [type] varchar(4) NOT NULL,
  dseq tinyint NOT NULL,
  [len] tinyint NOT NULL,
  qtr tinyint NOT NULL,
  [min] tinyint NOT NULL,
  sec tinyint NOT NULL,
  ptso tinyint NOT NULL,
  ptsd tinyint NOT NULL,
  timo tinyint NOT NULL,
  timd tinyint NOT NULL,
  dwn tinyint NOT NULL,
  ytg tinyint NOT NULL,
  yfog tinyint NOT NULL,
  [zone] tinyint NOT NULL,
  fd tinyint NOT NULL,
  sg tinyint NOT NULL,
  nh tinyint NOT NULL,
  pts tinyint NOT NULL,
  tck tinyint NOT NULL,
  sk tinyint NOT NULL,
  pen tinyint NOT NULL,
  ints tinyint NOT NULL,
  fum tinyint NOT NULL,
  saf tinyint NOT NULL,
  blk tinyint NOT NULL,
  INDEX IX_play_gid NONCLUSTERED(gid)
)

CREATE TABLE player (
  player varchar(7) NOT NULL PRIMARY KEY,
  fname varchar(20) NOT NULL,
  lname varchar(25) NOT NULL,
  pname varchar(25) NOT NULL,
  pos1 varchar(2) NOT NULL,
  pos2 varchar(2) DEFAULT NULL,
  height tinyint NOT NULL,
  [weight] int NOT NULL,
  dob varchar(10) DEFAULT NULL,
  forty decimal(3,2) NOT NULL,
  bench tinyint NOT NULL,
  vertical decimal(3,1) NOT NULL,
  broad int NOT NULL,
  shuttle decimal(3,2) NOT NULL,
  cone decimal(3,2) NOT NULL,
  arm decimal(5,3) NOT NULL,
  hand decimal(5,3) NOT NULL,
  dpos int NOT NULL,
  col varchar(35) NOT NULL,
  dv varchar(35) DEFAULT NULL,
  [start] int NOT NULL,
  cteam varchar(3) NOT NULL,
  posd varchar(8) NOT NULL,
  jnum tinyint NOT NULL,
  dcp tinyint NOT NULL,
  --nflid varchar(7) DEFAULT NULL,
  INDEX IX_player_fname NONCLUSTERED(fname),
  INDEX IX_player_lname NONCLUSTERED(lname)
)

CREATE TABLE punt (
  pid int NOT NULL PRIMARY KEY,
  punter varchar(7) NOT NULL,
  pgro tinyint NOT NULL,
  pnet tinyint NOT NULL,
  ptb tinyint NOT NULL,
  pr varchar(7) DEFAULT NULL,
  pry tinyint NOT NULL,
  pfc tinyint NOT NULL,
  INDEX IX_punt_punter NONCLUSTERED(punter)
)

CREATE TABLE redzone (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  player varchar(7) NOT NULL,
  pa tinyint NOT NULL,
  pc tinyint NOT NULL,
  py int NOT NULL,
  ints tinyint NOT NULL,
  ra tinyint NOT NULL,
  sra tinyint NOT NULL,
  ry int NOT NULL,
  trg tinyint NOT NULL,
  rec tinyint NOT NULL,
  recy int NOT NULL,
  fuml tinyint NOT NULL,
  peny tinyint NOT NULL,
  INDEX IX_redzone_gid NONCLUSTERED(gid),
  INDEX IX_redzone_player NONCLUSTERED(player)
)

CREATE TABLE rush (
  pid int NOT NULL PRIMARY KEY,
  bc varchar(7) NOT NULL,
  dir varchar(2) NOT NULL,
  yds tinyint NOT NULL,
  succ tinyint NOT NULL,
  kne tinyint NOT NULL,
  INDEX IX_rush_bc NONCLUSTERED(bc)
)

CREATE TABLE sack (
  [uid] int NOT NULL PRIMARY KEY,
  pid int NOT NULL,
  qb varchar(7) NOT NULL,
  sk varchar(7) NOT NULL,
  [value] decimal(2,1) NOT NULL,
  ydsl int NOT NULL,
  INDEX IX_sack_pid NONCLUSTERED(pid),
  INDEX IX_sack_qb NONCLUSTERED(qb),
  INDEX IX_sack_sk NONCLUSTERED(sk)
)

CREATE TABLE [safety] (
  pid int NOT NULL PRIMARY KEY,
  saf varchar(7) NOT NULL,
  INDEX IX_safety_saf NONCLUSTERED(saf)
)

CREATE TABLE schedule (
  gid int NOT NULL PRIMARY KEY,
  seas int NOT NULL,
  wk tinyint NOT NULL,
  [day] varchar(3) NOT NULL,
  [date] text NOT NULL,
  v varchar(3) NOT NULL,
  h varchar(3) NOT NULL,
  stad varchar(45) NOT NULL,
  surf varchar(30) NOT NULL
) 

CREATE TABLE snap (
  [uid] int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  tname varchar(3) NOT NULL,
  player varchar(7) NOT NULL,
  pos varchar(8) NOT NULL,
  snp tinyint NOT NULL,
  INDEX IX_snap_gid NONCLUSTERED(gid),
  INDEX IX_snap_tname NONCLUSTERED(tname),
  INDEX IX_snap_player NONCLUSTERED(player)
)

CREATE TABLE tackle (
  [uid] int NOT NULL PRIMARY KEY,
  pid int NOT NULL,
  tck varchar(7) NOT NULL,
  [value] decimal(2,1) NOT NULL,
  INDEX IX_table_pid NONCLUSTERED(pid),
  INDEX IX_table_tck NONCLUSTERED(tck)
) 

CREATE TABLE td (
  pid int NOT NULL PRIMARY KEY,
  qtr tinyint NOT NULL,
  [min] tinyint NOT NULL,
  sec tinyint NOT NULL,
  dwn tinyint NOT NULL,
  yds tinyint NOT NULL,
  pts tinyint NOT NULL,
  player varchar(7) DEFAULT NULL,
  [type] varchar(4) NOT NULL,
  INDEX IX_td_player NONCLUSTERED(player)
) 

CREATE TABLE team (
  tid int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  tname varchar(3) NOT NULL,
  pts tinyint NOT NULL,
  q1p tinyint NOT NULL,
  q2p tinyint NOT NULL,
  q3p tinyint NOT NULL,
  q4p tinyint NOT NULL,
  rfd tinyint NOT NULL,
  pfd tinyint NOT NULL,
  ifd tinyint NOT NULL,
  ry int NOT NULL,
  ra tinyint NOT NULL,
  py int NOT NULL,
  pa tinyint NOT NULL,
  pc tinyint NOT NULL,
  sk tinyint NOT NULL,
  ints tinyint NOT NULL,
  fum tinyint NOT NULL,
  pu tinyint NOT NULL,
  gpy int NOT NULL,
  pr tinyint NOT NULL,
  pry int NOT NULL,
  kr tinyint NOT NULL,
  kry int NOT NULL,
  ir tinyint NOT NULL,
  iry int NOT NULL,
  pen int NOT NULL,
  [top] decimal(3,1) NOT NULL,
  td tinyint NOT NULL,
  tdr tinyint NOT NULL,
  tdp tinyint NOT NULL,
  tdt tinyint NOT NULL,
  fgm tinyint NOT NULL,
  fgat tinyint NOT NULL,
  fgy int NOT NULL,
  rza tinyint NOT NULL,
  rzc tinyint NOT NULL,
  bry int NOT NULL,
  bpy int NOT NULL,
  srp tinyint NOT NULL,
  s1rp tinyint NOT NULL,
  s2rp tinyint NOT NULL,
  s3rp tinyint NOT NULL,
  spp tinyint NOT NULL,
  s1pp tinyint NOT NULL,
  s2pp tinyint NOT NULL,
  s3pp tinyint NOT NULL,
  lea tinyint NOT NULL,
  ley int NOT NULL,
  lta tinyint NOT NULL,
  lty int NOT NULL,
  lga tinyint NOT NULL,
  lgy int NOT NULL,
  mda tinyint NOT NULL,
  mdy int NOT NULL,
  rga tinyint NOT NULL,
  rgy int NOT NULL,
  rta tinyint NOT NULL,
  rty int NOT NULL,
  rea tinyint NOT NULL,
  rey int NOT NULL,
  r1a tinyint NOT NULL,
  r1y int NOT NULL,
  r2a tinyint NOT NULL,
  r2y int NOT NULL,
  r3a tinyint NOT NULL,
  r3y int NOT NULL,
  qba tinyint NOT NULL,
  qby int NOT NULL,
  sla tinyint NOT NULL,
  sly int NOT NULL,
  sma tinyint NOT NULL,
  smy int NOT NULL,
  sra tinyint NOT NULL,
  sry int NOT NULL,
  dla tinyint NOT NULL,
  dly int NOT NULL,
  dma tinyint NOT NULL,
  dmy int NOT NULL,
  dra tinyint NOT NULL,
  dry int NOT NULL,
  wr1a tinyint NOT NULL,
  wr1y int NOT NULL,
  wr3a tinyint NOT NULL,
  wr3y int NOT NULL,
  tea tinyint NOT NULL,
  tey int NOT NULL,
  rba tinyint NOT NULL,
  rby int NOT NULL,
  sga tinyint NOT NULL,
  sgy int NOT NULL,
  p1a tinyint NOT NULL,
  p1y int NOT NULL,
  p2a tinyint NOT NULL,
  p2y int NOT NULL,
  p3a tinyint NOT NULL,
  p3y int NOT NULL,
  spc tinyint NOT NULL,
  mpc tinyint NOT NULL,
  lpc tinyint NOT NULL,
  q1ra tinyint NOT NULL,
  q1ry int NOT NULL,
  q1pa tinyint NOT NULL,
  q1py int NOT NULL,
  lcra tinyint NOT NULL,
  lcry int NOT NULL,
  lcpa tinyint NOT NULL,
  lcpy int NOT NULL,
  rzra tinyint NOT NULL,
  rzry int NOT NULL,
  rzpa tinyint NOT NULL,
  rzpy int NOT NULL,
  sky int NOT NULL,
  lbs decimal(3,1) NOT NULL,
  dbs decimal(3,1) NOT NULL,
  sfpy int NOT NULL,
  drv tinyint NOT NULL,
  npy int NOT NULL,
  tb tinyint NOT NULL,
  i20 tinyint NOT NULL,
  rtd tinyint NOT NULL,
  lnr decimal(3,1) NOT NULL,
  lnp decimal(3,1) NOT NULL,
  lbr decimal(3,1) NOT NULL,
  lbp decimal(3,1) NOT NULL,
  dbr decimal(3,1) NOT NULL,
  dbp decimal(3,1) NOT NULL,
  nha tinyint NOT NULL,
  s3a tinyint NOT NULL,
  s3c tinyint NOT NULL,
  l3a tinyint NOT NULL,
  l3c tinyint NOT NULL,
  stf tinyint NOT NULL,
  dp tinyint NOT NULL,
  fsp tinyint NOT NULL,
  ohp tinyint NOT NULL,
  pbep tinyint NOT NULL,
  dlp tinyint NOT NULL,
  dsp tinyint NOT NULL,
  dum tinyint NOT NULL,
  pfn tinyint NOT NULL,
  snpo tinyint NOT NULL,
  snpd tinyint NOT NULL,
  INDEX IX_team_gid NONCLUSTERED(gid),
  INDEX IX_team_tname NONCLUSTERED(tname)
) 



