WITH trips_stats as (
	select
		trips.city,
		trips.station_name,
		count(trips.trip_id) as trips_count
	from
		(
		SELECT
			t.id as trip_id,
			s.station_name,
			s.city
		from
			trip t
		INNER JOIN station s ON
			t.start_station_id = s.station_id
	UNION
		SELECT
			t.id,
			s.station_name,
			s.city
		from
			trip t
		INNER JOIN station s ON
			t.end_station_id = s.station_id) as trips
	GROUP by
		trips.city,
		trips.station_name)


select city, station_name, trips_count from (		
select
	*,
	RANK() OVER(
	PARTITION by city ORDER by trips_count desc) as rnk
from trips_stats)
WHERE rnk = 1
ORDER by city asc
