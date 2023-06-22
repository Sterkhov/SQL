#Рассчитайте общий DAU с группировкой по дням. Чтобы запрос работал быстрее, не считайте все типы событий, а возьмите только аналитические события типа pageOpen.

SELECT dt as date,
	   COUNT(DISTINCT(user_id)) as DAU
FROM events_log
WHERE name = 'pageOpen'
group by dt
order by dt