-- declarar variables con el mismo tipo de dato que de la columna de la tabla

DECLARE
    v_numero dept.dept_no%TYPE;
    v_nombre dept.dnombre%TYPE;
    v_localidad dept.loc%TYPE;
BEGIN
    v_numero := '&numero';
    v_nombre := '&nombre';
    v_localidad := '&localidad';
    INSERT INTO dept VALUES (v_numero, upper(v_nombre), upper(v_localidad));
END;

SELECT * FROM dept;
DELETE FROM dept WHERE dept_no = '&numero';

-- estructuras de control
-- comprobar si un numero es positivo o negativo

DECLARE 
    v_numero INT;
BEGIN
    v_numero := 7;
    IF(v_numero >= 0) THEN
        DBMS_OUTPUT.PUT_LINE('Positivo');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Negativo');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es un número válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;


-- evaluar un numero para cada estacion del año

DECLARE
    v_numero INT;
BEGIN
    v_numero := 1;
    IF(v_numero = 1) THEN
        DBMS_OUTPUT.PUT_LINE('Primavera');
    ELSIF(v_numero = 2) THEN 
        DBMS_OUTPUT.PUT_LINE('Verano');
    ELSIF(v_numero = 3) THEN 
        DBMS_OUTPUT.PUT_LINE('Otoño');
    ELSIF(v_numero = 4) THEN 
        DBMS_OUTPUT.PUT_LINE('Invierno');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('estacion no seleccionada correctamente');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es un número válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;

-- pedir dos numeros al usuario y devolver el mayor
DECLARE
    v_numero1 INT;
    v_numero2 INT;
BEGIN
    v_numero1 := 10;
    v_numero2 := 8;
    IF(v_numero1 > v_numero2) THEN
        DBMS_OUTPUT.PUT_LINE(v_numero1);
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_numero2);
    END IF;
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es un número válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;

-- pedir un numero e indicar si es par o impar
DECLARE
    v_numero INT;
BEGIN
    v_numero := 0;
    IF(mod(v_numero, 2) = 0) THEN
        DBMS_OUTPUT.PUT_LINE('PAR');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IMPAR');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es un número válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;

-- Pedir una letra al usuario. Si la letra es vocal pintamos vocal, si no, consonante
/
DECLARE
    v_letra CHAR(1);
BEGIN
    v_letra := UPPER('a');
    IF v_letra IN ('A', 'E', 'I', 'O', 'U') THEN
        DBMS_OUTPUT.PUT_LINE('VOCAL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('CONSONANTE');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;
/

-- Pedir 3 numeros, mostrar cual es el mayor y cual es el menor
DECLARE
    v_numero1 INT := 15;
    v_numero2 INT := 8;
    v_numero3 INT := 20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('El mayor es: ' || GREATEST(v_numero1, v_numero2, v_numero3));
    DBMS_OUTPUT.PUT_LINE('El menor es: ' || LEAST(v_numero1, v_numero2, v_numero3));
    DBMS_OUTPUT.PUT_LINE('Fin del programa');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El valor ingresado no es un número válido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ocurrió un error inesperado.');
END;

-- BUCLES. mostrar suma de los primeros 100 numeros

-- bucle condicional simple
DECLARE
    i INT := 1;
    suma INT := 0;
BEGIN
    LOOP
        suma := suma + i;
        i := i + 1;
        DBMS_OUTPUT.PUT_LINE(suma);
        EXIT WHEN i > 100;
    END LOOP;
END;

-- bucle while
DECLARE
    i INT := 1;
    suma INT := 0;
BEGIN
    WHILE i <= 100 LOOP
        suma := suma + i;
        i := i + 1;
        DBMS_OUTPUT.PUT_LINE(suma);
    END LOOP;
END;

-- bucle for
DECLARE
    suma INT := 0;
BEGIN
    FOR i IN 1..100 LOOP
        suma := suma + i;
        DBMS_OUTPUT.PUT_LINE(suma);
    END LOOP;
END;

-- etiqueta GOTO

DECLARE
    suma INT := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('entrada');
    FOR i IN 1..100 LOOP
        suma := suma + i;
        IF(suma > 2000) THEN
            GOTO salida;
        END IF;
        DBMS_OUTPUT.PUT_LINE(suma);
    END LOOP;
<<salida>>
    DBMS_OUTPUT.PUT_LINE('salida');
END;

-- EJEMPLOS
-- Bucle para mostrar los numeros entre 1 y 10
--1) bucle while
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
--2) bucle for
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

