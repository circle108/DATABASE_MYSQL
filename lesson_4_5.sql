-- Task 1
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	created_at DATETIME,
	updated_at DATETIME
);

INSERT INTO
	users (name, birthday_at, created_at, updated_at)
VALUES
	('Alex','', NULL, NULL),
	('Vika','1983-08-30', NULL, NULL),
	('Alex','2011-06-28', NULL, NULL),
	('YAr','2015-04-05', NULL, NULL);

SELECT * FROM users;

UPDATE 
	users 
SET
	created_at = NOW(),
	updated_at = NOW();

-- Task 2

ALTER TABLE 
	users 
MODIFY 
	created_at VARCHAR(150);

ALTER TABLE 
	users 
MODIFY 
	updated_at VARCHAR(150);

DESC users;

TRUNCATE users;

INSERT INTO
	users (name, birthday_at, created_at, updated_at)
VALUES
	('Alex','1981-07-08', '20.10.2017 8:10', '20.10.2017 8:10'),
	('Vika','1983-08-30', '20.10.2017 8:10', '20.10.2017 8:10'),
	('Alex','2011-06-28', '20.10.2017 8:10', '20.10.2017 8:10'),
	('YAr','2015-04-05', '20.10.2017 8:10', '20.10.2017 8:10');

UPDATE 
	users 
SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i');

UPDATE 
	users 
SET
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE
	users 
MODIFY
	created_at DATETIME DEFAULT NOW();

ALTER TABLE
	users 
MODIFY
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW();

SELECT * FROM users;
DESC users;

-- Task 3

TRUNCATE storehouses_products;
CREATE TABLE  storehouses_products (
	id SERIAL PRIMARY KEY,
	product VARCHAR(255),
	value INT UNSIGNED,
	storehouses_products_id INT UNSIGNED,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

INSERT INTO
	storehouses_products (product, value, storehouses_products_id)
VALUES
	('велосипед', 111, 1),
	('самокат', 0, 4),
	('беговел', 23, 3),
	('электросамокат', 52, 2),
	('гироскутер', 0, 3),
	('скейт', 0, 4);

SELECT * FROM storehouses_products ORDER BY IF(value = 0, 1, 0), value;


-- Агрегация
-- Task 1

SELECT 
	FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS averege_age 
FROM 
	users;

-- Task 2




