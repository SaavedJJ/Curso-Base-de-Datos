-- INTRODUCCION A BASE DE DATOS

-- misma consulta diferente sintaxis
SELECT * FROM EMP;
SELECT emp_no, apellido, oficio, dir, fecha_alt, salario, comision, dept_no FROM EMP;

-- consulta ordenada, por defecto es ascendente
SELECT * FROM emp ORDER BY apellido;
SELECT * FROM emp ORDER BY apellido DESC;

-- consultas filtradas por operadores de comparacion
SELECT * FROM emp WHERE dept_no = 10;
SELECT * FROM emp WHERE salario > 2000;
SELECT * FROM emp WHERE salario < 2000;
SELECT * FROM emp WHERE salario >= 2000;
SELECT * FROM emp WHERE salario <= 2000;
SELECT * FROM emp WHERE dept_no != 10;

-- consultas filtradas por operadores relacionales
SELECT * FROM emp WHERE dept_no = 10 AND salario > 2000;
SELECT * FROM emp WHERE dept_no = 10 OR salario > 2000;
SELECT * FROM emp WHERE dept_no = 10 AND salario > 2000 AND comision IS NULL;
SELECT * FROM emp WHERE dept_no = 10 AND salario > 2000 AND comision IS NOT NULL;
SELECT * FROM emp WHERE dept_no BETWEEN 10 AND 30;
SELECT * FROM emp WHERE dept_no IN (20, 30);
SELECT * FROM emp WHERE dept_no NOT IN (20, 30, 10);

-- operadores para bucar coincidencias
SELECT * FROM emp WHERE apellido LIKE 'a%';
SELECT * FROM emp WHERE apellido LIKE '%a';
SELECT * FROM emp WHERE apellido LIKE '%a%';
SELECT * FROM emp WHERE apellido LIKE '_a%';
SELECT * FROM emp WHERE apellido LIKE '__l%';
SELECT * FROM emp WHERE apellido LIKE '____';

-- consultas calculadas
SELECT apellido, salario, comision, salario + comision AS "salario total" FROM emp;
SELECT apellido, salario, comision, salario * 12 + comision AS "salario anual" FROM emp;

-- consultas de agrupacion
SELECT count(*) as NUMERO_DOCTORES FROM doctor;
SELECT count(apellido) as NUMERO_DOCTORES FROM doctor;
SELECT count(apellido) as DOCTORES, max(salario) as MAXIMO FROM doctor; 

SELECT count(*) as DOCTORES, ESPECIALIDAD FROM doctor GROUP BY ESPECIALIDAD;

SELECT count(*) as PERSONAS, max(salario) as MAXIMO_SALARIO, dept_no, oficio FROM emp GROUP BY dept_no, oficio;

SELECT count(*) as PERSONAS, turno from plantilla GROUP BY turno;

SELECT max(salario) AS "salario maximo" FROM emp;                                                                          
SELECT max(salario) AS "salario maximo", oficio FROM emp GROUP BY oficio;
SELECT oficio, max(salario) AS "salario maximo" FROM emp GROUP BY oficio ORDER BY "salario maximo" DESC FETCH FIRST 1 ROWS ONLY;

-- Filtrar consultas de agrupacion
SELECT count(*) as EMPLEADOS, oficio
FROM EMP
GROUP BY oficio
HAVING oficio in ('ANALISTA','VENDEDOR'); 

SELECT count(*) as EMPLEADOS, oficio
FROM EMP
WHERE oficio in ('ANALISTA','VENDEDOR')
GROUP BY oficio;

-- clausula distinct, elimina repetidos
SELECT DISTINCT oficio FROM emp;
SELECT COUNT(DISTINCT oficio) AS num_oficios FROM emp;


-- Consultas de combinacion inner join
SELECT  emp.apellido, emp.oficio, 
        dept.dnombre, dept.loc
FROM emp
JOIN dept
ON emp.dept_no = dept.dept_no;

SELECT  h.*,
        s.*,
        p.*,
        d.*
FROM hospital h
JOIN sala s
ON h.hospital_cod = s.hospital_cod
JOIN plantilla p
ON h.hospital_cod = p.hospital_cod
JOIN doctor d
ON h.hospital_cod = d.hospital_cod;

-- Consultas de combinacion left join
SELECT e.apellido, d.dnombre, d.loc
FROM emp e
LEFT JOIN dept d
ON e.dept_no = d.dept_no;
-- Consultas de combinacion right join
SELECT e.apellido, d.dnombre, d.loc
FROM emp e
RIGHT JOIN dept d
ON e.dept_no = d.dept_no;
-- Consultas de combinacion full join (no se utiliza)
SELECT e.apellido, d.dnombre, d.loc
FROM emp e
FULL JOIN dept d
ON e.dept_no = d.dept_no;
-- Consultas de combinacion cross join
SELECT e.apellido, d.dnombre, d.loc
FROM emp e
CROSS JOIN dept d;