-- Pedir al usuario un numero de inicio y un numero final. Mostrar todos los numeros entre ambos.
-- Si el numero final es mayor que el primero
DECLARE
    primero INT := &inicio;
    ultimo INT := &final;
BEGIN
    IF(primero >= ultimo) THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: El numero de inicio es mayor que el numero final');
    ELSE 
        FOR i IN primero..ultimo LOOP
            DBMS_OUTPUT.PUT_LINE(i);
        END LOOP;
    END IF;
END;

UNDEFINE inicio;
UNDEFINE final;

-- CONJETURA DE COLLATZ
-- la teoria indica que cualquier numero siempre llegara a ser 1
-- si el numero es par, se divide entre 2
-- si el numero es impar, se multiplica por 3 y sumamos 1
DECLARE
    numero INT := &numero;
BEGIN
    WHILE numero <> 1 LOOP
        DBMS_OUTPUT.PUT_LINE(numero);
        IF (mod(numero, 2) = 0) THEN
            numero := numero / 2;
        ELSE 
            numero := (numero * 3) + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(numero);
END;

UNDEFINE numero;

-- Mostrar la tabla de multiplicar de un numero del 1 al 10
DECLARE
    numero INT := &numero;
BEGIN
    FOR i IN 1..10 LOOP
         DBMS_OUTPUT.PUT_LINE(numero || '*' || i || '=' || numero * i);
    END LOOP;
     DBMS_OUTPUT.PUT_LINE('Fin del programa');
END;
UNDEFINE numero;

-- recorrer una cadena de texto
DECLARE 
    texto VARCHAR2(10) := 'texto';
BEGIN
    FOR i IN 1..length(texto) LOOP
         DBMS_OUTPUT.PUT_LINE(substr(texto, i, 1));
    END LOOP;
END;

-- El usuario introduce un texto numerico, mostrar la suma de todos los caracteres numericos en un mensaje
DECLARE 
    numero VARCHAR2(10) := &texto;
    suma INT := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(numero);
    FOR i IN 1..length(numero) LOOP
        suma := suma + to_number(substr(numero, i, 1));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(suma);
END;


-- CURSORES
-- Modifcar el salario del empleado ARROYO. Si el empleado cobra mas de 250.000, le bajamos el sueldo en 10.000. Si no, le subimos el sueldo en 10.000

DECLARE
    v_salario emp.SALARIO%TYPE;
    v_idemp emp.EMP_NO%TYPE;
BEGIN
    SELECT salario, emp_no INTO v_salario, v_idemp FROM emp WHERE upper(apellido) = 'ARROYO';
        IF v_salario > 250000 THEN
            v_salario := v_salario - 10000;
            DBMS_OUTPUT.PUT_LINE('Salario reducido en 10.000');
        ELSE
            v_salario := v_salario + 10000;
            DBMS_OUTPUT.PUT_LINE('Salario incrementado en 10.000');
        END IF;
    UPDATE emp
    SET salario = v_salario
    WHERE emp_no = v_idemp;
END;

SELECT salario FROM emp WHERE upper(apellido) = 'ARROYO';


-- Modificar el salario de los doctores de LA PAZ
-- Si la suma salarial supera 1.000.000 bajamos en 10.000 a todos si no, subimos 10.000
-- mostrar el numero de filas modificadas 
-- SOLUCION 1
DECLARE 
    CURSOR doctores IS 
    SELECT salario, hospital_cod 
    FROM doctor 
    WHERE hospital_cod = (SELECT hospital_cod FROM hospital WHERE upper(nombre) = 'LA PAZ');
    v_hospital_cod doctor.hospital_cod%TYPE;
    v_salario doctor.salario%TYPE;
    v_suma_salarial INT := 0;
