SELECT
	t1.bike_id 't1_bike',
	t2.bike_id 't2_bike',
	t1.start_time 't1_start',
	t1.end_time 't1_end',
	t2.start_time 't2_start',
	t2.end_time 't2_end',
	t1.id 'trip_id_1',
	t2.id 'trip_i2_2',
	(min(STRFTIME('%s', datetime(t1.end_time)), STRFTIME('%s', datetime(t2.end_time)))- max(STRFTIME('%s', datetime(t1.start_time)), STRFTIME('%s', datetime(t2.start_time)))) 'diff'
FROM
	trip t1
INNER JOIN trip t2 on
	t1.bike_id = t2.bike_id
WHERE
	(t1.bike_id BETWEEN 100 and 200)
	and t2.id <> t1.id
	and diff > 0