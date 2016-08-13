### Some ideas to investigate

Calculate something similar to a (+/-) stat like in basketball for each O-Lineman to demonstrate individual impact on rushing and passing
Use this for predictive analysis on RBs, WRs, and QBs that are playing with a different group of linemen

Does keeping the same group of linemen together from one season to another improve performance?  What about the skill positions + line?

Look for patterns of injury given age, position, weight, 40 speed, etc.
- What about number of snaps, historically?
- Do previous injuries suggest future injuries?

What does a growth/decline curve look like for each position in terms of fantasy point production vs age?
Do factors like weight, strength, 40 speed, etc. shift the curve?

### Approach

Idea 1: Join up some intermediate indexes with minimal data to get some quick stats
- RB PLAYS (pid, gid, olid, player, yds, td, conv)
- WR PLAYS (pid, gid, olid, player, comp, yds, td, conv)
- QB PLAYS (pid, gid, olid, player, comp, yds, td, conv)
Note: An effort has been made towards this.  See Build-Index.R

Idea 2: Join up large data sets and data mine this stuff, e.g. dimension reduction.