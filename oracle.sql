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

--INCLUIMOS UNA RESTRICCION PRIMARY KEY EN EL CAMPO
--DEPT_NO DE DEPARTAMENTOS PARA QUE NO PUEDA ADMITIR NULOS
alter table DEPT
add constraint PK_DEPT
primary key (DEPT_NO);

delete from DEPT where dept_no=10;
commit;

--TODAS LAS RESTRICCIONES DEL USUARIO SE ENCUENTRAN EN EL DICCIONARIO
--USER_CONSTRAINTS
select * from USER_CONSTRAINTS
WHERE CONSTRAINT_NAME LIKE 'PK%';
--INTENTAMOS INSERTAR UN DEPARTAMENTO REPETIDO
insert into DEPT values (10, 'REPE', 'REPE');
select * from DEPT;
--ELIMINAMOS LA RESTRICCION DE PRIMARY KEY DE DEPARTAMENTOS
alter table DEPT
drop constraint PK_DEPT;

--CREAMOS UNA PRIMARY KEY PARA EL CAMPO EMP_NO
alter table EMP
add constraint PK_EMP
primary key (EMP_NO);

--CREAMOS UNA RESTRICCION PARA COMPROBAR QUE EL SALARIO SIEMPRE SEA POSITIVO
--CH_TABLA_CAMPO
alter table EMP
add constraint CH_EMP_SALARIO
check (SALARIO >= 0);

--PONEMOS UN VALOR NEGATIVO A UN EMPLEADO
update EMP set SALARIO = null where EMP_NO=7782;

alter table EMP
drop constraint CH_EMP_SALARIO;

select * from EMP;

-----------------------------------------ENFERMO

--PK
alter table ENFERMO
add constraint PK_ENFERMO
primary key (INSCRIPCION);
--UNIQUE PARA EL DATO DE NSS, SEGURIDAD SOCIAL
alter table ENFERMO
add constraint U_ENFERMO_NSS
unique (NSS);
--ELIMINAMOS LAS DOS RESTRICCIONES ANTERIORES
alter table ENFERMO
drop constraint PK_ENFERMO;
alter table ENFERMO
drop constraint U_ENFERMO_NSS;
--CREAMOS UNA PRIMARY KEY DE DOS COLUMNAS
alter table ENFERMO
add constraint PK_ENFERMO
primary key (INSCRIPCION, NSS);
--INTENTAMOS CREAR UN REGISTRO CON DOS DATOS IGUALES DE INSCRIPCION Y NSS
insert into ENFERMO values
(10995, 'KKKK', 'Goya 20', '16/05/1956', 'M', '280862482');
--
insert into ENFERMO values
(88999, 'Languia M.', 'Goya 20', '16/05/1956', 'M', '280862482');
--QUITAMOS LOS NULL PARA REALIZAR LA INSCRIPCION
delete from ENFERMO where NSS is null;
commit;
select * from ENFERMO;
rollback;
--no podemos repetir PK
insert into ENFERMO values
(10995, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '123');
--no podemos repetir Unique
insert into ENFERMO values
(10999, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '280862482');
--nulos en pk?? NO
insert into ENFERMO values
(null, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '123');
--nulos en unique?? POR SUPUESTO SI LA COLUMNA LO ADMITE
insert into ENFERMO values
(12346, 'Nuevo null', 'Calle nueva', '01/01/2000', 'F', null);


describe enfermo;

select * from ENFERMO;

-----------------------FOREIGN KEY----------------
--CREAMOS UNA RELACION ENTRE EMPLEADOS Y DEPARTAMENTOS
--EL CAMPO DE RELACION ES DEPT_NO
alter table EMP
add constraint FK_EMP_DEPT
foreign key (DEPT_NO)
references DEPT (DEPT_NO)
on delete set null;
--on delete CASCADE;

--VAMOS A PROBAR LA ELIMINACION EN CASCADA Y SET NULL EN CASCADA
delete from DEPT where DEPT_NO=10;
SELECT * FROM emp;
rollback;

