-- Помогите разобраться с распределением активных пользователей по платформам. Для каждого из дней рассчитайте:
-- общий DAU;
-- DAU по каждому типу устройства;
-- долю DAU по каждому типу устройства от общего DAU.
-- Из полученного результата отберите DAU пользователей, использующих Android-устройства.

with 
dau as(select log_date,
       		  app_id, 
       		  COUNT(DISTINCT(user_id)) as uniques
            from events_log
            where name = 'pageOpen'
            group by log_date, app_id)

SELECT *
from(SELECT *,
     		sum(uniques) OVER(partition by log_date) as total,
     		ROUND(uniques / sum(uniques) over (PARTITION BY log_date), 2) as dau_perc
     from dau) r
where app_id='Android'
