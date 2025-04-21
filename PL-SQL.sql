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