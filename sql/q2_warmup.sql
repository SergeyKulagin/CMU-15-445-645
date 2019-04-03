SELECT s.city, COUNT(s.station_id) as city_count 
FROM station s
GROUP by s.city
ORDER by city_count;