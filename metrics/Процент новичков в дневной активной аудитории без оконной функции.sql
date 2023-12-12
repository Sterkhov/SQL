--какую долю составляют новички от общего DAU
WITH
 dau_table as (  
	select log_date,
		count(DISTINCT(user_id)) as dau
	from events_log
	group by log_date
	order by log_date
	),
	
new_usrs as (
	SELECT log_date,
      		count(distinct(user_id)) as new_users
        from events_log
        where log_date=install_date
        GROUP by log_date
        order by log_date
	)
	
select *, round(new_users/dau::numeric, 2) as dau_perc
From dau_table join new_usrs using(log_date)