-- Mostrar la media salarial de los doctores por hospital, mostrando el nombre del hospital
SELECT avg(d.salario) AS media, h.nombre
FROM doctor d
JOIN hospital h
ON d.hospital_cod = h.hospital_cod
GROUP BY h.nombre;


-- Mostrar el numero de empleados que exiten por cada locoalidad
SELECT count(apellido) AS EMPLEADOS, d.loc
FROM emp e 
RIGHT JOIN dept d 
ON e.dept_no = d.dept_no
GROUP BY d.loc;

-- Subconsultas Visualizar los datos del empleado que mas cobra en la empresa
SELECT max(salario) FROM emp;
--650000
SELECT * FROM emp
WHERE salario = 650000;

SELECT * FROM emp WHERE salario = (SELECT max(salario) FROM emp);

-- Subconsultas Mostrar los empleados que tienen el mismo oficio que el empleado gil y que cobren menos que jimenez
SELECT * 
FROM emp 
WHERE oficio = 
                (SELECT oficio 
                 FROM emp 
                 WHERE apellido = 'gil');

SELECT * 
FROM emp 
WHERE oficio IN
                (SELECT oficio 
                 FROM emp 
                 WHERE apellido = 'gil'
                 AND apellido = 'jimenez');

-- Consultas de union 
SELECT apellido, oficio, salario 
FROM emp
UNION
SELECT apellido, funcion, salario 
FROM plantilla
ORDER BY 2;

-- Consultas Select to Select. Recuperar datos de un Select ya realizado
SELECT *
FROM
(SELECT apellido, oficio, salario 
FROM emp e
UNION
SELECT apellido, funcion, salario
FROM plantilla p
UNION
SELECT apellido, especialidad, salario
FROM doctor d) CONSULTA
WHERE CONSULTA.salario < 300000;

-- Consultas a nivel de fila

SELECT apellido, funcion, turno,
 CASE turno
  when 'T' then 'TARDE'
  when 'M' then 'MAÑANA'
  else 'NOCHE'
 END AS FORMATO
FROM plantilla;

SELECT apellido, funcion, salario,
 CASE 
  when salario > 300000 then 'ALTO'
  when salario > 200000 then 'MEDIO'
  else 'BAJO'
 END AS FORMATO
FROM plantilla;


-- MOSTRAR LA SUMA SALARIAL DE LOS EMPLEADOS POR SU NOMBRE DE DEPARTAMENTO
-- MOSTRAR LA SUMA SALARIAL DE LOS DOCTORES POR SU HOSPITAL
-- TODO JUNTO EN UNA MISMA CONSULTA

SELECT *
FROM
        (SELECT sum(e.salario) as SALARIO_TOTAL, d.dnombre AS NOMBRE
        FROM emp e
        RIGHT JOIN dept d
        ON e.dept_no = d.dept_no
        GROUP BY d.dnombre
        UNION
        SELECT sum(d.salario), h.nombre
        FROM hospital h
        JOIN doctor d
        ON h.hospital_cod = d.hospital_cod
        GROUP BY h.nombre);

-- Consultas de accion INSERT, UPDATE, DELETE (rollback, commit)
-- INSERT COMPLETO
INSERT INTO dept 
VALUES (50, 'ORACLE', 'BERNABEU');
rollback;
SELECT * FROM dept;
-- INSERT PARCIAL
INSERT INTO dept (dept_no, dnombre) 
VALUES (50, 'ORACLE');
rollback;
SELECT * FROM dept;
-- INSERT con subconsulta
SELECT max(dept_no) + 10 from dept;
INSERT INTO dept VALUES ((SELECT max(dept_no) + 10 from dept), 'SIDRA', 'GIJON');
SELECT * FROM dept;

-- DELETE todos los registros de la tabla
DELETE FROM HOSPITAL;
rollback;
-- DELETE condicional
DELETE FROM dept 
WHERE dnombre = 'ORACLE';
rollback;
-- DELETE con subconsulta
DELETE FROM emp
WHERE dept_no = (SELECT dept_no FROM dept WHERE loc = 'GRANADA');
rollback;

-- UPDATE todos los registros de la tabla
UPDATE dept 
SET dnombre = 'INVERSION', loc = 'PAMPLONA';
-- UPDATE condicional 
UPDATE plantilla
SET salario = 315000
WHERE turno = 'N';
--UPDATE con operaciones matematicas
UPDATE emp set salario = salario + '1';
-- UPDATE con subconsulta
UPDATE dept 
SET dnombre = 'INVERSION'
WHERE dept_no = (SELECT dept_no FROM dept WHERE loc = 'BERNABEU');


