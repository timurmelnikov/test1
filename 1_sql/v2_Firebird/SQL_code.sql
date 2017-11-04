--БД, которую исползую - Firebird 2.5

--Создаем структуру БД - таблицы table1 и table2
CREATE TABLE table1 (
  id integer,
  Name varchar(100),
  Phone varchar(13)
);

CREATE TABLE table2 (
  id integer,
  Data varchar(13)
);

--Заполняем таблицы данными:
INSERT INTO table1 (id, Name, Phone) VALUES (1, 'Иванов', null);
INSERT INTO table1 (id, Name, Phone) VALUES (2, 'Петров', null);
INSERT INTO table1 (id, Name, Phone) VALUES (3, 'Сидоров', null);
INSERT INTO table1 (id, Name, Phone) VALUES (4, 'Васильев', null);

INSERT INTO table2 (id, Data) VALUES  (1, '+380631234567');
INSERT INTO table2 (id, Data) VALUES  (2, '+380671234567');
INSERT INTO table2 (id, Data) VALUES  (4, '+380931234567');

--Необходимо в table1.Phone записать номера телефонов из table2.Data. Связь table2.ID = table1.ID

--Еще, как один из вариантов - анонимным блоком:
execute block as

declare variable  id integer;
declare variable  data varchar(13);

begin

    for select t2.id, t2.data from table2 t2
    into :id, :data
    do begin

        update table1 t1 set t1.phone = :data where t1.id = :id;

    end

end;

--Результат - тот же...