# Запуск проекта
**sudo docker compose up -d** <br>
название базы данных **library** <br>
разворачивается на порте **5434**

для обновления представления <br>
**REFRESH MATERIALIZED VIEW reader_list_books**


# Предметная область
## словарь
УДК (UDC) - Универсальная десятичная классификация
ISBN - Индетефикатор ISBN International Standard Book Number

## требования
Библиотека осуществляет выдачу зарегистрированным читателям во временное пользование книг из фонда. Для каждой поступившей в библиотеку книги должны быть учтены следующие данные:

- название;
- ФИО автора (или авторов) с указанием страны рождения для каждого автора;
- жанр;
- ISBN (считаем, что в библиотеке содержатся только книги не старее 1990 года);
- индекс УДК (один и тот же индекс может быть у нескольких книг);
- формат страниц;
- вид переплёта (твёрдый или мягкий);
- год издания;
- издательство;
- количество поступивших экземпляров (на каждый экземпляр книги наносится свой уникальный штрихкод).

Библиотека также хранит информацию об издательствах, поставляющих книги:
- название
- адрес  (Большая часть издательств находится в Москве.)
- телефон
- ФИО контактного лица.

Анкета читателя регистрирующегося содержит анкетные данные:
- фамилия
- имя
- отчество
- адрес проживания
- контактный телефон
- паспортные данные.

Читатели младше 14 лет (не имеющие паспорта) могут зарегистрироваться только вместе с одним из родителей (“ответственным”). При этом оба получают отдельный читательский билет.
Для читателей младше 14 лет вместо паспортных данных указывается:
- номер
- дата выдачи свидетельства о рождении
- *! не указываются контактные данные, но при этом должна быть возможность найти их через родителей.*

В результате регистрации каждому читателю выдаётся читательский билет, имеющий уникальный номер.
При выдаче экземпляра книги в читательском билете фиксируется:
- дата выдачи
- ожидаемая дата возврата (фактическая – указывается в момент возврата).

## Требованя к представлению
Представление для отображения:
- фамилия читателя
- имя читателя
- список книг на руках читателя
  - ISBN
  - название

# Инфологическая модель
В ходе анализа предметной области выявлены следующие сущности
Именование:-
- pk или fk - определяет первичный или вторичный ключ
- буква столбца - первая буква названия таблицы <br>

|Префикс |Имя сущности |Имя таблицы|Название таблицы в целом (как название сущности)
|:-------|:---|:-------|:-------|
|c|format (формат чего-либо)|cformat|**каталог** типов форматов|
|s|author (автор)|sauthor|**Справочник** форматов|
|r|book (книги)|rbook|**Реестр** книг|
|j|libticket (читательский билет)|jlibticket|**Журнал** книг взятых на читательский билет. ИЛИ вычислимые операции|

- **c** Каталог. Представляет собой простейший справочник из десятка пунктов чего-то неизменного, или почти неизменного. Структурирует некую фундаментальную природу вещей. <br> Например, перечисляет типы улиц - "улица", "переулок", "проезд", "тупик", "овраг". Через пару лет построят в деревне первый проспект - добавим "проспект".
- **s** Справочник. Относительно большая таблица, выходящая за пределы простого каталога. Могут требовать инкрементального поиска, времязависимости, древовидных показов и чего угодно.
- **r** Реестр. Таблица объектов, для поголовного учета которых собственно предназначена система. Объекты интенсивно добавляются, редактируются, удаляются (или иным образом помечаются как выведенные из учета). Объем таблиц может быть велик. Просмотр всей таблицы обычно не имеет смысла.
- **j** Журнал. Таблица фиксирования событий, например журнал регистрации пользователей в системе. Растет линейно со временем жизни системы (поэтому при больших объемах может понадобиться сбрасывание части информации в архив). Как правило, просмотр всей таблицы не имеет смысла, а нужен только в контексте какого-либо объекта в связи один-ко-многим, например - операции начисления данного абонента, также используются для расчетов, отчетов.
<br>
можно придумать дополнительные префиксы

##обьекты (таблицы)

### rlibcard (реестр карточек читателей)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkcard|serial|Номер билта (PK)|
|lclastn|varchar(40)|lib card Фамилия|
|lcfirstn|varchar(40)|lib card Имя|
|lcthirdn|varchar(40)|lib card Отчество |

### radult (взрослый реестр читателей)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkacard|integer|Номер билета взрослый (FK)|
|aaddress|varchar(40)|адресс взрослого|
|aphone|varchar(11)|телефон взрослого|
|apassseriesnum|varchar(10)|Серия номер паспорта|
|adatepassrelease|date|Дата выдачи паспорта|

### rchild (детский реестр читатей)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkccard|integer|Номер читательского билета ребенка (PK)|
|bcert|varchar(7)|Номер свидетельства о рождении (birth certificate)|
|releasecrt|date|Дата выдачи свидетельства о рождении|
|fkacard|integer|Читательский билет взрослого (FK)|

## sauthor (справочник авторов)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkidauthors|serial|Id автора (PK)|
|alastn|varchar(20)| Фамилия автора (n - name)|
|afirstn|varchar(20)|Имя автора|
|athirdn|varchar(20)|Отчество автора|
|acountry|varchar(20)|Страна автора|

