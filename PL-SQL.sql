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




