DECLARE
    dni NUMBER := 54692364;
    letras VARCHAR2(23) := 'TRWAGMYFPDXBNJZSQVHLCKE';
    resultado CHAR(1);
BEGIN
    resultado := SUBSTR(letras, MOD(dni, 23) + 1, 1);
    DBMS_OUTPUT.PUT_LINE('La letra del DNI ' || dni || ' es: ' || resultado);
END;