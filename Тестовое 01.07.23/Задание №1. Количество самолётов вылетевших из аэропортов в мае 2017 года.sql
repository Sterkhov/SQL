--Сколько самолётов вылетело из аэропортов в мае 2017 года

select COUNT(aircraft_code) Количество_самолетов_вылетевших_в_мае_2017
from flights
where DATE_TRUNC('month', actual_departure) = '2017-05-01 00:00:00+03'
and status = 'Arrived'
group by status
