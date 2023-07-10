--Посчитай количество первых бронирований пользователей. 
--А ещё вторых. И третьих. И так далее. 
--Результат нужно предоставить в виде воронки:
with
book_numbers as (select book_ref, row_number() over(partition by book_ref) count_bookings
from tickets)

select count_bookings booking_sequence_number, count(book_ref)
from book_numbers
group by count_bookings
order by count_bookings

