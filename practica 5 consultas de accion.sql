-- 1 Dar de alta con fecha actual al empleado José Escriche Barrera como programador perteneciente al departamento de produccion. Tendrá un salario base de 70000 y no tiene comision
INSERT INTO emp (apellido, oficio, fecha_alt, salario, comision, dept_no) 
VALUES ('Escriche Barrera', 'PROGRAMADOR', SYSDATE, 70000, 0, (SELECT dept_no FROM dept WHERE dnombre = 'PRODUCCIÓN'));
desc emp;
SELECT * FROM emp;

-- 2 Se quiere dar de alta un departamento de informatica situado en Fuenlabrada (Madrid).
INSERT INTO dept VALUES (SEQ_DEPT.NEXTVAL, 'INFORMATICA', 'FUENLABRADA');
desc dept;
SELECT * FROM dept;

-- 3 El departamento de ventas se traslada a Teruel, realiza dicha modificacion
UPDATE dept 
SET loc = 'TERUEL'
WHERE dept_no = (SELECT dept_no FROM dept WHERE dnombre = 'VENTAS'); 
SELECT * FROM dept;

-- 4 En el departamento anterior, se dan de alta dos empleados, Julian Romeral y Luis Alonso. 
-- Su salario base es el menor que cobre un empleado, y cobraran una comision del 15% de dicho salario.
INSERT INTO emp (apellido, salario, comision, dept_no) 
VALUES ('Julian Romeral', 
        (SELECT min(salario) FROM emp WHERE oficio = 'EMPLEADO'), 
        (SELECT min(salario)*15/100 FROM emp WHERE oficio = 'EMPLEADO'),
        (SELECT dept_no FROM dept WHERE dnombre = 'VENTAS'));
INSERT INTO emp (apellido, salario, comision, dept_no) 
VALUES ('Luis Alonso', 
        (SELECT min(salario) FROM emp WHERE oficio = 'EMPLEADO'), 
        (SELECT min(salario)*15/100 FROM emp WHERE oficio = 'EMPLEADO'),
        (SELECT dept_no FROM dept WHERE dnombre = 'VENTAS'));
SELECT apellido FROM emp;

-- 5 Modificar la comision de los empleados de la empresa, de forma que todos tengan un incremento del 10% del salario
UPDATE emp
SET comision = salario*10/100;

-- 6 Incrementar un 5% el salario de los interinos de la plantilla que trabajen en el turno de noche 
UPDATE plantilla 
SET salario = salario*5/100
WHERE turno = 'N';

-- 7 Incrementar en 5000 el salario de los empleados del departamento de ventas y del presidente, tomando en cuenta los que se dieron de alta antes que el presidente de la empresa.
UPDATE emp 
SET salario = salario + 5000
WHERE dept_no = (SELECT dept_no FROM dept WHERE dnombre = 'VENTAS')
AND oficio = 'PRESIDENTE'
AND fecha_alt < (SELECT fecha_alt FROM emp WHERE oficio = 'PRESIDENTE');

-- 8 El empleado Sanchez ha pasado por la derecha de un compañero
-- Debe cobrar de comision 12.000 mas que el empleado Arroyo y su sueldo se ha incrementado un 10% respecto a su compañero
UPDATE emp 
SET comision = (SELECT comision + 12000 FROM emp WHERE apellido = 'arroyo'),
    salario = (SELECT salario*10/100 FROM emp WHERE apellido = 'arroyo')
WHERE apellido = 'sanchez';

-- 9 Se tienen que desplazar cien camas del hospital SAN CARLOS para un Hospital en Venezuela. Actualizar el numero de camas del hospital San Carlos
UPDATE hospital 
SET num_cama = num_cama - 100
WHERE nombre = 'san carlos'; 

-- 10 Subir el salario y la comision en 100000 y 25000 respectivamente a los empleados que se dieron de alta en este año
UPDATE emp
SET salario = salario + 100000,
    comision = comision + 25000
WHERE fecha_alt = 03/04/2025;

-- 11 Ha llegado un nuevo doctor a la Paz. Su apellido es House y su especialidad es Diagnostico. Introducir el proximo numero de Doctor disponible.
INSERT INTO doctor
VALUES ((SELECT hospital_cod FROM hospital WHERE nombre = 'la paz'),
        (SELECT max(doctor_no) + 1 FROM doctor),
        'House',
        'Diagnostico',
         5000000);

SELECT * FROM doctor;
rollback;

-- 12 