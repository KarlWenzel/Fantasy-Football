##Code Book: Explanation of Variables

Most of the csv files present in the uncompressed raw data from 
[Armchair Analysis.com](http://www.armchairanalysis.com/) is organized in way conducive
for loading into a relational database system, however they have also joined ("flattened") the data from most of 
these tables into a single, large file named "Flat File.csv".  This is the primary file of interest for our project, as it is easy to load the large table into an R data frame, which shall be named *plays*.

###Plays

The following table describes every column in the *plays* data frame.  Note that many columns have user-defined
types, which are explained in the next table thereafter.

| Code | Type | Description | Example Data 
| -----  | -----  | -----  | ----- 
| GID | int | Game ID (foreign key) | 3189 
| PID | int | Play ID (primary key) | 518049 
| DETAIL | str | Detailed explanation of the play | D.Bailey kicks 69 yards from DAL 35 to NYG -4. D.Wilson to NYG 16 for 20 yards (A.Holmes). 
| OFF | str | Abbreviated team name on Offense | NYG 
| DEF | str | Abbreviated team name on Defense | DAL 
| TYPE | playType | Play type, e.g. RUSH for rushing play, NOPL for no play, etc. | KOFF 
| DSEQ | int | Drive Sequence (e.g. 1 means first offensive drive for OFF team) |  
| LEN | int | Play time duration, in seconds | 4 
| QTR | int | game clock Quarter (1-4) | 1 
| MIN | int | game clock Minute (0-60) | 15 
| SEC | int | game clock Second (0-60) |  
| PTSO | int | Points Scored, Offense |  
| PTSD | int | Points Scored, Defense |  
| TIMO | int | Time Outs, Offense | 3 
| TIMD | int | Time Outs, Defense | 3 
| DWN | int | Down (1-4) | NA 
| YTG | int | Yards To Go | NA 
| YFOG | int | Yards From Own Goal | NA 
| ZONE | int | Field Zone (NA, 1-5) | NA 
| YDS | int | Yards gained, only applies to TYPE in { RUSH | PASS } | NA 
| SUCC | yType | Successful play  |  
| FD | yType | First Down occured |  
| SG | yType | Shotgun formation |  
| NH | yType | No Huddle occured |  
| PTS | int | Points scored on play (negative means defense scored) | NA 
| BC | playerID | Ball Carrier (foreign key) on RUSH play |  
| KNE | yType | QB took a Knee on RUSH play |  
| DIR | rushDir | On rush play, the Direction that  the runner ran (in terms of oline) |  
| RTCK1 | playerID | Rushing play Tackler 1 |  
| RTCK2 | playerID | Rushing play Tackler 2 |  
| PSR | playerID | Passer on PASS play |  
| COMP | yType | pass was Complete on PASS play |  
| SPK | yType | ball was Spiked to kill clock on PASS play |  
| LOC | passLoc | general Location of pass target |  
| TRG | playerID | pass Target |  
| DFB | playerID | pass Defensive Back that performed successful action |  
| PTCK1 | playerID | Pass play Tackler 1 |  
| PTCK2 | playerID | Pass play Tackler 2 |  
| SK1 | playerID | pass play Sacker 1 |  
| SK2 | playerID | pass play Sacker 2 |  
| PTM1 | str | Penalty Team abbreviation (foreign key) |  
| PEN1 | playerID | Penalty player id |  
| DESC1 | str | penalty Description |  
| CAT1 | penCat | penalty 1 Category | NA 
| PEY1 | int | Penalty Yardage assessed | NA 
| PDO1 | chr | Penalty 'D'eclined / 'O'ffsetting / 'A'ssessed |  
| PTM2 | str | Penalty Team abbreviation (foreign key) |  
| PEN2 | playerID | Penalty player id |  
| DESC2 | str | penalty Description |  
| CAT2 | penCat | penalty 2 Category | NA 
| PEY2 | int | Penalty Yardage assessed | NA 
| PDO2 | chr | Penalty 'D'eclined / 'O'ffsetting / 'A'ssessed |  
| PTM3 | str | Penalty Team abbreviation (foreign key) | NA 
| PEN3 | playerID | Penalty player id | NA 
| DESC3 | str | penalty Description | NA 
| CAT3 | penCat | penalty 3 Category | NA 
| PEY3 | int | Penalty Yardage assessed | NA 
| PDO3 | chr | Penalty 'D'eclined / 'O'ffsetting / 'A'ssessed | NA 
| INT | playerID | player that caught Interception on pass play |  
| IRY | int | Interception Return Yardage | NA 
| FUM | playerID | player that Fumbled the ball |  
| FRCV | playerID | player that Recovered the Fumbled ball |  
| FRY | int | Fumble Return Yardage | NA 
| FORC | playerID | player that Forced the fumble |  
| SAF | playerID | defensive player that caused Saftey |  
| BLK | playerID | defensive player that blocked ball (PUNT, FGXP) |  
| BRCV | playerID | player that Recovered the Blocked ball |  
| FGXP | string | either "", "FG", or "XP" to represent type of kick if FGXP |  
| FKICKER | playerID | player who as Fieldgoal/xp Kicker |  
| DIST | int | distance of FG / XP | NA 
| GOOD | nyType | was kick attempt Good, if FGXP |  
| PUNTER | playerID | player that is the Punter |  
| PGRO | int | Punt Gross yardage | NA 
| PNET | int | Punt Get yardage | NA 
| PTB | nyType | Punt was a Touch Back |  
| PR | playerID | player who was Punt Returner |  
| PRY | int | Punt Return Yardage | NA 
| PFC | nyType | Punt was Fair Caught |  
| KICKER | playerID | player who was Kicker on KOFF | DB-0200 
| KGRO | int | Kickoff Gross yards | 69 
| KNET | int | Kickoff Net yards | 49 
| KTB | nyType | Kickoff resulted in Touch Back |  
| KR | playerID | player who was Kickoff Returner | DW-4050 
| KRY | int | Kickoff Return Yardage | 20 
| LT | playerID | player who was Left Tackle |  
| LG | playerID | player who was Left Guard |  
| C | playerID | player who was Center |  
| RG | playerID | player who was Right Guard |  
| RT | playerID | player who was Right Tackle | 

### User-Defined Column Types

| Type | Description | Notes 
| -----  | -----  | ----- 
| playType | string: { CONV , FGXP , KOFF , NOPL , ONSD , PASS , PUNT , RUSH } | CONV == 2 pt conversion 
| yType | string: { Y , <empty string> } |  
| nyType | string: { N , Y , <empty string> } |  
| playerID | string: follows pattern: [a-z][a-z]-[0-9][0-9][0-9][0-9] | first two letters are player's first and last name initials 
| rushDir | string: direction runner ran { LE, RE, LG, RG, LT, RT, MD, NL } | End, Guard, Tackle, Middle, Not Listed 
| passLoc | string: pass location { SM, SL, SR, DM, DL, DR, NL } | Short/Deep Left/Middle/Right, Not Listed.  note deep means 15+ yards from scrimmage 
| penCat | int: 1 - False Start; 2 - Offensive Holding; 3 - Play Book Execution; 4 - Defensive Line; 5 - Defensive Secondary; 6 - Dumb; 7 - Poor Fundamentals (Blocking/Tackling); 8 - Other | 
