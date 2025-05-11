CREATE OR REPLACE PROCEDURE insertarCliente(p_idCliente clientes.idCliente%TYPE, p_nombre clientes.nombre%TYPE, p_direccion clientes.direccion%TYPE)
AS
BEGIN
    INSERT INTO clientes (idCliente, nombre, direccion) VALUES (p_idCliente, p_nombre, p_direccion);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: El ID de cliente ya existe. No se puede insertar el registro.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END insertarCliente;

EXEC insertarCliente(2, 'Damian', 'Calle Falsa 321');

SELECT * FROM clientes WHERE idCliente = 2;