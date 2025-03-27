-- 1 Seleccionar el apellido, oficio, salario, numero de departamento y su nombre de todos los empleados cuyo salario sea mayor de 300000.
SELECT e.apellido, e.oficio, e.salario, d.dept_no, d.dnombre
FROM emp e
JOIN dept d 
ON e.dept_no = d.dept_no
WHERE salario > 300000;

-- 2 Mostrar todos los nombres de Hospital con sus nombres de salas correspondientes.
SELECT h.nombre AS HOSPITALES, s.nombre AS SALAS
FROM hospital h
JOIN sala s
ON h.hospital_cod = s.hospital_cod;

-- 3 Calcular cuantos trabajadores de la empresa hay en cada ciudad 
SELECT count(apellido) AS TRABAJADORES, d.loc AS CIUDADES
FROM emp e
RIGHT JOIN dept d
ON e.dept_no = d.dept_no
GROUP BY d.loc;

-- 4 Visualizar cuantas personas realizan cada oficio en cada departamento mostrando el nombre del departamento.
SELECT count(e.apellido) AS TRABAJADORES, e.oficio, d.dnombre AS DEPARTAMENTOS
FROM emp e
RIGHT JOIN dept d
ON e.dept_no = d.dept_no
GROUP BY e.oficio, d.dnombre;

-- 5 Contar cuantas salas hay en cada hospital, mostrando el nombre de las salas y el nombre del hospital.
SELECT count(s.sala_cod) AS NUMERO_SALAS, s.nombre AS SALAS, h.nombre AS HOSPITALES
FROM hospital h
JOIN sala s 
ON h.hospital_cod = s.hospital_cod
GROUP BY s.nombre, h.nombre;

-- 6 Queremos saber cuantos trabajadores se dieron de alta entre el año 1997 y 1998 y en que departamento.
SELECT count(e.apellido) AS TRABAJADORES, d.dnombre AS DEPARTAMENTO
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no
WHERE e.fecha_alt BETWEEN '01/01/1997' AND '31/12/1998'
GROUP BY d.dnombre;

-- 7 Buscar aquellas ciudades con cuatro o mas personas trabajando.
SELECT d.loc AS CIUDADES, count(e.apellido) AS TRABAJADORES
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no
GROUP BY d.loc
HAVING count(e.apellido) >= 4;

-- 8 Calcular la media salarial por ciudad. Mostrar solamente la media para Madrid y Elche.
SELECT avg(e.salario) AS MEDIA_SALARIAL, d.loc AS CIUDAD
FROM emp e
JOIN dept d 
ON e.dept_no = d.dept_no
GROUP BY d.loc
HAVING d.loc in('MADRID','SEVILLA');

-- 9 Mostrar los doctores junto con el nombre de hospital en el que ejercen, la direccion y el telefono del mismo.
SELECT d.apellido AS DOCTORES, h.nombre AS HOSPITALES, h.direccion AS DIRECCION_HOSPITAL, h.telefono AS TELEFONOS
FROM doctor d
JOIN hospital h
ON d.hospital_cod = h.hospital_cod;

-- 10 Mostrar los nombres de los hospitales junto con el mejor salario de los empleados de la plantilla de cada hospital.
SELECT h.nombre AS HOSPITALES, max(p.salario) AS MEJOR_SALARIO
FROM hospital h
JOIN plantilla p
ON h.hospital_cod = p.hospital_cod
GROUP BY h.nombre;

-- 11 Visualizar el Apellido, funcion y turno de los empleados de la plantilla junto con el nombre de la sala y el nombre del hospital con el telefono.
SELECT p.apellido AS EMPLEADOS, p.funcion AS FUNCION, p.turno AS TURNO, s.nombre AS SALA, h.nombre AS HOSPITAL, h.telefono AS TELEFONO
FROM hospital h
JOIN plantilla p
ON h.hospital_cod = p.hospital_cod
JOIN sala s 
ON h.hospital_cod = s.hospital_cod
AND p.sala_cod = s.sala_cod;



-- 12 Visualizar el maximo salario, minimo salario de los Directores dependiendo de la ciudad en la que trabajen. Indicar el numero total de directores por ciudad.
SELECT count(e.apellido) AS NUMERO_DIRECTORES, d.loc AS CIUDAD, max(e.salario) AS SALARIO_MAXIMO, min(e.salario) AS SALARIO_MINIMO 
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no
WHERE e.oficio = 'DIRECTOR'
GROUP BY d.loc;

-- 13 Averiguar la combinacion de que salas podria haber por cada uno de los hospitales.
SELECT h.nombre AS HOSPITAL, s.nombre AS SALA
FROM hospital h
CROSS JOIN sala s;

