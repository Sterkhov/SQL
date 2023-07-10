--Количество почт пассажиров купивших билет на летний рейс в Москву

select COUNT(contact_data ->> 'email') Количество_почт_пассажиров_купивших_билет_на_летний_рейс_в_Москву
from flights f left join ticket_flights tf on f.flight_id=tf.flight_id
left join tickets t on t.ticket_no=tf.ticket_no
left join airports_data ad on f.arrival_airport=ad.airport_code
where extract(month from scheduled_departure) IN(6,7,8)
AND city ->> 'ru' = 'Москва'