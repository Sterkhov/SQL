-- Добавим корректный столбец с оценками пользователей 
ALTER TABLE events_log ADD COLUMN object_values numeric(10, 2) DEFAULT ROUND(random() * 10);
