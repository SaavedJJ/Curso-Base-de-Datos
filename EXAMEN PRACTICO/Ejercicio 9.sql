CREATE OR REPLACE PROCEDURE getFlagNacionality (p_idNacionalidad nacionalidades.idNacionalidad%TYPE, p_bandera OUT nacionalidades.bandera%TYPE, p_nacionalidad OUT nacionalidades.nacionalidad%TYPE) 
AS
    v_nacionalidad nacionalidades.nacionalidad%TYPE;
    v_bandera nacionalidades.bandera%TYPE;
BEGIN
    SELECT nacionalidad, bandera INTO v_nacionalidad, v_bandera
    FROM nacionalidades
    WHERE idNacionalidad = p_idNacionalidad;
    p_bandera := v_bandera;
    p_nacionalidad := v_nacionalidad;
END;

DECLARE
    v_bandera nacionalidades.bandera%TYPE;
    v_nacionalidad nacionalidades.nacionalidad%TYPE;
BEGIN
    getFlagNacionality(1, v_bandera, v_nacionalidad);
    DBMS_OUTPUT.PUT_LINE('La bandera de la nacionalidad con ID 1 es: ' || v_bandera);
    DBMS_OUTPUT.PUT_LINE('La nacionalidad con ID 1 es: ' || v_nacionalidad);
END;

desc Nacionalidad