WITH RECURSIVE
	days_range(x) AS (
		SELECT CAST(MIN(STRFTIME('%s', datetime(trip.start_time))) AS INT) FROM trip
		UNION
				SELECT x + 60*60*24 FROM days_range WHERE x <= (SELECT MAX(STRFTIME('%s', datetime(trip.end_time))) FROM trip)
	),
days_statistic as (SELECT 
DATE(dr.x, 'unixepoch') target_day,
STRFTIME('%s', DATE(dr.x, 'unixepoch')) as day_start, 
STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day')) as day_end,
STRFTIME('%s', t.start_time) as trip_start,
STRFTIME('%s', t.end_time) as trip_end,
max(STRFTIME('%s', t.start_time), STRFTIME('%s', DATE(dr.x, 'unixepoch'))) as left_time_point,
min(STRFTIME('%s', t.end_time), STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day'))) as right_time_point,
max(min(STRFTIME('%s', t.end_time), STRFTIME('%s', DATE(dr.x, 'unixepoch', '+1 day'))) - max(STRFTIME('%s', t.start_time), STRFTIME('%s', DATE(dr.x, 'unixepoch'))), 0) as diff
from days_range dr, trip t
WHERE t.bike_id <= 100 and diff > 0),
number_of_bikes as (
	SELECT COUNT(DISTINCT t.bike_id) as nob from trip t
)

SELECT s.target_day, sum(s.diff), ROUND(1.0*sum(s.diff)/(select nob FROM number_of_bikes), 4) time_spent FROM days_statistic s
GROUP BY s.target_day
ORDER by time_spent desc
LIMIT 10
