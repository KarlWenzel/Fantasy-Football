--BULK
--INSERT block
--FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\BLOCK.csv'
--WITH
--(
--FIRSTROW = 1,
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

USE FF
GO

DELETE FROM BLOCK
DELETE FROM CONV
DELETE FROM DEFENSE
DELETE FROM DRIVE
DELETE FROM FGXP
DELETE FROM FUMBLE
DELETE FROM GAME
DELETE FROM INJURY
DELETE FROM INTERCPT
DELETE FROM KICKER
DELETE FROM KOFF
DELETE FROM OFFENSE
DELETE FROM OLINE
DELETE FROM PASS
DELETE FROM PENALTY
DELETE FROM PLAY
DELETE FROM PLAYER
DELETE FROM PUNT
DELETE FROM REDZONE
DELETE FROM RUSH
DELETE FROM SACK
DELETE FROM [SAFETY]
DELETE FROM TACKLE
DELETE FROM TD
DELETE FROM TEAM

BULK INSERT BLOCK FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\BLOCK.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT CONV FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\CONV.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT DEFENSE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\DEFENSE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT DRIVE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\DRIVE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT FGXP FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\FGXP.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT FUMBLE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\FUMBLE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT GAME FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\GAME.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT INJURY FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\INJURY.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT INTERCPT FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\INTERCPT.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT KICKER FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\KICKER.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT KOFF FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\KOFF.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT OFFENSE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\OFFENSE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT OLINE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\OLINE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT PASS FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\PASS.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT PENALTY FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\PENALTY.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT PLAY FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\PLAY.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT PLAYER FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\PLAYER.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT PUNT FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\PUNT.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT REDZONE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\REDZONE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT RUSH FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\RUSH.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT SACK FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\SACK.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT [SAFETY] FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\SAFETY.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT SCHEDULE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\SCHEDULE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT TACKLE FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\TACKLE.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT TD FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\TD.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO
BULK INSERT TEAM FROM 'C:\Users\karl\Documents\Fantasy-Football\data\nfl_sample_data_2015\csv\TEAM.csv' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n' )
GO


