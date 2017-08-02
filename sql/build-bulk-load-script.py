import re
pattern = re.compile("CREATE TABLE \[?([a-zA-Z0-9]+)\]?\s*")
lines = [line.rstrip('\n') for line in open('E:/git/Fantasy-Football/sql/mssql_setup_armchair.sql')]

print("-- BULK LOAD all tables")
print
for line in lines:
	for match in re.finditer(pattern, line):
		print("BULK INSERT [" + match.groups()[0] + "] FROM 'E:\\git\\Fantasy-Football\\data\\nfl_00-16\\" + match.groups()[0] + ".csv' WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\\n', TABLOCK )" )
		print("GO")
		
print	
print("-- TRUNCATE TABLE all tables")
print
for line in lines:
	for match in re.finditer(pattern, line):
		print("TRUNCATE TABLE [" + match.groups()[0] + "]")
		print("GO")