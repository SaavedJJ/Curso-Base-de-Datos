-- 2 Encontrar el salario mas alto, mas bajo y la diferencia entre ambos de todos los empleados con oficio EMPLEADO
SELECT max(salario) AS MAXIMO, min(salario) AS MINIMO, (max(salario) - min(salario)) AS DIFERENCIA
FROM emp
WHERE oficio = 'EMPLEADO';

-- 4 Visualizar el numero de personas que realizan cada oficio en cada departamento ordenado por apartamento
SELECT dept_no, oficio, count(oficio) as PERSONAS
FROM emp
GROUP BY oficio, dept_no
ORDER BY dept_no;

-- 5 Buscar aquellos departamentos con cuatro o mas personas trabajando
select count(*) as EMPLEADOS, dept_no
from EMP
group by dept_no
having count(*) >= 4;

-- 7 Visualizar el numero de enfermeros, enfermeras e interinos que hay en la plantilla, ordenados por la funcion
SELECT funcion, count(*) as PERSONAS
FROM plantilla
GROUP BY funcion
ORDER BY funcion; 

-- 8 Visualizar departamentos, oficios y numero de personas, para aquellos departamentos que tengan dos o mas personas trabajando en el mismo oficio
SELECT dept_no, oficio, count(*) as PERSONAS
FROM EMP
GROUP BY oficio, dept_no
HAVING count(oficio) >= 2;

-- 10 Calcular el valor medio de las camas que exiten para cada nombre de la sala. Indicar el nombre de cada sala y el numero de cada una de ellas
SELECT nombre, AVG(num_cama) AS MEDIA_CAMAS, COUNT(*) AS NUMERO_SALAS
FROM sala
GROUP BY nombre;

-- 11 Calcular el salario medio de la plantilla de la sala 6, segun la funcion que realizan. Indicar la funcion y el numero de empleados.
SELECT sala_cod, funcion, count(*) AS EMPLEADOS, avg(salario) AS MEDIA_SALARIO
FROM plantilla
GROUP BY funcion, sala_cod
HAVING sala_cod = 6; 

-- 12 Averiguar los últimos empleados que se dieron de alta en la empresa en cada uno de los oficios, ordenados por la fecha. 
SELECT oficio, max(fecha_alt) AS FECHAMAXIMA
FROM emp 
GROUP BY oficio 
ORDER BY 1;

-- 13 Mostrar el numero de hombres y el numero de mujeres que hay entre los enfermos
SELECT sexo, count(*) AS ENFERMOS
FROM enfermo
GROUP BY sexo;

-- 15 Calcular el numero de salas que exiten en cada hospital
SELECT hospital_cod, count(sala_cod) AS NUMERO_SALAS
FROM sala
GROUP BY hospital_cod;

-- 16 Mostrar el numero de enfermeras que exiten por cada sala
SELECT sala_cod, count(*) AS PERSONAS
FROM plantilla
WHERE funcion = 'ENFERMERA'
GROUP BY sala_cod;

-- desc plantilla;