alter table EMP
drop constraint FK_EMP_DEPT;


insert into DEPT values (10, 'CONTABILIDAD', 'ELCHE');
--INSERTAMOS UN EMPLEADO EN UN DEPARTAMENTO QUE NO EXISTE
insert into EMP values (1112, 'nulo', 'EMPLEADO', 7902, '02/04/2025', 1, 1, null);

SELECT * FROM dept;
describe emp;
rollback;

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


show con_name;
show pdbs;

/* Prefijos

USER_   - Los objetos del esquema (= usuario)
ALL_    - Los objetos del esqema/usuario y de otros esquemas en los que el usuario tiene algún privilegio
DBA_    - Todos los objetos de la instancia (sólo visible por los DBAs)

-- Multitenant

CDB_    - Todos los objetos de todos los contenedores si la sesión está en el contenedor: cdb$root
          Todos los objetos del contenedor en el que se encuentra la sesión, si es una PDB (Pluggable Database)
DBA_    - Todos los objetos del contenedor en el que se encuentra la sesión

Contenedor 1 > cdb$root
Contenedor 2 > pdb$seed
Contenedores 3+ > PDBs

show con_id
show con_name

-- TABLAS PRINCIPALES PARA CONSULTA/DESARROLLO
*_objects      - Toodos los objetos
*_tables       - Las tablas
*_tab_columns  - Columnas de las tablas
*_constraints  - Restricciones
*_cons_columns - Columnas de las restricciones
*_views        - Vistas
*_indexes      - Índices
*_ind_columns  - Columnas de los índices
*_synonyms     - Sinónimos
*_sequences    - Secuencias
*_tab_comments - Comentarios de las tablas
*_col_comments - Comentarios de las columnas de las tablas

*/

SELECT * FROM dict; 
SELECT * FROM user_tables;
SELECT * FROM user_tab_columns;
SELECT * FROM user_objects;
SELECT * FROM user_constraints;
SELECT * FROM user_cons_columns;
SELECT * FROM user_views;
SELECT * FROM user_indexes;
SELECT * FROM user_ind_columns;
SELECT * FROM user_synonyms;
SELECT * FROM user_sequences;



-- DIA 10 
-- Funciones de Oracle
-- Desarrollo PL/SQL (CODIGO)

-- Funciones conversion mayusculas y minusculas 
SELECT * FROM emp
WHERE lower(oficio) = 'analista';


SELECT * FROM emp
WHERE upper(oficio) = upper('anaLISTA');

-- Concatenar textos en una sola columna (campo calculado)
SELECT apellido || ' ' || oficio AS oficio FROM emp;
SELECT concat(apellido, oficio) AS oficio FROM emp;

-- INITCAP inicializa la primera letra de cada palabra en mayúscula
SELECT initcap(oficio) FROM emp;
SELECT initcap(apellido || ' ' || oficio) AS oficio FROM emp;

-- SUBSTR devuelve una subcadena de un string
SELECT substr(apellido, 1, 3) FROM emp;
SELECT substr('FLORERO', 1, 4) AS dato FROM dual;

-- mostrar empleados con apellidos que empiecen por 's'
SELECT * 
FROM emp
WHERE apellido LIKE 's%';

SELECT * 
FROM emp
WHERE substr(apellido, 1, 1) = 's';

-- LENGTH devuelve la longitud de un string
SELECT length(apellido) AS APELLIDO, apellido 
FROM emp;

SELECT apellido 
FROM emp
WHERE apellido LIKE '____';

SELECT apellido 
FROM emp
WHERE length(apellido) = 4;

-- INSTR devuelve la posición de un string dentro de otro
SELECT instr('BENITO', 'NI') AS POSICION
FROM dual;

