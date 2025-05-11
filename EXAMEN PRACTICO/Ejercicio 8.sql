CREATE OR REPLACE FUNCTION getTotalVentasPorCliente(p_idCliente clientes.idCliente%TYPE)
RETURN pedidos.precio%TYPE
AS
    v_totalVentas pedidos.precio%TYPE;
BEGIN
    SELECT SUM(precio)
    INTO v_totalVentas
    FROM pedidos
    WHERE idCliente = p_idCliente;
    
    RETURN v_totalVentas;
END;


SELECT getTotalVentasPorCliente(1) AS total_ventas FROM dual;



