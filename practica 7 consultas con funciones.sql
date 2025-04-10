-- 1 Mostrar todos los apellidos de los empleados en Mayusculas
SELECT upper(apellido) 
FROM emp;

-- 2 Mostrar la fecha de hoy con el siguiente formato: Martes 06 de Octubre de 2025
SELECT to_char(sysdate, 'Day DD "de" Month "de" YYYY', 'NLS_DATE_LANGUAGE=SPANISH')
FROM dual;

SELECT to_char(sysdate, 'Day DD "de" Month "de" YYYY', 'NLS_DATE_LANGUAGE=FRENCH')
FROM dual;


-- 3 Queremos llevar el departamento de Barcelona a Tabarnia. 
-- Para ello, debemos saber que empleados cambiarian de localidad y cuales no.
-- Combinar tablas y mostrar el nombre del departamento, junto a los datos del empleado

SELECT d.dnombre, e.apellido, 
CASE 
    WHEN d.loc = 'BARCELONA' THEN 'SE TRANSLADA'
    ELSE 'NO SE TRANSLADA'
END AS TRANSLADO
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no;

-- 4 Mirar la fecha de alta del presidente. Visualizar todos los empleados dados de alta 330 dias antes que el presidente 
SELECT *
FROM emp
WHERE fecha_alt < (SELECT fecha_alt FROM emp WHERE lower(oficio) = 'presidente') - 330;

-- 5 Nos piden un informe 
SELECT rpad(apellido, 15, '.') || rpad(oficio, 15, '.') || rpad(salario, 15, '.') || rpad(dept_no, 15, '.') AS INFORME
FROM emp;

-- 6 Otro informe 
SELECT 'El Señor ' || apellido || ' con cargo de ' || oficio || ' se dio de alta el ' || to_char(fecha_alt, 'day DD "de" month "del" yyyy', 'NLS_DATE_LANGUAGE=SPANISH') AS "Fecha de alta"
FROM emp;