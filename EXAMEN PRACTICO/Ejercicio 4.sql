CREATE OR REPLACE PROCEDURE filmPrice (p_idPelicula peliculas.idPelicula%TYPE)
AS
    v_precio peliculas.precio%TYPE;
BEGIN
    SELECT precio INTO v_precio FROM peliculas WHERE idPelicula = p_idPelicula;
    DBMS_OUTPUT.PUT_LINE(v_precio);
END;

UPDATE peliculas SET precio = 10 WHERE idPelicula = 1;

EXEC filmPrice(1);