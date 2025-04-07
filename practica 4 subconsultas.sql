-- 1 Mostrar el numero de empleado, el apellido y la fecha de alta del empleado mas antiguo de la empresa
SELECT emp_no, apellido, fecha_alt 
FROM emp
WHERE fecha_alt = (SELECT min(fecha_alt) FROM emp);

-- 2 Mostrar el numero de empleado, el apellido y la fecha de alta del empleado mas moderno de la empresa
SELECT emp_no, apellido, fecha_alt 
FROM emp
WHERE fecha_alt = (SELECT max(fecha_alt) FROM emp);

-- 3 Visualizar el apellido y el salario de los empleados con el mismo oficio de Jimenez
SELECT apellido, salario 
FROM emp
WHERE oficio = (SELECT oficio FROM emp WHERE apellido = 'jimenez');

-- 4 Queremos saber el apellido, oficio, salario y numero de departamento de los empleados con salario mayor que el mejor salario del departamento 30
SELECT apellido, oficio, salario, dept_no
FROM emp
WHERE salario = (SELECT max(salario) FROM emp WHERE dept_no = 30);

-- 5 Mostrar el apellido, la funcion u oficio, sala o departamento de todos los empleados que trabajen en Empresa o Plantilla.
SELECT e.apellido, e.oficio, d.dnombre
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no
UNION
SELECT p.apellido, p.funcion, s.nombre
FROM plantilla p
JOIN sala s
ON p.sala_cod = s.sala_cod;

-- 6 Mostrar apellidos y oficio de los empleados del departamento 20 cuyo trabajo sea el mismo que el de cualquier empleado de ventas
SELECT apellido, oficio
FROM emp 
WHERE dept_no = 20 
AND oficio IN (SELECT oficio FROM emp WHERE dept_no = (SELECT dept_no FROM dept WHERE dnombre = 'VENTAS'));

-- 7 Mostrar los empleados que tienen mejor salario que la media de los directores, no incluyendo al presidente
SELECT * 
FROM emp
WHERE salario > (SELECT avg(salario) FROM emp WHERE oficio IN('DIRECTOR'))
AND oficio NOT IN('PRESIDENTE');

-- 8 Mostrar el apellido, funcion, salario y codigo de hospital de los empleados de la plantilla que siendo enfermeros o enfermeras pertenecen al hospital SAN CARLOS
SELECT apellido, funcion, salario, hospital_cod
FROM plantilla
WHERE funcion IN('ENFERMERO', 'ENFERMERA')
AND hospital_cod = (SELECT hospital_cod FROM hospital WHERE nombre = 'san carlos');

-- 9 Averiguar el salario de todas las personas de la bbdd, de forma que se aprecien las diferencias entre ellos 
SELECT apellido, oficio, salario 
FROM emp
UNION
SELECT apellido, funcion, salario 
FROM plantilla
UNION
SELECT apellido, especialidad, salario 
FROM doctor
ORDER BY 3;

-- 10 Misma consulta que la anterior pero mostrar solo los cuyo oficio termine en O
SELECT * 
FROM 
(SELECT apellido, oficio, salario 
FROM emp
UNION
SELECT apellido, funcion, salario 
FROM plantilla
UNION
SELECT apellido, especialidad, salario 
FROM doctor)
WHERE oficio LIKE '%O'
ORDER BY 3;

-- 11 Visualizar los datos de los hospitales que tienen personal (Doctores) de cardiologia
SELECT * 
FROM hospital 
WHERE hospital_cod IN (SELECT hospital_cod FROM doctor WHERE especialidad = 'Cardiologia');

-- 12 Visualizar el apellido y el salario anual de los empleados de la plantilla del Hospital Provincial y General
SELECT apellido, salario*12 AS salario_anual
FROM plantilla
WHERE hospital_cod IN (SELECT hospital_cod FROM hospital WHERE nombre IN ('provincial','general'));

-- 13 Mostrar el apellido de los enfermeros que nacieron antes que el Señor Miller
SELECT apellido
FROM enfermo 
WHERE fecha_nac < (SELECT fecha_nac FROM enfermo WHERE apellido = 'Miller G.');

-- 14 Necesitamos un informe para evaluar como van las cuentas generales de la empresa. 
-- Para ello, necesitamos saber lo que cobra cada persona por cada oficio de manera detallada.
-- Necesitamos el maximo salario y el minimo mas la media salarial, el total de sueldos y el numero de trabajadores que hay en cada puesto de toda la base de datos.

SELECT especialidad, max(salario) AS MAXIMO, avg(salario) AS MEDIA, sum(salario) AS SUMA, min(salario) AS MINIMO, count(apellido) AS TRABAJADORES
FROM doctor
GROUP BY especialidad
UNION
SELECT funcion, max(salario), avg(salario), sum(salario), min(salario), count(apellido)
FROM plantilla
GROUP BY funcion
UNION 
SELECT oficio, max(salario), avg(salario), sum(salario), min(salario), count(apellido)
FROM emp
GROUP BY oficio
ORDER BY 2;
