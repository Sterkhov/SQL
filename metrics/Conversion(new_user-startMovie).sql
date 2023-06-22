--Рассчитайте конверсию новых пользователей в просмотр хотя бы одного фильма с разбивкой по типам устройств.
WITH
installs as (
    select user_id,
		MIN(install_date) install_date
	from events_log
	where log_date=install_date
	GROUP by user_id),
watchers_list as(
  select DISTINCT user_id user_id
  from events_log
  where name='startMovie')
  
select install_date,
		count(i.user_id) new_users,
        count(w.user_id) watchers,
        to_char(count(w.user_id)::float / count(i.user_id), 'FM9999990.00')  as convers1on
from installs i left join watchers_list w on i.user_id=w.user_id
group by install_date