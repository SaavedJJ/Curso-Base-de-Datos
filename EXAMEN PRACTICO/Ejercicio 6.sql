CREATE OR REPLACE FUNCTION getPhoneDistribuidoras(p_nombre distribuidoras.distribuidor%TYPE)
RETURN distribuidoras.telefono%TYPE 
AS
    v_telefono distribuidoras.telefono%TYPE;
BEGIN
    SELECT telefono INTO v_telefono
    FROM distribuidoras
    WHERE distribuidor = p_nombre;
    
    RETURN v_telefono;
END;

UPDATE distribuidoras
SET telefono = 2123456789
WHERE idDistribuidor = 1;

SELECT getPhoneDistribuidoras('Distribuidora 1') FROM dual;