SELECT log_date,
		COUNT(distinct user_id) as new_users
from events_log
where log_date = install_date
and name = 'pageOpen'
group by log_date
ORDER by log_date