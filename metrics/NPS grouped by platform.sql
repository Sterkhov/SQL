--Рассчитайте NPS с разбивкой по типам устройств.
--Округлите результат до двух знаков после запятой с помощью функции ROUND
select app_id,
		sum(case when rating >= 9 then count_evaluations else 0 end) promoters,
        sum(case when rating <= 6 then count_evaluations else 0 end) detractors,
        sum(count_evaluations) total_evaluations,
        ROUND(sum(case when rating >= 9 then count_evaluations else 0 end)/sum(count_evaluations) - sum(case when rating <= 6 then count_evaluations else 0 end)/sum(count_evaluations), 2) nps_rate
        

from(select app_id, object_value rating, count(DISTINCT user_id) count_evaluations
from events_log
where name = 'npsDialogVote'
GROUP by app_id, object_value) nps
GROUP by app_id