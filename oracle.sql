-- INSERT ANSI SQL (menos rapido)
INSERT INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'INTO1', 'INTO1');
INSERT INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'INTO2', 'INTO2');
INSERT INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'INTO3', 'INTO3');

-- INSERT ALL inserta tantos registros tantas veces como numero de registros haya en la tabla obejetivo, utilizando la tabla comodin DUAL se evita este problema; 
INSERT ALL
    INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'ALL', 'ALL')
    INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'ALL2', 'ALL2')
    INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'ALL3', 'ALL3')
SELECT * FROM dual;

rollback;

SELECT * FROM dept;

-- CREATE SELECT
CREATE TABLE DEPARTAMENTOS
AS
SELECT *
FROM dept;

SELECT * FROM DEPARTAMENTOS;
SELECT * FROM dept;
DROP TABLE DEPARTAMENTOS;
desc departamentos;
desc dept;

CREATE TABLE DOCTORESHOSPITAL
AS
SELECT d.doctor_no AS IDDOCTOR, d.apellido, h.telefono, h.nombre
FROM doctor d
JOIN hospital h
ON d.hospital_cod = h.hospital_cod;

SELECT * FROM DOCTORESHOSPITAL;


-- INSERT INTO SELECT se necesita que la tabla destino exista y tenga la misma estructura que la tabla origen

INSERT INTO DEPARTAMENTOS
SELECT * FROM dept;

SELECT &campo1 FROM emp;

-- NATURAL JOIN

SELECT apellido, oficio, dnombre, loc, dept_no
FROM emp
NATURAL JOIN dept;

SELECT sys_context('userenv', 'current_user') FROM dual;
show PARAMETER nls;
show PARAMETER nls_comp;
show PARAMETER nls_sort;

-- Recuperacion jerarquica de datos
-- Mostrar los empleados subordinados al empleado con apellido 'JIMENEZ'
SELECT LEVEL AS NIVEL, apellido, dir, oficio
FROM emp
CONNECT BY emp_no = PRIOR dir
START WITH apellido = 'jimenez'
ORDER BY 1;

-- Mostrar todos los jefes de Arroyo
SELECT LEVEL AS NIVEL, apellido, dir, oficio, SYS_CONNECT_BY_PATH(apellido, '----') AS jerarquia
FROM emp
CONNECT BY emp_no = PRIOR dir
START WITH apellido = 'arroyo'
ORDER BY 1;

-- INTERSECT devuelve los registros que aparecen en ambas tablas
-- MINUS devuelve los registros que aparecen en la primera tabla y no en la segunda
SELECT * 
FROM plantilla
WHERE turno = 'T'
INTERSECT
SELECT *
FROM plantilla
WHERE funcion = 'ENFERMERA'; 

SELECT * 
FROM plantilla
WHERE turno = 'T'
MINUS
SELECT *
FROM plantilla
WHERE funcion = 'ENFERMERA'; 

-- SEQUENCE Campo de autoincremento en Oracle. 

CREATE SEQUENCE SEQ_DEPT
INCREMENT BY 10
START WITH 50;

SELECT SEQ_DEPT.NEXTVAL AS siguiente FROM dual;

SELECT SEQ_DEPT.CURRVAL AS actual FROM dual;

INSERT INTO dept VALUES (SEQ_DEPT.NEXTVAL, 'NUEVO', 'NUEVO');

SELECT * FROM dept;

DELETE FROM dept WHERE dnombre = 'NUEVO';

DROP SEQUENCE SEQ_DEPT;


-- PRACTICA: 
-- AÑADIR PK HOSPITAL
-- AÑADIR PK DOCTOR 
-- RELACIONAR HOSPITAL y DOCTOR
-- LAS PERSONAS DE LA PLANTILLA SOLAMENTE PUEDEN TRABAJAR EN TURNO DE MAÑANA TARDE O NOCHE

desc hospital;
desc doctor;

ALTER TABLE hospital 
ADD CONSTRAINT PK_HOSPITAL
PRIMARY KEY (hospital_cod);

ALTER TABLE doctor
ADD CONSTRAINT PK_DOCTOR
PRIMARY KEY (doctor_no);

ALTER TABLE doctor
ADD CONSTRAINT FK_DOCTOR_HOSPITAL
FOREIGN KEY (hospital_cod)
REFERENCES hospital (hospital_cod);

ALTER TABLE plantilla 
ADD CONSTRAINT CH_TURNO_PLANTILLA
CHECK (turno IN ('T','N','M'));