BEGIN
    OPEN doctores;

    LOOP
        FETCH doctores INTO v_salario, v_hospital_cod;
            v_suma_salarial := v_suma_salarial + v_salario;
        EXIT WHEN doctores%NOTFOUND;  
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Suma salarial: ' || v_suma_salarial);

    IF v_suma_salarial > 1000000 THEN
        UPDATE doctor
        SET salario = salario - 10000
        WHERE hospital_cod = v_hospital_cod;
        DBMS_OUTPUT.PUT_LINE('Salario reducido en 10.000 a: ' || doctores%ROWCOUNT || ' doctores');
    ELSE
        UPDATE doctor
        SET salario = salario + 10000
        WHERE hospital_cod = v_hospital_cod;
        DBMS_OUTPUT.PUT_LINE('Salario incrementado en 10.000 a: ' || doctores%ROWCOUNT || ' doctores');
    END IF;

    CLOSE doctores;
END;
-- SOLUCION 2
DECLARE
    v_suma_salarial INT := 0;
    v_hospital_cod doctor.hospital_cod%TYPE;
BEGIN
    SELECT sum(salario), hospital_cod
    INTO v_suma_salarial, v_hospital_cod
    FROM doctor 
    WHERE hospital_cod = (SELECT hospital_cod FROM hospital WHERE upper(nombre) = 'LA PAZ')
    GROUP BY hospital_cod;
    DBMS_OUTPUT.PUT_LINE('Suma salarial: ' || v_suma_salarial);

    IF v_suma_salarial > 1000000 THEN
        UPDATE doctor
        SET salario = salario - 10000
        WHERE hospital_cod = v_hospital_cod;
        DBMS_OUTPUT.PUT_LINE('Salario reducido en 10.000 a ' || SQL%ROWCOUNT || ' doctores');
    ELSE
        UPDATE doctor
        SET salario = salario + 10000
        WHERE hospital_cod = v_hospital_cod;
        DBMS_OUTPUT.PUT_LINE('Salario incrementado en 10.000 a ' || SQL%ROWCOUNT || ' doctores');
    END IF;
END;

SELECT sum(salario) FROM doctor WHERE hospital_cod = (SELECT hospital_cod FROM hospital WHERE upper(nombre) = 'LA PAZ');
SELECT count(apellido) FROM doctor WHERE hospital_cod = 22;

desc doctor;

-- Mostrar todos los datos del doctor Cajal ROWTYPE
DECLARE 
    v_dept dept%ROWTYPE;
    CURSOR c_dept IS
    SELECT * FROM DEPT;
BEGIN
    OPEN c_dept;
        LOOP
            FETCH c_dept INTO v_dept;
            EXIT WHEN c_dept%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Codigo departamento: ' || v_dept.dept_no ||
                                 ', Nombre departamento: ' || v_dept.dnombre || 
                                 ', Localidad departamento: ' || v_dept.loc);
        END LOOP;
    CLOSE c_dept;
END;

desc dept;


-- Estructura de Cursor con bucle for
DECLARE 
    CURSOR c_emp IS
    SELECT apellido FROM emp;
BEGIN
    FOR registro IN c_emp LOOP
        DBMS_OUTPUT.PUT_LINE(registro.apellido);
    END LOOP;
END;

-- EXCEPCIONES
-- Capturar una excepcion del sistema
DECLARE
    num1 NUMBER := 2;
    num2 NUMBER := 0;
    division NUMBER;
BEGIN
    division := num1 / num2;
    DBMS_OUTPUT.PUT_LINE(division);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('no se puede dividir entre 0');
END;

-- Crear una excepcion de usuario
-- Lanzar una excepcion cuando los empleados tengan una comision igual a 0
CREATE TABLE emp_comision (apellido VARCHAR2(50), comision NUMBER(9));

SELECT comision FROM emp;

DECLARE
    CURSOR c_emp IS
    SELECT apellido, comision 
    FROM emp 
    ORDER BY comision DESC;
    comision EXCEPTION;
BEGIN
    FOR v_record IN c_emp LOOP
        IF v_record.comision = 0 THEN
            RAISE comision;
        END IF; 
    END LOOP;
EXCEPTION
    WHEN comision THEN
     DBMS_OUTPUT.PUT_LINE('empleados con comision 0');
END;

-- PRAGMA EXCEPTION_INIT
DECLARE
    exception_nulos EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_nulos, -1400);
