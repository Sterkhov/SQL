--Рассчитайте общий DAU с группировкой по дням. 
--Чтобы запрос работал быстрее, не считайте все типы событий, а возьмите только 
--аналитические события типа pageOpen. Каждый активный пользователь отправляет 
--как минимум одно такое событие, входя в продукт.

SELECT log_date,
		COUNT(distinct user_id) as new_users
from events_log
where log_date = install_date
and name = 'pageOpen'
group by log_date
ORDER by log_date
