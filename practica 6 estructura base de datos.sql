CREATE TABLE COLEGIO (
    cod_colegio NUMBER PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL,
    localidad VARCHAR2(15),
    provincia VARCHAR2(15),
    año_construccion DATE,
    coste_construccion NUMBER,
    cod_region NUMBER,
    unico NUMBER,
    UNIQUE (unico)
);

INSERT INTO COLEGIO (cod_colegio, nombre, localidad, provincia, año_construccion, coste_construccion, cod_region, unico)
VALUES (SEQ_COLEGIO.NEXTVAL, 'Colegio San Jose', 'Madrid', 'Madrid', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1000000, 1, 1);
INSERT INTO COLEGIO (cod_colegio, nombre, localidad, provincia, año_construccion, coste_construccion, cod_region, unico)
VALUES (SEQ_COLEGIO.NEXTVAL, 'Colegio Santa Maria', 'Barcelona', 'Barcelona', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 1500000, 2, 2);
INSERT INTO COLEGIO (cod_colegio, nombre, localidad, provincia, año_construccion, coste_construccion, cod_region, unico)
VALUES (SEQ_COLEGIO.NEXTVAL, 'Colegio La Salle', 'Alicante', 'Alicante', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 2000000, 3, 3);

CREATE SEQUENCE SEQ_COLEGIO
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE PROFESOR (
    cod_profesor VARCHAR2(10) PRIMARY KEY NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    apellido1 VARCHAR2(50),
    apellido2 VARCHAR2(50),
    dni CHAR(9),
    edad NUMBER,
    localidad VARCHAR2(50),
    provincia VARCHAR2(50),
    salario NUMBER,
    cod_colegio NUMBER,
    CONSTRAINT FK_PROFESOR_COLEGIO FOREIGN KEY (cod_colegio) REFERENCES COLEGIO(cod_colegio),
    UNIQUE (dni)
);

CREATE TABLE REGION (
    cod_region NUMBER PRIMARY KEY,
    regiones VARCHAR2(20) NOT NULL
);

CREATE SEQUENCE SEQ_REGION
    START WITH 1
    INCREMENT BY 1;

INSERT INTO REGION (cod_region, regiones)
VALUES (SEQ_REGION.NEXTVAL, 'Madrid');
INSERT INTO REGION (cod_region, regiones)
VALUES (SEQ_REGION.NEXTVAL, 'Cataluña');
INSERT INTO REGION (cod_region, regiones)
VALUES (SEQ_REGION.NEXTVAL, 'Alicante');

CREATE TABLE ALUMNO (
    dni CHAR(9) PRIMARY KEY NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(50),
    fecha_ingreso DATE,
    fecha_nacimiento DATE,
    localidad VARCHAR2(15),
    provincia VARCHAR2(30),
    cod_colegio NUMBER,
    CONSTRAINT FK_ALUMNO_COLEGIO FOREIGN KEY (cod_colegio) REFERENCES COLEGIO(cod_colegio)
);

ALTER TABLE COLEGIO
ADD CONSTRAINT FK_COLEGIO_REGION FOREIGN KEY (cod_region) REFERENCES REGION(cod_region);

ALTER TABLE PROFESOR
ADD (sexo CHAR(1) CHECK (sexo IN ('H', 'M')),
     direccion VARCHAR2(50),
     estado_civil VARCHAR2(10) CHECK (estado_civil IN ('Soltero', 'Casado', 'Viudo', 'Divorciado')));

ALTER TABLE PROFESOR
DROP COLUMN edad;

ALTER TABLE PROFESOR
DROP CONSTRAINT FK_PROFESOR_COLEGIO;

ALTER TABLE PROFESOR
ADD CONSTRAINT FK_PROFESOR_COLEGIO FOREIGN KEY (cod_colegio) 
REFERENCES COLEGIO(cod_colegio) 
ON DELETE CASCADE;

ALTER TABLE ALUMNO
MODIFY fecha_ingreso DATE DEFAULT SYSDATE;

INSERT ALL 
    INTO ALUMNO (dni, nombre, apellidos, fecha_ingreso, fecha_nacimiento, localidad, provincia, cod_colegio)
    VALUES ('12345678A', 'Ana', 'Ortiz Ortega', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2005-05-05', 'YYYY-MM-DD'), 'Madrid', 'Madrid', 2) 
    INTO ALUMNO (dni, nombre, apellidos, fecha_ingreso, fecha_nacimiento, localidad, provincia, cod_colegio)
    VALUES ('23456789B', 'Javier', 'Chuko Palomo', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2006-06-06', 'YYYY-MM-DD'), 'Arenales de Sol', 'Alicante', 4)
    INTO ALUMNO (dni, nombre, apellidos, fecha_ingreso, fecha_nacimiento, localidad, provincia, cod_colegio)
    VALUES ('34567890C', 'Miguel', 'Torres Tormo', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2007-07-07', 'YYYY-MM-DD'), 'Barcelona', 'Barcelona', 3)
SELECT * FROM DUAL;
desc ALUMNO;

DROP TABLE REGION;
-- no se puede borrar la tabla REGION porque es clave foránea de COLEGIO

DROP TABLE COLEGIO CASCADE CONSTRAINTS;
DROP TABLE PROFESOR CASCADE CONSTRAINTS;
DROP TABLE ALUMNO CASCADE CONSTRAINTS;
DROP TABLE REGION CASCADE CONSTRAINTS;