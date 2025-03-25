-- 6 Mostrar todos los enfermos nacidos antes del 11/01/1970 
SELECT apellido, fecha_nac FROM enfermo where fecha_nac < '10/01/1970';

-- 7 Igual que el anterior, para los nacidos antes del 1/1/1970 ordenados por numero de inscripcion 
SELECT apellido, inscripcion, fecha_nac FROM enfermo WHERE fecha_nac < '01/01/1970' ORDER BY inscripcion; 

-- 8 Listar todos los datos de la plantilla del hospital del turno de mañanana
SELECT * FROM plantilla WHERE turno = 'M';

-- 9 Idem del turno de noche
SELECT * FROM plantilla WHERE turno = 'N';

-- 10 Listar los doctores que su salario anual supere los 3.000.000
SELECT apellido, salario * 12 AS salario_anual FROM doctor WHERE salario * 12 > 3000000;

-- 11 Visualizar los empleados de la plantilla del turno de mañana que tengan un salario entre 2.000.000 y 2.250.000
SELECT apellido, salario * 12 as salario_anual FROM plantilla WHERE turno = 'M' AND salario * 12 BETWEEN 2000000 AND 2250000;

-- 12 Visualizar los empleados de la tabla emp que no se dieron de alta entre el 01/01/1980 y el 12/12/1982 
SELECT apellido, oficio, fecha_alt FROM emp WHERE fecha_alt NOT IN ('01/01/1980', '12/12/1982') AND oficio = 'EMPLEADO';
SELECT apellido, oficio, fecha_alt FROM emp WHERE fecha_alt < '01/01/1980' OR fecha_alt > '12/12/1982' AND oficio = 'EMPLEADO';

--13 Mostrar los nombres de los departamentos situados en Madrid o Barcelona
SELECT dnombre FROM dept WHERE loc = 'MADRID' OR loc = 'BARCELONA';

