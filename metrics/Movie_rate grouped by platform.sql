--Рассчитайте долю активных пользователей, которую составляют пользователи, 
--посмотревшие в день хотя бы один фильм. Сделайте разбивку по типам устройств.
WITH
dau as(select distinct user_id, app_id, log_date 
       from events_log),
movies as(select distinct user_id, log_date
          from events_log
          where name = 'startMovie')
select app_id,
		count(DISTINCT user_id) as dau,
        count(distinct movie_user_id) as dau_movie,
        count(distinct movie_user_id) / count(DISTINCT user_id)::float as movie_rate
from(select d.user_id, d.app_id, d.log_date, m.user_id as movie_user_id
     from dau d
     left join movies m on m.user_id=d.user_id and m.log_date=d.log_date) T
group by app_id