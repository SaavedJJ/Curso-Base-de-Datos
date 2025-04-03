--INCLUIMOS UNA RESTRICCION PRIMARY KEY EN EL CAMPO
--DEPT_NO DE DEPARTAMENTOS PARA QUE NO PUEDA ADMITIR NULOS
alter table DEPT
add constraint PK_DEPT
primary key (DEPT_NO);

delete from DEPT where dept_no=10;
commit;
--TODAS LAS RESTRICCIONES DEL USUARIO SE ENCUENTRAN EN EL DICCIONARIO
--USER_CONSTRAINTS
select * from USER_CONSTRAINTS;
--INTENTAMOS INSERTAR UN DEPARTAMENTO REPETIDO
insert into DEPT values (10, 'REPE', 'REPE');
select * from DEPT;
--ELIMINAMOS LA RESTRICCION DE PRIMARY KEY DE DEPARTAMENTOS
alter table DEPT
drop constraint PK_DEPT;

-----------------------------EMPLEADOS---------------------------
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

select * from ENFERMO;
describe enfermo;

select * from ENFERMO;











