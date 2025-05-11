CREATE OR REPLACE PROCEDURE getClienteById(p_idCliente clientes.idCliente%TYPE)
AS
    v_nombre clientes.nombre%TYPE;
    v_direccion clientes.direccion%TYPE;
    v_email clientes.email%TYPE;
    v_cpostal clientes.cpostal%TYPE;
    v_paginaweb clientes.paginaWeb%TYPE;
    v_imagen_cliente clientes.imagen_cliente%TYPE;

BEGIN
    SELECT nombre, direccion, email, cpostal, paginaWeb, imagen_cliente
    INTO v_nombre, v_direccion, v_email, v_cpostal, v_paginaweb, v_imagen_cliente
    FROM clientes
    WHERE idCliente = p_idCliente;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Direccion: ' || v_direccion);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('CPostal: ' || v_cpostal);
    DBMS_OUTPUT.PUT_LINE('Pagina Web: ' || v_paginaweb);
    DBMS_OUTPUT.PUT_LINE('Imagen Cliente: ' || v_imagen_cliente);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el cliente con ID: ' || p_idCliente);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

EXEC getClienteById(3);

desc clientes;