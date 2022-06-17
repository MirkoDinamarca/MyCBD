-- *******************************************---
-- ******* CREACION DE BASE DE DATOS *********---
-- *******************************************---

CREATE DATABASE FeriaDeLibro;
USE feriadelibro;


-- *******************************************---
-- ********** CREACION DE TABLAS *************---
-- *******************************************---

CREATE TABLE persona ( 
	tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    nombre varchar(40),
    apellido varchar(40),
    fechaNacimiento date,
    telefono int,
    email varchar(60),
    PRIMARY KEY (tipoDoc, nroDocumento)
);

CREATE TABLE lector (
    actividad varchar(40),
    tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    FOREIGN KEY (tipoDoc, nroDocumento) REFERENCES persona(tipoDoc, nroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, nroDocumento)
);

CREATE TABLE encargado (
    legajo varchar(10) NOT NULL,
    tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    FOREIGN KEY (tipoDoc, nroDocumento) REFERENCES persona(tipoDoc, nroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, nroDocumento)
);

CREATE TABLE libro ( 
	ISBN int NOT NULL,
    nombre varchar(50),
    cantidadCopias int,
	portada varchar(100),
    tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    FOREIGN KEY (tipoDoc, nroDocumento) REFERENCES encargado(tipoDoc, nroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (ISBN)
);

CREATE TABLE copia_libro (
	nroCopia int NOT NULL,
    ISBN int NOT NULL,
    nroMesa int,
    FOREIGN KEY (ISBN) REFERENCES libro(ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (nroCopia, ISBN)
);

CREATE TABLE tema (
	codigoIni int NOT NULL,
    codigoFin int NOT NULL,
    nombre varchar(20),
    PRIMARY KEY (codigoIni, codigoFin)
);

CREATE TABLE feria (
	idFeria int NOT NULL AUTO_INCREMENT,
    fechaInicio date,
    horaApertura time,
    codigoIni int NOT NULL,
    codigoFin int NOT NULL,
    FOREIGN KEY (codigoIni, codigoFin) REFERENCES tema(codigoIni, codigoFin) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (idFeria)
);

CREATE TABLE lectura (
	numero int NOT NULL AUTO_INCREMENT,
	fechaLectura date,
    tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    nroCopia int,
    ISBN int NOT NULL,
    idFeria int NOT NULL,
    FOREIGN KEY (tipoDoc, nroDocumento) REFERENCES lector(tipoDoc, nroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (nroCopia, ISBN) REFERENCES copia_libro(nroCopia, ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (idFeria) REFERENCES feria(idFeria) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (numero)
);

CREATE TABLE prefiere (
	motivo varchar(40),
    tipoDoc varchar(10) NOT NULL,
	nroDocumento int NOT NULL,
    ISBN int NOT NULL,
    FOREIGN KEY (tipoDoc, nroDocumento) REFERENCES lector(tipoDoc, nroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ISBN) REFERENCES libro(ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, nroDocumento, ISBN)
);


-- *******************************************---
-- ************* CONSULTAS *******************---
-- *******************************************---

-- Creamos Personas

INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 41568728, "Pepito", "Director", "1999-12-10", 299567426);

INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 45687911, "Roberto", "Alfonso", "2002-12-10", 299687941);

INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 700000, "Mirta", "Legrant", "1925-05-05", 299487852);

INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 35849877, "Max", "Milano", "1980-07-03", 299584941);

-- Personas que van a ser Lectorxs
INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 45238921, "Pablito", "Kevingston", "1999-12-10", 299857428);

INSERT INTO persona (tipoDoc, nroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 20587701, "Carlos", "Buenamante", "1995-11-03", 299386991);

-- 3-A Agregar un lector a la base de datos. Tener en cuenta las restricciones de acuerdo a su DDL
INSERT INTO lector (actividad, tipoDoc, nroDocumento) VALUES ("leer", "DNI", 41568728);
INSERT INTO lector (actividad, tipoDoc, nroDocumento) VALUES ("resumir", "DNI", 45238921);
INSERT INTO lector (actividad, tipoDoc, nroDocumento) VALUES ("subrayar", "DNI", 20587701);

-- Insertar un nuevo tema en la tabla tema
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (1, 2, "Terror");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (3, 4, "Romance");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (5, 6, "Ciencia");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (7, 8, "Comedia");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (9, 10, "Ciencia Ficcion");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (11, 12, "sociedad");

-- Insertar una feria en la tabla Feria 'HH:MM:SS'
INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-08-12", "10:00:00", 1, 2);

INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-09-05", "11:00:00", 3, 4);

INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-12-10", "12:00:00", 5, 6);

INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-06-24", "13:00:00", 7, 8);

INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-04-01", "08:00:00", 11, 12);

INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-04-20", "10:00:00", 11, 12);


