--какую долю составляют новички от общего DAU
WITH
a as (  select log_date,
			   count(DISTINCT(user_id)) as dau
		from events_log
group by log_date
order by log_date),
B as (  SELECT log_date,
      		   count(distinct(user_id)) as new_users
        from events_log
        where log_date=install_date
        GROUP by log_date
        order by log_date)
select a.log_date, dau, new_users, new_users/dau::FLOAT as dau_perc
From a left join B on a.log_date=B.log_date