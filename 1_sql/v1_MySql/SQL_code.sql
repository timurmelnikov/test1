--БД, которую исползую - MariaDB (форк MySQL, входящий в состав XAMPP https://www.apachefriends.org/ru/ )

--Создаем структуру БД - таблицы table1 и table2
CREATE TABLE `table1` (
  `id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Phone` varchar(13) DEFAULT NULL
);

CREATE TABLE `table2` (
  `id` int(11) NOT NULL,
  `Data` varchar(13) NOT NULL
);

--Заполняем таблицы данными:
INSERT INTO `table1` (`id`, `Name`, `Phone`) VALUES
(1, 'Иванов', null),
(2, 'Петров', null),
(3, 'Сидоров', null),
(4, 'Васильев', null);

INSERT INTO `table2` (`id`, `Data`) VALUES
(1, '+380631234567'),
(2, '+380671234567'),
(4, '+380931234567');

--Необходимо в table1.Phone записать номера телефонов из table2.Data. Связь table2.ID = table1.ID
--Проще всего, это сделать так:
UPDATE table1 t1 SET t1.Phone=(select t2.Data from table2 t2 where t2.id = t1.id)