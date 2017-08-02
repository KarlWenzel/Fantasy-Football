import re
pattern = re.compile("CREATE TABLE \[?([a-zA-Z0-9]+)\]?\s*")
lines = [line.rstrip('\n') for line in open('E:/git/Fantasy-Football/src/mssql_setup_armchair.sql')]
for line in lines:
	for match in re.finditer(pattern, line):
		print("BULK INSERT [" + match.groups()[0] + "] FROM 'E:\\git\\Fantasy-Football\\data\\nfl_00-16\\" + match.groups()[0] + ".csv' WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\\n', TABLOCK )" )
		print("GO")