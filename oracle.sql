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



