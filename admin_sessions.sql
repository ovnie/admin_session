-- Création de la base admin_sessions, de l'user admin et de l'user jeffrey :
CREATE DATABASE admin_sessions;
show databases;
CREATE USER 'admin'@'localhost' IDENTIFIED BY '#@FikL2wG9?6';
GRANT ALL ON *.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY '#@SikLGwS9?6';
GRANT SELECT ON admin_sessions.* TO 'jeffrey'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'admin'@'localhost';
SHOW GRANTS FOR 'jeffrey'@'localhost';

-- Création de la table des différents cinémas :
use admin_sessions;
CREATE TABLE cinemas (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
	codezip INT NOT NULL,
	phone INT NOT NULL,
	address TEXT NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
show tables;
show columns from cinemas;
INSERT INTO cinemas(name, city, codezip, phone, address) VALUES ("Pathé Toulon", "Toulon", "83000", "0892696696", "265 Bd du Maréchal Leclerc");
INSERT INTO cinemas(name, city, codezip, phone, address) VALUES ("Pathé La Valette", "La Valette", "83160", "0892696696", "300 Av. de l'Université");
INSERT INTO cinemas(name, city, codezip, phone, address) VALUES ("Pathé Bellecour", "Lyon", "69002", "0892696696", "79 Rue de la République");
SELECT * FROM cinemas;

-- Création de la table des administrateurs pour les différents cinémas :
CREATE TABLE administrators (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	phone INT NOT NULL,
	id_cinemas_administrators INT NOT NULL,
	FOREIGN KEY (id_cinemas_administrators) REFERENCES cinemas (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
show columns from administrators;
INSERT INTO administrators(name, phone, administrators.id_cinemas_administrators) VALUES ("Charles Aznavour", "0639302701", "3");
INSERT INTO administrators(name, phone, administrators.id_cinemas_administrators) VALUES ("Patrick Fiori", "0639451930", "1");
INSERT INTO administrators(name, phone, administrators.id_cinemas_administrators) VALUES ("Mylène Farmer", "0690231830", "2");
SELECT * FROM administrators;
SELECT * FROM administrators INNER JOIN cinemas ON cinemas.Id = administrators.id_cinemas_administrators;
SELECT * FROM administrators INNER JOIN cinemas AS admin_cinemas ON admin_cinemas.Id = administrators.id_cinemas_administrators;

-- Création de la table des salles pour les différents cinémas :
CREATE TABLE rooms (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	places INT NOT NULL,
	id_cinemas_rooms INT NOT NULL,
	FOREIGN KEY (id_cinemas_rooms) REFERENCES cinemas (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO rooms(name, places, id_cinemas_rooms) VALUES ("A", "24", "1");
INSERT INTO rooms(name, places, id_cinemas_rooms) VALUES ("B", "36", "1");
INSERT INTO rooms(name, places, id_cinemas_rooms) VALUES ("A", "17", "2");
INSERT INTO rooms(name, places, id_cinemas_rooms) VALUES ("A", "20", "3");
SELECT * FROM rooms;
SELECT * FROM rooms INNER JOIN cinemas ON cinemas.Id = rooms.id_cinemas_rooms;

-- Création de la table des films pour les différentes salles des différents cinémas :
CREATE TABLE movies (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	id_rooms_movies INT NOT NULL,
	FOREIGN KEY (id_rooms_movies) REFERENCES rooms (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO movies(name, id_rooms_movies) VALUES ("James Bond 007", "2");
INSERT INTO movies(name, id_rooms_movies) VALUES ("James Bond 007", "1");
INSERT INTO movies(name, id_rooms_movies) VALUES ("Ester", "4");
INSERT INTO movies(name, id_rooms_movies) VALUES ("Cube", "3");
SELECT * FROM movies INNER JOIN rooms ON rooms.Id = movies.id_rooms_movies INNER JOIN cinemas ON cinemas.Id = rooms.id_cinemas_rooms;

-- Création de la table des tarifs :
CREATE TABLE prices (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	rate DECIMAL(3,2) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO prices(rate) VALUES ("9.20");
INSERT INTO prices(rate) VALUES ("7.60");
INSERT INTO prices(rate) VALUES ("5.90");
SELECT * FROM prices;

-- Création de la table des clients :
CREATE TABLE customers (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	age INT NOT NULL,
	student BOOLEAN NOT NULL,
	id_movies_customers INT NOT NULL,
	id_prices_customers INT NOT NULL,
	FOREIGN KEY (id_movies_customers) REFERENCES movies (id),
	FOREIGN KEY (id_prices_customers) REFERENCES prices (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO customers(name, age, student, id_movies_customers, id_prices_customers) VALUES ("Charlène", "13", TRUE, "1", "3");
INSERT INTO customers(name, age, student, id_movies_customers, id_prices_customers) VALUES ("James", "15", TRUE, "2", "2");
INSERT INTO customers(name, age, student, id_movies_customers, id_prices_customers) VALUES ("Karen", "30", FALSE, "4", "1");
SELECT * FROM customers;
SELECT * FROM customers INNER JOIN movies ON movies.Id = id_movies_customers INNER JOIN rooms ON rooms.Id = movies.id_rooms_movies INNER JOIN cinemas ON cinemas.Id = rooms.id_cinemas_rooms;

-- Création d'une base vide pour la restauration :
CREATE DATABASE admin_sessions_2;