BEGIN
    INSERT INTO dept VALUES (null, 'DEPARTAMENTO', 'PRAGMA');
EXCEPTION
    WHEN exception_nulos THEN
        DBMS_OUTPUT.PUT_LINE('no sirven nulos');
END;


--EJEMPLO PROCEDIMIENTO PARA MOSTRAR UN MENSAJE
--STORED PROCEDURE
create or replace procedure sp_mensaje
as
begin
    --MOSTRAMOS UN MENSAJE
    dbms_output.put_line('Hoy es juernes con música!!!');
end;
--LLAMADA AL PROCEDIMIENTO
begin
    sp_mensaje;
end;
exec sp_mensaje;
--CREAMOS EL PROCEDIMIENTO
create or replace procedure sp_ejemplo_plsql
as
begin
    --procedimiento con bloque pl/sql
    declare
        v_numero number;
    begin 
        v_numero := 14;
        if v_numero > 0 then
            dbms_output.put_line('Positivo');
        else 
            dbms_output.put_line('Negativo');
        end if;
    end;
end;
--LLAMADA
begin
    sp_ejemplo_plsql;
end;
--TENEMOS OTRA SINTAXIS PARA TENER VARIABLES
--DENTRO DE UN PROCEDIMIENTO.
--NO SE UTILIZA LA PALABRA declare
create or replace procedure sp_ejemplo_plsql2
AS
    v_numero number := 14;
begin
    if v_numero > 0 then
        dbms_output.put_line('Positivo');
    else 
        dbms_output.put_line('Negativo');
    end if;    
end;
begin
    sp_ejemplo_plsql2;
end;
--PROCEDIMIENTO PARA SUMAR DOS NUMEROS
create or replace procedure sp_sumar_numeros
(p_numero1 number, p_numero2 number)
as
    v_suma number;
begin
    v_suma := p_numero1 + p_numero2;
    dbms_output.put_line('La suma de ' || p_numero1 
    || ' + ' || p_numero2 || ' es igual a ' || v_suma);
end;
---llamada al procedimiento
begin
    sp_sumar_numeros(5, 6);
end;
--NECESITO UN PROCEDIMIENTO PARA DIVIDIR DOS NUMEROS
--SE LLAMARA sp_dividir_numeros
create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
as
begin
    declare
        v_division number;
    begin
        v_division := p_numero1 / p_numero2;
        dbms_output.put_line('La división entre ' || p_numero1 
        || ' y ' || p_numero2 || ' es igual a ' || v_division);        
    EXCEPTION
        when ZERO_DIVIDE then
            dbms_output.PUT_LINE('División entre cero. PL/SQL inner');
    end;
exception
    when ZERO_DIVIDE then
        dbms_output.put_line('División entre cero PROCEDURE');
end;


declare 
    v_dato number;
begin
    v_dato := 7/0;
    sp_dividir_numeros(7, 0);
EXCEPTION
    when ZERO_DIVIDE then
        dbms_output.put_line('División entre cero, PL/SQL outer');
end;

-- Realizar un procedimiento para insertar un nuevo departamento
CREATE OR REPLACE PROCEDURE sp_insertdept (id dept.dept_no%TYPE, nombre dept.dnombre%TYPE, localidad dept.loc%TYPE) AS
BEGIN 
    INSERT INTO DEPT VALUES (id, nombre, localidad);
END;

SELECT * FROM dept;

EXEC sp_insertdept(11, '11', '11');

ROLLBACK;

-- Insertar un nuevo departamento con el id siguiente mas alto
CREATE OR REPLACE PROCEDURE sp_insertdeptmaxid (nombre dept.dnombre%TYPE, localidad dept.loc%TYPE) AS
    v_max_id dept.dept_no%TYPE;
BEGIN 
    SELECT max(dept_no) + 1 INTO v_max_id FROM dept;
    INSERT INTO DEPT VALUES (v_max_id, upper(nombre), upper(localidad));
    COMMIT;
EXCEPTION
    WHEN no_data_found THEN 
        ROLLBACK;
END;

EXEC SP_INSERTDEPTMAXID('i+d', 'coslada')

