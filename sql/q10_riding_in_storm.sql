select * from 
(SELECT w.zip_code, s.station_name, count(t.id) trips_num
FROM weather w join station s on w.zip_code = s.zip_code join trip t on t.start_station_id = s.station_id
where w.events = 'Rain-Thunderstorm' 
and STRFTIME('%s', datetime(t.start_time)) BETWEEN STRFTIME('%s', datetime(w.date)) and STRFTIME('%s', datetime(w.date), '+1 day')
GROUP by w.zip_code, t.start_station_id)
order by trips_num DESC limit 1