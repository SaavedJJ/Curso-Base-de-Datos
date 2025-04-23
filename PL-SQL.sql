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
