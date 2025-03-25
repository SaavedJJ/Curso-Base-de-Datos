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
SELECT max(salario) AS "salario maximo" FROM emp;
SELECT max(salario) AS "salario maximo", oficio FROM emp GROUP BY oficio;
SELECT oficio, max(salario) AS "salario maximo" FROM emp GROUP BY oficio ORDER BY "salario maximo" DESC FETCH FIRST 1 ROWS ONLY;

-- clausula distinct, elimina repetidos
SELECT DISTINCT oficio FROM emp;
SELECT COUNT(DISTINCT oficio) AS num_oficios FROM emp;

















