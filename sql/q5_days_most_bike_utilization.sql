WITH RECURSIVE
	days_range(x) AS (
		SELECT CAST(MIN(STRFTIME('%s', datetime(trip.start_time))) AS INT) FROM trip
		UNION
				SELECT x + 60*60*24 FROM days_range WHERE x <= (SELECT MAX(STRFTIME('%s', datetime(trip.end_time))) FROM trip)
																
--		SELECT x + 60*60*24 FROM days_range WHERE x <=  
	)
SELECT DATETIME(dr.x, 'unixepoch') as 'day' from days_range dr;


/*SELECT
	STRFTIME('%Y', datetime(t.start_time)) as 'year_start',
	STRFTIME('%Y', datetime(t.end_time)) as 'year_end',
	STRFTIME('%m', datetime(t.start_time)) as 'month_start',
	STRFTIME('%m', datetime(t.end_time)) as 'month_end',
	t.start_time,
	t.end_time,
	(STRFTIME('%s', datetime(t.end_time))- STRFTIME('%s', datetime(t.start_time)))/ 60
FROM
	trip t
WHERE month_start != month_end or year_start != year_end*/