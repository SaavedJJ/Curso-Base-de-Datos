CREATE OR REPLACE PROCEDURE getGenero(p_idGenero generos.idGenero%TYPE)
AS
    v_genero generos%ROWTYPE;
    CURSOR c_genero IS
        SELECT * FROM generos WHERE idGenero = p_idGenero;
BEGIN
    FOR r_genero IN c_genero LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || r_genero.idGenero || ', Nombre: ' || r_genero.genero);
    END LOOP;
END;

EXEC getGenero(1);