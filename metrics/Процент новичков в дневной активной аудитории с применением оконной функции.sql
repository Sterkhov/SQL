--какую долю составляют новички от общего DAU
with 
new_old_users as(
  select log_date,
         CASE
         	when log_date=install_date then 'новые пользователи'
         	else 'старые пользователи'
         END as new_old,
  		 count(DISTINCT(user_id)) users
  from events_log
  group by log_date, 
  		CASE
        	when log_date=install_date then 'новые пользователи'
            else 'старые пользователи'
        END
order by log_date, users DESC),
dau as(
  	select *,
  			sum(users) over(PARTITION by log_date) total,
  			round(users::numeric / sum(users) over(PARTITION by log_date), 2) perc_dau
    from new_old_users)
select *
from dau
where new_old='новые пользователи'
