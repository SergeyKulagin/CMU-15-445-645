SELECT (SELECT  
ROUND(AVG(w.mean_temp),4)
FROM trip t JOIN station s on t.start_station_id = s.station_id JOIN weather w on s.zip_code = w.zip_code
WHERE STRFTIME('%s', datetime(t.end_time)) -  STRFTIME('%s', datetime(t.start_time)) <=60) 'SHORT',
(SELECT  
ROUND(AVG(w.mean_temp),4)
FROM trip t JOIN station s on t.start_station_id = s.station_id JOIN weather w on s.zip_code = w.zip_code
WHERE STRFTIME('%s', datetime(t.end_time)) -  STRFTIME('%s', datetime(t.start_time)) > 60) 'LONG';