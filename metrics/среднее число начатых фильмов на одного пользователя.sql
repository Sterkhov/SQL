--среднее число начатых фильмов на одного пользователя
--доля пользователей посмотревших хотя бы один фильм в день
SELECT log_date,
		COUNT(DISTINCT user_id) as dau,
		count(distinct case when name = 'startMovie' then user_id else NULL END) as dau_feature,
        count(distinct case when name = 'startMovie' then user_id else NULL END) / COUNT(DISTINCT user_id)::float perc_dau_feature,
        sum(case when name = 'startMovie' then 1 else 0 end) as events,
        sum(case when name = 'startMovie' then 1 else 0 end) / COUNT(DISTINCT user_id)::float as mean_events
        
from events_log 
GROUP by log_date
ORDER by log_date





