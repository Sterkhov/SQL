--Рассчитайте удержание девятого дня с разбивкой по типам устройств, с которых посетители входят в онлайн-кинотеатр.
WITH

activity as(
  SELECT	app_id,
  			log_date - install_date lifetime,
  			count(DISTINCT user_id) retained
  from events_log
  where install_date between '2022-11-30' and '2022-12-08'
  group by app_id, lifetime
  order by app_id, lifetime),
  
  retention as(
    select *,
    		SUM(case when lifetime = 0 then retained else 0 end) over(partition by app_id) cohort_size,
    		retained::float / SUM(case when lifetime = 0 then retained else 0 end) over(partition by app_id) retention_rate
    from activity
    )
    
select * 
FROM retention
WHERE lifetime = 9