-- Realizar un procedimiento para incrementar el salario de los empleados de un oficio
-- Enviar como parametros el oficio y el incremento
CREATE OR REPLACE PROCEDURE sp_incremento_salario_oficio (p_oficio emp.oficio%TYPE, p_incremento emp.salario%TYPE) AS
    nodatafound EXCEPTION;
BEGIN
    UPDATE emp
    SET salario = salario + p_incremento
    WHERE oficio = upper(p_oficio);
    DBMS_OUTPUT.PUT_LINE('registros afectados: ' || SQL%ROWCOUNT);
    IF SQL%NOTFOUND THEN
        RAISE nodatafound;
    ELSE
        COMMIT;
    END IF;
EXCEPTION
    WHEN nodatafound THEN
        DBMS_OUTPUT.PUT_LINE('No existe el oficio');
        ROLLBACK;
END;

EXEC sp_incremento_salario_oficio('', 100000);

SELECT oficio, salario FROM emp;

-- Insertar doctores sin pedir el id

CREATE OR REPLACE PROCEDURE sp_insertar_doctor (p_hospital_cod doctor.hospital_cod%TYPE, p_apellido doctor.apellido%TYPE, p_especialidad doctor.especialidad%TYPE, p_salario doctor.salario%TYPE) AS
    v_max_id doctor.doctor_no%TYPE;
BEGIN
    SELECT max(doctor_no) + 1 
    INTO v_max_id 
    FROM doctor;
    
    INSERT INTO doctor
    VALUES (p_hospital_cod, v_max_id, p_apellido, initcap(p_especialidad), p_salario);

EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
        ROLLBACK;
END;

EXEC sp_insertar_doctor(19, 'House D.', 'Diagnostico', 1000000);

CREATE OR REPLACE PROCEDURE sp_insertar_doctorV2 (p_hospital_name hospital.nombre%TYPE, p_apellido doctor.apellido%TYPE, p_especialidad doctor.especialidad%TYPE, p_salario doctor.salario%TYPE) AS
    v_max_id doctor.doctor_no%TYPE;
    v_hospital_cod doctor.hospital_cod%TYPE;
BEGIN
    SELECT max(doctor_no) + 1 
    INTO v_max_id 
    FROM doctor;

    SELECT hospital_cod 
    INTO v_hospital_cod 
    FROM hospital
    WHERE lower(nombre) = lower(p_hospital_name);
    
    INSERT INTO doctor
    VALUES (v_hospital_cod, v_max_id, p_apellido, initcap(p_especialidad), p_salario);

EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos del hospital');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
        ROLLBACK;
END;

SELECT * FROM doctor; 
SELECT nombre FROM hospital;

EXEC sp_insertar_doctorV2('genera', 'Wilson', 'oncologia', 1000000);

-- Realizar un procedimiento para mostrar los empleados de un departamento
CREATE OR REPLACE PROCEDURE sp_empleados_dept(p_dept_cod dept.dept_no%TYPE) AS
    CURSOR c_emp IS
    SELECT apellido, dept_no 
    FROM emp
    WHERE dept_no = p_dept_cod;
BEGIN
    FOR registro IN c_emp LOOP
        DBMS_OUTPUT.PUT_LINE('Apellido: ' || registro.apellido || ' , Departamento: ' || registro.dept_no);
    END LOOP;
END;

EXEC sp_empleados_dept(1);

desc emp;

-- Procedimiento con parametros opcionales
CREATE OR REPLACE PROCEDURE Ejemplo(p_uno int, p_dos int := 0, p_tres int := 0) AS 
BEGIN
     DBMS_OUTPUT.PUT_LINE(p_uno || p_dos || p_tres);
END;

EXEC Ejemplo(1, 1);

CREATE OR REPLACE PROCEDURE Ejemplo2(p_uno int, p_dos int := 0, p_tres int) AS 
BEGIN
     DBMS_OUTPUT.PUT_LINE(p_uno || p_dos || p_tres);
END;

EXEC Ejemplo2(1, p_tres => 2);

-- FUNCIONES
CREATE OR REPLACE FUNCTION f_sumar_numeros(p_numero1 NUMBER, p_numero2 NUMBER)
RETURN NUMBER
AS 
    v_suma NUMBER;
