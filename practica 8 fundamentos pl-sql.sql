-- 1 Crear un bloque anonimo que sume dos numeros introducidos por el usuario y muestre el resultado en pantalla 
DECLARE
    v_numero1 NUMBER;
    v_numero2 NUMBER;
    v_suma NUMBER;
BEGIN
    v_numero1 := &numero1;
    v_numero2 := &numero2;
    v_suma := v_numero1 + v_numero2;
    DBMS_OUTPUT.PUT_LINE('La suma de ' || v_numero1 || ' y ' || v_numero2 || ' es: ' || v_suma);
END;

-- 2 Insertar en la tabla EMP un empleado con codigo 9999 asignado directamente en la variable con %TYPE, apellido Perez, oficio analista y codigo de departamento 10
DECLARE 
    v_cod emp.emp_no%TYPE;
    v_apellido emp.APELLIDO%TYPE;
    v_oficio emp.oficio%TYPE;
    v_deptcod emp.dept_no%TYPE;
BEGIN
    v_cod := 9999;
    v_apellido := 'perez';
    v_oficio := 'ANALISTA';
    v_deptcod := 10;
    INSERT INTO emp (emp_no, apellido, oficio, dept_no) 
    VALUES (v_cod, v_apellido, v_oficio, v_deptcod);
END; 

SELECT * FROM emp;

-- 3 Incrementar el salario en la tabla EMP en 200 euros a todos los trabajadores que sean 'ANALISTAS', mediante un bloque anonimo PL, asignando dicho valor a una variable declarada con %TYPE
DECLARE 
    v_salario_aumento emp.salario%TYPE;
BEGIN
    v_salario_aumento := 200; 
    UPDATE emp
    SET salario = salario + v_salario_aumento
    WHERE oficio = 'ANALISTA';
END;

SELECT salario FROM emp WHERE oficio = 'ANALISTA';

-- 4 Realizar un programa que devuelva el numero de cifras de un numero entero, introducido por teclado, mediante una variable de sustitucion
DECLARE 
    v_numero NUMBER;
BEGIN
    v_numero := '&numero';
    DBMS_OUTPUT.PUT_LINE('El número de cifras es: ' || LENGTH(TO_CHAR(v_numero)));
END;

-- 5 Crear un bloque PL para insertar una fila en la tabla DEPT. Todos los datos pedidos por teclado
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

-- 6 Crear un bloque PL que actualice el salario de los empleados que no cobran comision en un 5%
DECLARE 
    v_incremento_porcentaje NUMBER := 0.05; -- 5% incremento
BEGIN 
    UPDATE emp
    SET salario = salario * (1 + v_incremento_porcentaje)
    WHERE comision = 0 OR comision IS NULL;
    DBMS_OUTPUT.PUT_LINE('Salarios actualizados para empleados sin comisión.');
END;

SELECT comision, salario FROM emp;
ROLLBACK;

-- 7 Crear un bloque PL que almacene la fecha del sistema en una variable.
-- Solicitar un numero de meses por teclado y mostrar la fecha del sistema incrementado en ese numero de meses
DECLARE
    v_fechasys DATE;
    v_meses NUMBER;
    v_fecha DATE;
BEGIN
    v_fechasys := sysdate;
    v_meses := '&meses';
    v_fecha := add_months(v_fechasys, v_meses);
    DBMS_OUTPUT.PUT_LINE(to_char(v_fecha, 'day DD "de" month "del" yyyy', 'NLS_DATE_LANGUAGE=SPANISH'));
END;


-- 8 Introducir dos numeros por teclado y devolver el resto de la division de los dos numeros
DECLARE
    v_num1 NUMBER;
    v_num2 NUMBER;
    v_modulo NUMBER;
BEGIN
    v_num1 := '&num1';
    v_num2 := '&num2';
    v_modulo := mod(v_num1, v_num2);
    DBMS_OUTPUT.PUT_LINE(v_modulo);
END;

-- 9 Solicitar un nombre por teclado y devolver ese nombre con la primera inicial en Mayuscula
DECLARE
    v_nombre VARCHAR2(20);
BEGIN
    v_nombre := '&nombre';
    DBMS_OUTPUT.PUT_LINE(initcap(v_nombre));
END;

-- 10 Crear un bloque anonimo PL que permita borrar un registro de la tabla EMP introduciendo por parametro el numero de empleado
DECLARE 
    v_cod emp.emp_no%TYPE;
BEGIN
    v_cod := '&codigo';
    DELETE FROM emp
    WHERE emp_no = v_cod;
END;

SELECT * FROM emp;
