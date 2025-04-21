/* 
Pedir dia mes y año de nacimiento y calcular que dia de la semana naciste
*/

DECLARE
    fecha DATE;
    dia NUMBER;
    mes NUMBER;
    anio NUMBER;
    operacion1 NUMBER;
    operacion2 NUMBER;
    operacion3 NUMBER;
    operacion4 NUMBER;
    operacion5 NUMBER;
    operacion6 NUMBER;
    numero_final NUMBER;
BEGIN
    fecha := TO_DATE('14/02/2003', 'DD/MM/YYYY');
    dia := EXTRACT(DAY FROM fecha);
    mes := EXTRACT(MONTH FROM fecha);
    anio := EXTRACT(YEAR FROM fecha);
    IF(mes = 1) THEN
        mes := 13;
        anio := anio - 1;
    ELSIF(mes = 2) THEN
        mes := 14;
        anio := anio - 1;
    END IF;
    operacion1 := ((mes + 1) * 3) / 5;
    operacion2 := anio / 4; 
    operacion3 := anio / 100;
    operacion4 := anio / 400;
    operacion5 := dia + (mes * 2) + anio + trunc(operacion1) + trunc(operacion2) - trunc(operacion3) + trunc(operacion4) + 2;
    operacion6 := trunc(operacion5) / 7;
    numero_final := trunc(operacion5) - (trunc(operacion6) * 7);
    
    IF(numero_final = 0) THEN
        DBMS_OUTPUT.PUT_LINE('Sabado');
    ELSIF(numero_final = 1) THEN 
        DBMS_OUTPUT.PUT_LINE('Domingo');
    ELSIF(numero_final = 2) THEN 
        DBMS_OUTPUT.PUT_LINE('Lunes');
    ELSIF(numero_final = 3) THEN 
        DBMS_OUTPUT.PUT_LINE('Martes');
    ELSIF(numero_final = 4) THEN 
        DBMS_OUTPUT.PUT_LINE('Miercoles');
    ELSIF(numero_final = 5) THEN 
        DBMS_OUTPUT.PUT_LINE('Jueves'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Viernes'); 
    END IF;
END;