BEGIN
    v_suma := p_numero1 + p_numero2;
    RETURN v_suma;
END;

SELECT f_sumar_numeros(5, 6) FROM dual;



SELECT f_suma_salarial('general') FROM dual;

-- Ejemplo 1
CREATE OR REPLACE FUNCTION f_mayor(p_numero1 INT, p_numero2 INT)
RETURN INT
AS
BEGIN
    IF p_numero1 > p_numero2 THEN
    RETURN p_numero1;
    ELSE
    RETURN p_numero2;
    END IF;
END;

SELECT f_mayor(5, 5) FROM dual;

-- Ejemplo 2
CREATE OR REPLACE FUNCTION f_mayorV2(p_numero1 INT, p_numero2 INT, p_numero3 INT)
RETURN INT
AS
BEGIN
    RETURN GREATEST(p_numero1, p_numero2, p_numero3);
END;

SELECT f_mayorV2(5, 9, 7) FROM dual;

-- Ejemplo 3
CREATE OR REPLACE FUNCTION f_suma_salarial(p_hospital hospital.nombre%TYPE)
RETURN doctor.salario%TYPE
AS
    v_suma NUMBER;
BEGIN
    SELECT sum(d.salario) + sum(p.salario) INTO v_suma  
    FROM doctor d
    JOIN hospital h
    ON h.hospital_cod = d.hospital_cod
    JOIN plantilla p
    ON p.hospital_cod = d.hospital_cod
    WHERE lower(h.nombre) = lower(p_hospital);
    RETURN v_suma;
END;

-- VISTAS
CREATE OR REPLACE VIEW V_EMPLEADOS
AS
SELECT emp_no, apellido, oficio, fecha_alt, dept_no FROM emp;

SELECT * FROM v_empleados;

-- PAQUETES 
CREATE OR REPLACE PACKAGE pk_ejemplo
AS
    PROCEDURE mostrarmensaje;
END pk_ejemplo;

CREATE OR REPLACE PACKAGE BODY pk_ejemplo
AS

    PROCEDURE mostrarmensaje
    AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('soy un paquete');
    END;

END pk_ejemplo;

EXEC pk_ejemplo.mostrarmensaje;

CREATE OR REPLACE PACKAGE pk_delete
AS 
    PROCEDURE eliminar_emp(p_emp_no emp.emp_no%TYPE);
    PROCEDURE eliminar_dept(p_dept_no dept.dept_no%TYPE);
    PROCEDURE eliminar_doctor(p_doctor_no doctor.doctor_no%TYPE);
    PROCEDURE eliminar_enfermo(p_inscripcion enfermo.inscripcion%TYPE);
END pk_delete;

CREATE OR REPLACE PACKAGE BODY pk_delete
AS 
    PROCEDURE eliminar_emp(p_emp_no emp.emp_no%TYPE)
    AS
    BEGIN
        DELETE FROM emp WHERE emp_no = p_emp_no;
        COMMIT;
    END;
    
    PROCEDURE eliminar_dept(p_dept_no dept.dept_no%TYPE)
    AS
    BEGIN
        DELETE FROM dept WHERE dept_no = p_dept_no;
        COMMIT;
    END;

    PROCEDURE eliminar_doctor(p_doctor_no doctor.doctor_no%TYPE)
    AS
    BEGIN
        DELETE FROM doctor WHERE doctor_no = p_doctor_no;
        COMMIT;
    END;

    PROCEDURE eliminar_enfermo(p_inscripcion enfermo.inscripcion%TYPE)
    AS
    BEGIN
        DELETE FROM enfermo WHERE inscripcion = p_inscripcion;
        COMMIT;
    END;

END pk_delete;



CREATE OR REPLACE PACKAGE pk_emp_salary
AS
    FUNCTION minimo RETURN NUMBER;
    FUNCTION maximo RETURN NUMBER;
    FUNCTION diferencia RETURN NUMBER;
END pk_emp_salary;