### spublisher (справочник издательств)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkidpublisher|smallserial|Код издательства (PK)|
|pname|varchar(40)|Наименование издательства|
|paddress|varchar(40)|Адрес издательства|
|pphone|varchar(11)|Телефон|
|plastn|varchar(40)|Фамилия контакта|
|pfirstn|varchar(40)|Имя контакта|
|pthirdn|varchar(40)|Отчество контакта|

### sudc (справочник индексов УДК)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkidudc|varchar(20)|Индекс удк (PK)|
|udesc|varchar(20)|описание|

### cformat (каталог форматов)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkidformat|smallserial|Id формата (PK)|
|fname|varchar(20)|Название формата|

### cbinding (каталог переплетов)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkidbinding|smallserial|Id переплета (PK)|
|bname|varchar(20)|Наименование переплета|

### cgenre (каталог жанров)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|idgenres|smallserial|Id жанра (PK)|
|gname|varchar(20)|Название жанра|

### rbook (реестр книг)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkisbn|varchar(20)|Индетефикатор ISBN International Standard Book Number (PK)|
|bname| varchar(40)|Название книги|
|bypubl|numeric(4)|Год издания книги year public|
|bquantity|smallint|Колличество книг в библиотеке|
|fkcodepubl|smallint|Код издательства (code publisher) (FK) |
|fkudc|varchar(20)|Универсальная десятичная классификация УДК (FK)|
|fkidformat|smallint|Id формата (FK)|
|fkidbinding|smallint|ID переплета (FK)|

### authorbook (связующая таблица авторов и книг)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkfkabisbn|varchar(20)|Primary key Foreign key ISBN|
|pkfkauthor|integer|Primary key Foreign key author|

### genrebook (связующая таблица для жанров и книг)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|fkgbisbn|varchar(20)|Primary key Foreign key ISBN|
|fkgbidgenre|smallint|Primary key Foreign key ID жанра|


### instancebook (экземпляр книги - связующая таблица для читательского билета и книги)
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|pkibarcode|varchar(20)|Штрихкод EAN13 P5 (instance book) (PK)|
|iisbn|varchar(20)|Istance isbn|

### jlibticket (Читательский билет (журнал взятых книг))
-- несколько раз взять одну книгу - одна запись
-- одна книга в одни руки
|Столбец |Тип |Описание|
|:-------|:---|:-------|
|fktcard|integer|Pk номера билета для читательского билета|
|fktbarcode|varchar(20)|Pk экземпляра книги для читательского билета|
|dategive|date|Дата выдачи|
|datereturnexpect|date|Дата возврата ожидаемая|
|datereturnfact|date|Дата возврата фактическая|

## Связи
**Идентифицирующей** связью называется связь, позволяющая слабой сущности получить атрибуты, необходимые для ее идентификации. Обозначается сплошной линией.

* Книга – Жанр: один ко многим, идентифицирующая.
* Перечень Переплетов – Книга: один ко многим, неидентифицирующая.
* Перечень УДК – Книга: один ко многим, неидентифицирующая.
* Перечень Форматов – Книга: один ко многим, неидентифицирующая.
* Перечень Жанров - Жанр: один ко многим, идентифицирующая.
* Издательство – Книга: один ко многим, неидентифицирующая.
* Книга – Авторы Книги: один ко многим, идентифицирующая.
* Автор – Авторы Книги: один ко многим, идентифицирующая.
* Перечень Авторов – Авторы Книги: один ко многим, идентифицирующая.
* Книга – Экземпляр Книги: один ко многим, неидентифицирующая.
* Экземпляр Книги – Читательский Билет: один ко многим, идентифицирующая.
* Картотека – Читательский Билет: один ко многим, идентифицирующая.
* Картотека – Читатель Взрослый: супертип-подтип, атрибут-дискриминатор Номер Билета.
* Картотека – Читатель Ребенок: супертип-подтип, атрибут-дискриминатор Номер Билета.
* Читатель Взрослый – Читатель Ребенок: один ко многим, неидентифицирующая.

# ER-диаграмма
![er diagramm](/2_1-2_2_theory/diagrams/er-library-diagramm.drawio.png)

## Доказательство того, что все сущности в модели соответствуют нормализованным реляционным отношениям.
1.	Проверка на 1 НФ.
Во всех отношениях составных атрибутов нет, порядок строк и столбцов не несет в себе никакой информации, все столбцы имеют уникальные имена. Следовательно, все отношения находятся в 1 НФ.

2.	Проверка на 2 НФ.
Все отношени находится в 1 НФ и каждый неключевой атрибут функционально полно зависит от ее потенциального ключа. Следовательно, все отношения находятся во 2 НФ

3.	Проверка на 3 НФ.
Все отношения находятся во 2 НФ и не имеют транзитивные функциональных зависимостей неключевых атрибутов от ключевых. Следовательно, все отношения находятся в 3 НФ.

4.	Проверка на НФБК (Нормальная форма Бойса — Кодда).
Все отношения находятся в 3 НФ и все отношения либо содержат только один потенциальный ключ, либо не содержат пересекающихся потенциальных ключей, и во всех отношениях ключевые атрибуты не зависят от неключевых, следовательно они находятся в НФБК.
   
6.	Проверка на 4 НФ.
Все отношения находятся в НФБК и содержат менее трех атрибутов и/или содержат неключевые атрибуты, следовательно, все отношения находятся в 4 НФ.

7.	Проверка на 5 НФ.
Все отношения находятся в 4 НФ и содержат менее трех атрибутов и/или содержат неключевые атрибуты, следовательно, все отношения находятся в 4 НФ.


