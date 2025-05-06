CREATE OR REPLACE FUNCTION f_numero_narcisista (p_numero VARCHAR2)
RETURN INT
AS
    narcisista INT := 0;
BEGIN
    FOR i IN 1..length(p_numero) LOOP
        narcisista := narcisista + power(to_number(substr(p_numero, i, 1)), length(p_numero));
    END LOOP;
 RETURN narcisista;
END;

SELECT f_numero_narcisista('154') FROM dual;