CREATE OR REPLACE PACKAGE BODY pk_emp_salary
AS
    FUNCTION minimo RETURN NUMBER
    AS
        v_minimo NUMBER;
    BEGIN
        SELECT min(salario) INTO v_minimo FROM emp;
        RETURN v_minimo;
    END;

    FUNCTION maximo RETURN NUMBER
    AS
        v_maximo NUMBER;
    BEGIN
        SELECT max(salario) INTO v_maximo FROM emp;
        RETURN v_maximo;
    END;
    
    FUNCTION diferencia RETURN NUMBER
    AS
        v_diferencia NUMBER := maximo - minimo;
    BEGIN
        RETURN v_diferencia;
    END;

END pk_emp_salary;

SELECT pk_emp_salary.minimo AS minimo,
       pk_emp_salary.maximo AS maximo,
       pk_emp_salary.diferencia AS diferencia
FROM dual;

CREATE OR REPLACE PACKAGE pk_idu_dept
AS
    PROCEDURE insertDept (p_dept_no dept.dept_no%TYPE, p_dept_name dept.dnombre%TYPE, p_dept_loc dept.loc%TYPE);
    PROCEDURE deleteDept (p_dept_no dept.dept_no%TYPE);
    PROCEDURE updateDept (p_dept_no dept.dept_no%TYPE, p_dept_name dept.dnombre%TYPE, p_dept_loc dept.loc%TYPE);
END pk_idu_dept;

CREATE OR REPLACE PACKAGE BODY pk_idu_dept
AS
    PROCEDURE insertDept (p_dept_no dept.dept_no%TYPE, p_dept_name dept.dnombre%TYPE, p_dept_loc dept.loc%TYPE)
    AS
    BEGIN
        INSERT INTO dept VALUES (p_dept_no, upper(p_dept_name), upper(p_dept_loc));
        COMMIT;
    END;

    PROCEDURE deleteDept (p_dept_no dept.dept_no%TYPE)
    AS
    BEGIN
        DELETE FROM dept WHERE dept_no = p_dept_no;
        COMMIT; 
    END;

    PROCEDURE updateDept (p_dept_no dept.dept_no%TYPE, p_dept_name dept.dnombre%TYPE, p_dept_loc dept.loc%TYPE)
    AS
    BEGIN
        UPDATE dept
        SET dnombre = upper(p_dept_name),
            loc = upper(p_dept_loc)
        WHERE dept_no = p_dept_no;
    END;

END pk_idu_dept;

EXEC pk_idu_dept.INSERTDEPT(60, 'I+D', 'mallorca');

EXEC pk_idu_dept.DELETEDEPT(60);

EXEC pk_idu_dept.UPDATEDEPT(60, 'inves', 'cuba');
SELECT * FROM dept;

-- Practica 
CREATE OR REPLACE VIEW v_emp
AS
    SELECT e.apellido AS nombre, e.oficio AS trabajo, e.salario AS salario, d.dnombre AS ubicacion
    FROM emp e 
    JOIN dept d
    ON e.dept_no = d.dept_no
    UNION
    SELECT d.apellido, d.especialidad, d.salario, h.nombre
    FROM doctor d
    JOIN hospital h 
    ON d.hospital_cod = h.hospital_cod
    UNION
    SELECT p.apellido, p.funcion, p.salario, h.nombre
    FROM plantilla p
    JOIN hospital h
    ON p.hospital_cod = h.hospital_cod;

CREATE OR REPLACE PACKAGE pk_emp
AS
    PROCEDURE all_emp;
    PROCEDURE all_emp_salary(p_salario emp.salario%TYPE);
END pk_emp;

CREATE OR REPLACE PACKAGE BODY pk_emp
AS
    PROCEDURE all_emp
    AS
        CURSOR c_emp IS
        SELECT * 
        FROM v_emp;
    BEGIN
        FOR trabajador IN c_emp LOOP
            DBMS_OUTPUT.PUT_LINE(' Nombre: ' || trabajador.nombre  ||
                                 ' Trabajo: '|| trabajador.trabajo ||
                                 ' Salario: '|| trabajador.salario ||
                                 ' Puesto: ' || trabajador.ubicacion); 
        END LOOP; 
    END;

    PROCEDURE all_emp_salary(p_salario emp.salario%TYPE)
    AS
        CURSOR c_emp IS
        SELECT * 
        FROM v_emp
        WHERE salario > p_salario; 
    BEGIN
        FOR trabajador IN c_emp LOOP
            DBMS_OUTPUT.PUT_LINE(' Nombre: ' || trabajador.nombre  ||
                                 ' Trabajo: '|| trabajador.trabajo ||
                                 ' Salario: '|| trabajador.salario ||
                                 ' Puesto: ' || trabajador.ubicacion);
        END LOOP; 
    END;
