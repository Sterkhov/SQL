--название города и количество совершенных в этот город перелётов за 2017 год.

select a.city ->> 'ru' Город, count(*) Количество_прилетевших_самолетов_в_2017
from flights f left join airports_data a on a.airport_code=f.arrival_airport
where EXTRACT(YEAR FROM  actual_arrival) = '2017'
and status = 'Arrived'
group by a.city