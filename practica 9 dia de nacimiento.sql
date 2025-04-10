-- Pedir dia mes y año de nacimiento y calcular que dia de la semana naciste
DECLARE
    fecha DATE;
    dia NUMBER;
    mes NUMBER;
    anio NUMBER;
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
        anio := anip - 1;
    END IF;

    mes :=     

    DBMS_OUTPUT.PUT_LINE();
END;