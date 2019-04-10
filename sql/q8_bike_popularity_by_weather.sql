SELECT 
w.events,
w.date,
COUNT(t.id)
from weather w INNER JOIN station s on w.zip_code = s.zip_code
INNER JOIN trip t ON t.start_station_id = s.station_id
WHERE STRFTIME('%s', datetime(t.start_time)) BETWEEN STRFTIME('%s', datetime(w.date)) and STRFTIME('%s', datetime(w.date), '+1 day') 
GROUP by w.events, w.date