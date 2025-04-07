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




