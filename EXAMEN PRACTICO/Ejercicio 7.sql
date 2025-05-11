CREATE OR REPLACE FUNCTION getFilmDuration(p_titulo peliculas.titulo%TYPE)
RETURN peliculas.duracion%TYPE
AS
    v_duracion peliculas.duracion%TYPE;
BEGIN
    SELECT duracion INTO v_duracion 
    FROM peliculas
    WHERE titulo = p_titulo;

    RETURN v_duracion;
END;

UPDATE peliculas 
SET duracion = 60
WHERE titulo = 'Pelicula 1';

SELECT * FROM PELICULAS;

SELECT getFilmDuration('Pelicula 1') AS duracion_pelicula FROM DUAL;

desc peliculas;