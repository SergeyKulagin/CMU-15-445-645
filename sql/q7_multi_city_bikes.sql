SELECT t1.bike_id, t1.id, s1_start.city as'city1_start', s1_end.city as 'city1_end', t2.id, s2_start.city as 'city2_start', s2_end.city as 'city2_end' 
FROM trip t1 
INNER JOIN trip t2 on t1.bike_id = t2.bike_id 
INNER JOIN station s1_start on t1.start_station_id = s1_start.station_id
INNER JOIN station s1_end on t1.end_station_id = s1_end.station_id
INNER JOIN station s2_start on t2.start_station_id = s2_start.station_id
INNER JOIN station s2_end on t2.end_station_id = s2_end.station_id
WHERE 
t1.id > t2.id
and (
	city1_start != city1_end or city2_start != city2_end or city1_start != city2_start
)



select bike, COUNT(city) 'city_count' from (SELECT tr.bike_id 'bike', st.city 'city' FROM trip tr 
INNER JOIN station st on tr.start_station_id = st.station_id
UNION
SELECT tr.bike_id 'bike', st.city 'city' FROM trip tr 
INNER JOIN station st on tr.end_station_id = st.station_id)
GROUP BY bike
HAVING city_count > 1