-- Creamos Encargados
INSERT INTO encargado (legajo, tipoDoc, nroDocumento) 
VALUES (5555, "DNI", 700000);

INSERT INTO encargado (legajo, tipoDoc, nroDocumento) 
VALUES (4354, "DNI", 45687911);

INSERT INTO encargado (legajo, tipoDoc, nroDocumento) 
VALUES (3315, "DNI", 35849877);

INSERT INTO encargado (legajo, tipoDoc, nroDocumento) 
VALUES (4546, "DNI", 41568728);

-- Creamos libros
INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (3333, "50 sombras de gray", 15200000, "Romance", "DNI", 700000);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (2546, "Como salir de LATAM", 458791, "Guerra", "DNI", 45687911);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (1487, "Programar en 5 minutos", 1546, "Accion", "DNI", 41568728);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (5497, "Viaje al centro de la tierra", 50000, "Ciencia", "DNI", 41568728);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (7941, "Leyes de Newton", 58790, "Ciencia", "DNI", 45687911);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (8416, "Teoria de la relatividad", 549499, "Ciencia", "DNI", 45687911);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (8917, "Como caminar en la calle", 98788, "Vivimos en una sociedad, donde el honor es un recuerdo lejano", "DNI", 41568728);

INSERT INTO libro (ISBN, nombre, cantidadCopias, portada, tipoDoc, nroDocumento ) 
VALUES (3215, "Como dormir", 95365, "Gracias a la sociedad cada vez dormimos peor", "DNI", 700000);

-- 3-B Actualizar la Hora de las ferias del viernes 24 de Junio de 2022: hora a actualizar 14:00
UPDATE feria SET horaApertura = "14:00:00" WHERE fechaInicio = "2022-06-24";

-- 3-C Borramos encargados que nunca fueron responsables de libros
DELETE FROM encargado WHERE NOT EXISTS (SELECT * FROM libro WHERE encargado.NroDocumento = libro.NroDocumento);

-- EJERCICIO 4

-- Crear copias de libros
INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (25, 5497, 5);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (60, 8416, 10);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (15, 1487, 20);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (10, 3333, 30);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (52, 7941, 45);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (300, 8917, 50);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (200, 3215, 95);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (680, 3215, 95);

INSERT INTO copia_libro (nroCopia, ISBN, nroMesa) 
VALUES (1000, 8917, 50);


-- Crear lecturas
INSERT INTO lectura (fechaLectura, tipoDoc, nroDocumento, nroCopia, ISBN, idFeria)
VALUES ("2022-08-13", "DNI", 45238921, 25, 5497, 1);

INSERT INTO lectura (fechaLectura, tipoDoc, nroDocumento, nroCopia, ISBN, idFeria)
VALUES ("2022-12-10", "DNI", 45238921, 60, 8416, 3);

INSERT INTO lectura (fechaLectura, tipoDoc, nroDocumento, nroCopia, ISBN, idFeria)
VALUES ("2022-06-25", "DNI", 20587701, 10, 3333, 4);

INSERT INTO lectura (fechaLectura, tipoDoc, nroDocumento, nroCopia, ISBN, idFeria)
VALUES ("2022-04-30", "DNI", 45238921, 1000, 8917, 5);

INSERT INTO lectura (fechaLectura, tipoDoc, nroDocumento, nroCopia, ISBN, idFeria)
VALUES ("2022-05-25", "DNI", 20587701, 680, 3215, 6);

-- 4-A 

SELECT numero AS numeroLectura, nroCopia, ISBN, lectura.idFeria FROM lectura 
INNER JOIN feria ON lectura.idFeria = feria.idFeria 
WHERE DATEDIFF(fechaLectura,fechaInicio) = 1;

-- 4-B
SELECT copia_libro.ISBN, nroCopia, nroMesa FROM copia_libro INNER JOIN libro ON libro.ISBN = copia_libro.ISBN 
WHERE NOT EXISTS (SELECT * FROM lectura WHERE copia_libro.ISBN = lectura.ISBN) AND
libro.portada LIKE "%ciencia%";

-- 4-C
SELECT COUNT(*) AS cantidadFerias, tema.codigoIni, nombre FROM tema 
INNER JOIN feria ON feria.codigoIni = tema.codigoIni 
WHERE fechaInicio >= "2022-01-01" AND fechaInicio <= "2022-12-31" GROUP BY tema.nombre;

-- 4-D 
SELECT COUNT(*) AS lecturasRealizadas, fechaLectura FROM lectura 
INNER JOIN feria ON feria.idFeria = lectura.idFeria
WHERE fechaInicio >= "2022-04-01" AND fechaInicio <= "2022-04-30" AND
codigoIni IN (SELECT codigoIni FROM tema WHERE tema.nombre LIKE "%sociedad%")
GROUP BY fechaLectura;