<?php
//Исползую тестовый сервер XAMPP https://www.apachefriends.org/ru/

/*
Специально не использовал Yii2 + https://github.com/yiisoft/yii2-httpclient. Решил сделать на "голом" PHP + CURL
При решении задания, испытал проблему с авторизацией... Но, догадался, что нужно использовать Базовую аутентификацию :)
*/

// Настройки

//URL, который будем "дергать"
$url = "https://front.ulf.ua:442/webservice.php";
//Контент запроса
$content = <<<XML
<?xml version="1.0" encoding="utf-8" ?>
<Запрос>
<ID_Запроса>123</ID_Запроса>
<ФИО>Иванов Иван Иванович</ФИО>
</Запрос>
XML;

//Логин
$login = 'melnikovt';

//Пароль
$password = 'WebService!2017';

//Выполнение запроса
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_HTTPHEADER, array( 
        'Content-Type: application/xml',  
        'Authorization: '.'Basic '.base64_encode($login.':'.$password) //Здесь, используется базовая авторизация, а значит заголовок должен быть: 'Authorization: Basic bWVsbmlrb3Z0OldlYlNlcnZpY2UhMjAxNw=='
    )); 
    curl_setopt($curl, CURLOPT_POSTFIELDS, $content);
    curl_setopt($curl, CURLOPT_SSLVERSION,3); 
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $out = curl_exec($curl);
    curl_close($curl);
 
    //Результат, парсим и выводим
    $xml=simplexml_load_string($out);
   
    echo 'Номер запроса - '. $xml->ID_Запроса .'<br>';
    echo 'Дата - '. $xml->Результат->Дата.'<br>';
    echo 'Балл - '. $xml->Результат->Балл.'<br>';
    echo 'Сообщение сервиса - '. $xml->Результат->Сообщение.'<br>';

    

//Отладочная инфа... Благодаря этому, удалось понять, что не хватает curl_setopt($curl, CURLOPT_SSLVERSION,3);
//https://ruseller.com/lessons.php?rub=37&id=1187
/*
    $info = curl_getinfo($curl);
    echo 'Took ' . $info['total_time'] . ' seconds for url ' . $info['url'] .'<br/>';
    if ($out === FALSE) {
            echo curl_error($curl);
        }
    curl_close($curl);
*/