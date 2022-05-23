---*******************************************---
---******* CREACION DE BASE DE DATOS *********---
---*******************************************---

CREATE DATABASE FeriaDeLibro;
USE feriadelibro;


---*******************************************---
---********** CREACION DE TABLAS *************---
---*******************************************---

CREATE TABLE persona ( 
	tipoDoc varchar(10) NOT NULL,
	NroDocumento int(10) NOT NULL,
    nombre varchar(40),
    apellido varchar(40),
    fechaNacimiento date,
    telefono int(10),
    email varchar(60),
    PRIMARY KEY (tipoDoc, NroDocumento)
);

CREATE TABLE lector (
    actividad varchar(40) NOT NULL,
    tipoDoc varchar(10) NOT NULL,
	NroDocumento int(10) NOT NULL,
    FOREIGN KEY (tipoDoc, NroDocumento) REFERENCES persona(tipoDoc, NroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, NroDocumento)
);

CREATE TABLE encargado (
    legajo varchar(10) NOT NULL,
    tipoDoc varchar(10) NOT NULL,
	NroDocumento int(10) NOT NULL,
    FOREIGN KEY (tipoDoc, NroDocumento) REFERENCES persona(tipoDoc, NroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, NroDocumento)
);

CREATE TABLE libro ( 
	ISBN int NOT NULL,
    nombre varchar(20) NOT NULL,
    cantidadCopias int NOT NULL,
	portada varchar(100) NOT NULL,
    tipoDoc varchar(10) NOT NULL,
	NroDocumento int(10) NOT NULL,
    FOREIGN KEY (tipoDoc, NroDocumento) REFERENCES encargado(tipoDoc, NroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (ISBN)
);

CREATE TABLE copia_libro (
	nroCopia int NOT NULL,
    ISBN int NOT NULL,
    FOREIGN KEY (ISBN) REFERENCES libro(ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (nroCopia, ISBN)
);

CREATE TABLE tema (
	codigoIni int NOT NULL,
    codigoFin int NOT NULL,
    nombre varchar(10) NOT NULL,
    PRIMARY KEY (codigoIni, codigoFin)
);

CREATE TABLE feria (
	idFeria int NOT NULL AUTO_INCREMENT,
    fechaInicio date NOT NULL,
    horaApertura time NOT NULL,
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
	NroDocumento int(10) NOT NULL,
    nroCopia int NOT NULL,
    ISBN int NOT NULL,
    idFeria int NOT NULL,
    FOREIGN KEY (tipoDoc, NroDocumento) REFERENCES lector(tipoDoc, NroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (nroCopia, ISBN) REFERENCES copia_libro(nroCopia, ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (idFeria) REFERENCES feria(idFeria) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (numero)
);

CREATE TABLE refiere (
	motivo varchar(40) NOT NULL,
    tipoDoc varchar(10) NOT NULL,
	NroDocumento int(10) NOT NULL,
    ISBN int NOT NULL,
    FOREIGN KEY (tipoDoc, NroDocumento) REFERENCES lector(tipoDoc, NroDocumento) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ISBN) REFERENCES libro(ISBN) ON
    UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (tipoDoc, NroDocumento, ISBN)
);


---*******************************************---
---************* CONSULTAS *******************---
---*******************************************---

USE feriadelibro;

-- Inserto una persona en la tabla persona
INSERT INTO persona (tipoDoc, NroDocumento, nombre, apellido, fechaNacimiento, telefono) 
VALUES ("DNI", 41568728, "Pepito", "Director", "1999-12-10", 299567426);

-- Agregar un lector a la base de datos. Tener en cuenta las restricciones de acuerdo a su DDL
INSERT INTO lector (actividad, tipoDoc, NroDocumento) 
VALUES ("leer", "DNI", 41568728);

-- Insertar un nuevo tema en la tabla tema
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (1, 2, "Terror");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (3, 4, "Pasion");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (5, 6, "Romance");
INSERT INTO tema(codigoIni, codigoFin, nombre)
VALUES (7, 8, "Comedia");

-- Insertar una feria en la tabla Feria 'HH:MM:SS'
INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-06-24", "10:00:00", 1, 2);
INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-06-24", "11:00:00", 3, 4);
INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-06-24", "12:00:00", 5, 6);
INSERT INTO feria(fechaInicio, horaApertura, codigoIni, codigoFin)
VALUES ("2022-06-24", "13:00:00", 7, 8);

-- Actualizar la Hora de las ferias del viernes 24 de Junio de 2022: hora a actualizar 14:00
UPDATE feria SET horaApertura = "14:00:00" WHERE idFeria = 1;
UPDATE feria SET horaApertura = "14:00:00" WHERE idFeria = 2;
UPDATE feria SET horaApertura = "14:00:00" WHERE idFeria = 3;
UPDATE feria SET horaApertura = "14:00:00" WHERE idFeria = 4;