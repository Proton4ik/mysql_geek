-- Тема Агрегация, задание 1
-- Подсчитайте средний возраст пользователей в таблице users
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;