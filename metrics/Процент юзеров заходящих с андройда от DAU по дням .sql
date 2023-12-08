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

-- Или тоже самое покороче через подзапросы
select * 
from(	select *, 
		sum(dau_per_app) over(partition by log_date) dau,
		round(dau_per_app::numeric/sum(dau_per_app) over(partition by log_date),2) dau_perc 
	from (
		select log_date, app_id,
	  	       count(distinct user_id) dau_per_app
		from events_log
		where name='pageOpen'
		group by log_date,app_id)a) b
where app_id ='Android'