-- LPAD devuelve un string con espacios a la izquierda
-- RPAD devuelve un string con espacios a la derecha
SELECT lpad('123', 6) AS LPAD FROM dual;
SELECT rpad('123', 6, '.') AS RPAD FROM dual;

-- ROUND redondea un número a la unidad más cercana
SELECT round(123.456) AS REDONDEO FROM dual; -- 123
SELECT round(123.567) AS REDONDEO FROM dual; -- 124
SELECT round(123.456 , 2) AS REDONDEO FROM dual; -- 123.46
SELECT round(123.456 , 1) AS REDONDEO FROM dual; -- 123.5
SELECT round(123.456 , -1) AS REDONDEO FROM dual; -- 120
SELECT round(125.456 , -1) AS REDONDEO FROM dual; -- 130

-- TRUNC trunca un número a la unidad más cercana
SELECT trunc(123.456) AS TRUNC FROM dual; -- 123
SELECT trunc(123.467, 1) AS TRUNC FROM dual; -- 123.4

-- MOD devuelve el resto de una división (sirve para saber si un numero es par o impar)
SELECT mod(10, 2) AS MOD FROM dual; -- 0 (Par)
SELECT mod(9, 2) AS MOD FROM dual; -- 1 (impar)

-- Mostrar los empleados cuyo salario sea par 
SELECT * FROM emp
WHERE mod(salario, 2) = 0;

-- SYSDATE devuelve la fecha y hora del sistema
SELECT sysdate FROM dual;
SELECT sysdate + 1 FROM dual; -- Sumar un día
SELECT sysdate + 1/24 FROM dual; -- Sumar una hora
SELECT sysdate + 60 FROM dual; -- Sumar 60 días 

-- MONTHS_BETWEEN devuelve el número de meses entre dos fechas
SELECT months_between(sysdate, '01/01/2023') AS MESES FROM dual;

-- ADD_MONTHS devuelve una fecha sumando un número de meses a otra fecha
SELECT add_months(sysdate, 1) AS MESES FROM dual; -- Sumar un mes

-- NEXT_DAY devuelve el siguiente día de la semana de una fecha
SELECT next_day(sysdate, 'Lunes') AS LUNES FROM dual; -- ALTER SESSION SET NLS_LANGUAGE = 'ENGLISH';

-- LAST_DAY devuelve el último día del mes de una fecha
SELECT last_day(sysdate) AS ULTIMO FROM dual; -- Último día del mes actual

-- TO_CHAR convierte un número o una fecha a un string
SELECT sysdate FROM dual; -- Fecha y hora del sistema
SELECT to_char(sysdate, 'dd/mm/yyyy') AS FECHA FROM dual; -- Fecha en formato DD/MM/YYYY
SELECT to_char(sysdate, 'dd/mm/yyyy hh:mi:ss') AS FECHA FROM dual; -- Fecha y hora en formato DD/MM/YYYY HH24:MI:SS
SELECT to_char(sysdate, 'j') AS FECHA FROM dual;

SELECT to_char(sysdate, 'day "de" month "del" yyyy', 'nls_date_language = SPANISH') AS FECHA FROM dual; 

-- formato a numeros
SELECT to_char(123, '000L') AS NUMERO FROM dual; -- 123456789.12

-- NLV devuelve el valor de una variable de entorno
SELECT nvl(comision, 0), comision AS comision FROM emp; -- Si el primer parámetro es nulo devuelve el segundo
SELECT apellido, salario + comision AS TOTAL FROM emp; -- Si la comision es nula no suma nada
SELECT apellido, salario + nvl(comision, 0) AS TOTAL FROM emp; -- Si la comision es nula suma 0

-- DECODE convierte un string a otro tipo de dato
SELECT apellido, decode(turno, 'M', 'MAÑANA', 'N' , 'NOCHE', 'TARDE') AS TURNO FROM plantilla;

-- Funciones anidadas
SELECT next_day(next_day(sysdate, 'wednesday'), 'wednesday') AS CHAMPIONS FROM dual;

