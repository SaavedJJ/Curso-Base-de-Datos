DECLARE
    TYPE TitleVarray IS VARRAY(100) OF VARCHAR2(100);
    action_titles TitleVarray;
BEGIN
    SELECT titulo
    BULK COLLECT INTO action_titles
    FROM peliculas
    WHERE idGenero = (SELECT idGenero FROM generos WHERE genero = 'Accion'); -- Cambiar 'Acción' por el género que corresponda si es diferente

    -- Mostrar los títulos almacenados en el VARRAY
    FOR i IN 1..action_titles.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(action_titles(i));
    END LOOP;
END;
/
