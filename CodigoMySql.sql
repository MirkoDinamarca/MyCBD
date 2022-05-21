CREATE DATABASE FeriaDeLibro;
USE feriadelibro;

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