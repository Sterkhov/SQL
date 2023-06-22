--какую долю составляют новички от общего DAU
with 
dau as(
  select log_date,
         CASE
         	when log_date=install_date then 'новые пользователи'
         	else 'старые пользователи'
         END as new_old,
  		 count(DISTINCT(user_id)) as uniques
  from events_log
  group by log_date, 
  		CASE
        	when log_date=install_date then 'новые пользователи'
            else 'старые пользователи'
        END
order by log_date, uniques DESC),
perc_dau as(
  	select *,
  			sum(uniques) over(PARTITION by log_date) as total,
  			cast(uniques as float) / sum(uniques) over(PARTITION by log_date)
    from dau)
select *
from perc_dau
where new_old='новые пользователи'