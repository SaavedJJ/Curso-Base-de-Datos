CREATE OR REPLACE PROCEDURE getTitleDurationPrice(p_idPelicula peliculas.idPelicula%TYPE)
AS
    TYPE v_pelicula IS RECORD (
        v_titulo peliculas.titulo%TYPE,
        v_duracion peliculas.duracion%TYPE,
        v_precio peliculas.precio%TYPE
    );
    v_pelicula_record v_pelicula;

BEGIN
    SELECT titulo, duracion, precio INTO v_pelicula_record
    FROM peliculas
    WHERE idPelicula = p_idPelicula;

    DBMS_OUTPUT.PUT_LINE('Título: ' || v_pelicula_record.v_titulo);
    DBMS_OUTPUT.PUT_LINE('Duración: ' || v_pelicula_record.v_duracion || ' minutos');
    DBMS_OUTPUT.PUT_LINE('Precio: $' || v_pelicula_record.v_precio);
END;

EXEC getTitleDurationPrice(1);