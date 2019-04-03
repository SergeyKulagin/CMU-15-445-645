WITH CITY_TRIPS_COUNT 
AS (SELECT SUM(CASE s1.city == s2.city
	   WHEN true THEN 1
	   WHEN FALSE THEN 2
	   END) ctn
from trip t 
INNER JOIN station s1 ON t.start_station_id = s1.station_id
INNER JOIN station s2 ON t.end_station_id = s2.station_id)

select
	cities.city,
	COUNT(cities.trip_id),(SELECT ctn from CITY_TRIPS_COUNT),
		round(1.0 * COUNT(cities.trip_id) / (SELECT ctn from CITY_TRIPS_COUNT), 4) rate
from
	(
		SELECT t.id as trip_id,
		s.city
	from
		trip t
	INNER JOIN station s ON
		t.start_station_id = s.station_id
UNION
	SELECT
		t.id as trip_id,
		s.city city
	from
		trip t
	INNER JOIN station s ON
		t.end_station_id = s.station_id) as cities
GROUP by
	cities.city
ORDER by rate desc