END pk_emp;

EXEC pk_emp.all_emp;
EXEC pk_emp.all_emp_salary(400000);

-- Practica
CREATE OR REPLACE PACKAGE pk_incremento_random
AS 
    FUNCTION salary_random (p_doctor_no doctor.doctor_no%TYPE) RETURN doctor.salario%TYPE;
    PROCEDURE incremento_random;
END pk_incremento_random;
 
CREATE OR REPLACE PACKAGE BODY pk_incremento_random
AS 
    FUNCTION salary_random (p_doctor_no doctor.doctor_no%TYPE) 
    RETURN doctor.salario%TYPE
    AS
        v_salario doctor.salario%TYPE;
        v_incremento doctor.salario%TYPE;
    BEGIN
        SELECT salario INTO v_salario 
        FROM doctor
        WHERE doctor_no = p_doctor_no;

        IF v_salario < 200000 THEN
            v_incremento := trunc(dbms_random.value(1, 500));
            DBMS_OUTPUT.PUT_LINE('Salario menor a 200.000, incremento random: ' || v_incremento);
        ELSIF v_salario BETWEEN 200000 AND 300000 THEN
            v_incremento := trunc(dbms_random.value(1, 300));
            DBMS_OUTPUT.PUT_LINE('Salario entre 200.000 y 300.000, incremento random: ' || v_incremento);
        ELSE 
            v_incremento := trunc(dbms_random.value(1, 50));
            DBMS_OUTPUT.PUT_LINE('Salario mayor a 300.000, incremento random: ' || v_incremento);
        END IF;

        RETURN v_incremento;
    END;
    
    PROCEDURE incremento_random
    AS
        CURSOR c_doctor IS
        SELECT * 
        FROM doctor;
        v_doctor c_doctor%ROWTYPE;
        v_incremento doctor.salario%TYPE;
    BEGIN
        FOR doctores IN c_doctor LOOP
        SELECT salary_random(doctores.doctor_no) INTO v_incremento FROM dual;
        DBMS_OUTPUT.PUT_LINE(v_incremento);
        UPDATE doctor
        SET salario = salario + v_incremento
        WHERE doctor_no = doctores.doctor_no;
        COMMIT;
        END LOOP;
    END;

END pk_incremento_random;

EXEC pk_incremento_random.incremento_random;

SELECT * FROM doctor;

-- REGISTROS
DECLARE
    TYPE R_DEPT IS RECORD (
        v_dept_no NUMBER, 
        v_dnombre VARCHAR2(50), 
        v_loc VARCHAR2(50)
    );

    v_dept R_DEPT;

BEGIN
    SELECT dept_no, dnombre, loc INTO v_dept.v_dept_no, v_dept.v_dnombre, v_dept.v_loc FROM dept WHERE dept_no = 10;
    DBMS_OUTPUT.PUT_LINE(v_dept.v_dept_no || ' ' || v_dept.v_dnombre || ' ' || v_dept.v_loc);
END;

desc dept;

-- ARRAY
DECLARE
    TYPE LIST_NUM IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_numeros LIST_NUM;
BEGIN

    v_numeros(1) := 88;
    v_numeros(2) := 99;
    v_numeros(3) := 222;
    
    FOR i IN 1..v_numeros.count LOOP
        DBMS_OUTPUT.PUT_LINE(v_numeros(i));
    END LOOP;

END;


DECLARE
    TYPE LIST_DEPT IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_depts LIST_DEPT;
BEGIN
    SELECT * INTO v_depts(1) FROM dept WHERE dept_no = 10;
    SELECT * INTO v_depts(2) FROM dept WHERE dept_no = 30;

    FOR i IN 1..v_depts.count LOOP
        DBMS_OUTPUT.PUT_LINE(v_depts(i).dnombre || ', ' || v_depts(i).loc);
    END LOOP;
END;
    
-- TRIGGERS
