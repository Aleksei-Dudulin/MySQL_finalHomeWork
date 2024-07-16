USE homework_6;

-- 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'

DELIMITER //
CREATE FUNCTION FormatSeconds(total_seconds INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    -- Объявляем и инициализируем переменные
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE remaining_seconds INT;
    DECLARE result VARCHAR(100);
    -- Производим вычисления
    SET days = total_seconds DIV (24 * 3600);
    SET total_seconds = total_seconds MOD (24 * 3600);
    SET hours = total_seconds DIV 3600;
    SET total_seconds = total_seconds MOD 3600;
    SET minutes = total_seconds DIV 60;
    SET remaining_seconds = total_seconds MOD 60;
    -- Создаем строку с результатом вычислений
    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', remaining_seconds, ' seconds');
    -- Возвращаем полученный результат
    RETURN result;
END //
DELIMITER ;
-- Вызываем функцию
SELECT FormatSeconds(123456);

-- 2. Выведите только чётные числа от 1 до 10.
-- Пример: 2,4,6,8,10

DELIMITER //
CREATE PROCEDURE GetEvenNumbers(IN start_num INT, IN end_num INT)
BEGIN
    DECLARE current_number INT DEFAULT start_num;
    DECLARE result VARCHAR(1000) DEFAULT '';
    -- Убедимся, что начальное число четное
    IF current_number % 2 != 0 THEN
        SET current_number = current_number + 1;
    END IF;
    -- Генерируем четные числа в заданном диапазоне
    WHILE current_number <= end_num DO
        IF result = '' THEN
            SET result = CAST(current_number AS CHAR);
        ELSE
            SET result = CONCAT(result, ',', current_number);
        END IF;
        SET current_number = current_number + 2;
    END WHILE;
    -- Выводим результат
    SELECT result;
END //
DELIMITER ;
-- Вызываем процедуру
CALL GetEvenNumbers(1, 10);