WITH RECURSIVE
	days_range(x) AS (
		SELECT CAST(MIN(STRFTIME('%s', datetime(trip.start_time))) AS INT) FROM trip
		UNION
				SELECT x + 60*60*24 FROM days_range WHERE x <= (SELECT MAX(STRFTIME('%s', datetime(trip.end_time))) FROM trip)
	)
SELECT 
DATE(dr.x, 'unixepoch'),
STRFTIME('%s', DATE(dr.x, 'unixepoch')) as day_start, 
STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day')) as day_end,
STRFTIME('%s', t.start_time) as trip_start,
STRFTIME('%s', t.end_time) as trip_end,
max(STRFTIME('%s', t.start_time), STRFTIME('%s', DATE(dr.x, 'unixepoch'))) as left_time_point,
min(STRFTIME('%s', t.end_time), STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day'))) as right_time_point,
max(min(STRFTIME('%s', t.end_time), STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day'))) - max(STRFTIME('%s', t.start_time), STRFTIME('%s', DATE(dr.x, 'unixepoch'))), 0) as diff
from days_range dr, trip t
WHERE t.bike_id <= 100 and diff > 0;