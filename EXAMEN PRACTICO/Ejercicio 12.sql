CREATE OR REPLACE PROCEDURE getPrice (p_idPelicula peliculas.idPelicula%TYPE, p_salida OUT peliculas.precio%TYPE)
AS
    v_precio peliculas.precio%TYPE;
BEGIN
    SELECT precio INTO v_precio FROM peliculas WHERE idPelicula = p_idPelicula;
    p_salida := v_precio;    
END;

DECLARE
    v_precio peliculas.precio%TYPE;
BEGIN
    getPrice(1, v_precio);
    DBMS_OUTPUT.PUT_LINE('El precio de la película con ID 1 es: ' || v_precio);
END;

