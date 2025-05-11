CREATE OR REPLACE PROCEDURE updateClient(p_idCliente clientes.idCliente%TYPE, p_email clientes.email%TYPE, p_direccion clientes.direccion%TYPE)
AS
BEGIN
    UPDATE clientes
    SET direccion = p_direccion,
        email = p_email
    WHERE idCliente = p_idCliente;
    COMMIT; 
END;

EXEC updateClient(2, 'damian@gmail.com', 'Calle 1234');

SELECT * FROM clientes WHERE idCliente = 2;