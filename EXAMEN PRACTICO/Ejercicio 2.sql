INSERT INTO Clientes (idCliente, Nombre, Direccion)
VALUES (1, 'Juan Perez', 'Miguel peña 8');

INSERT INTO Distribuidoras (idDistribuidor, Distribuidor, Direccion)
VALUES (1, 'Distribuidora 1', 'Calle Falsa 123');

INSERT INTO Generos (idGenero, Genero)
VALUES (1, 'Accion');

INSERT INTO Nacionalidades (idNacionalidad, Nacionalidad)
VALUES (1, 'Española');

INSERT INTO Peliculas (idPelicula, idDistribuidor, idGenero, idNacionalidad, Titulo)
VALUES (1, 1, 1, 1, 'Pelicula 1');

INSERT INTO Pedidos (idPedido, idCliente, idPelicula, Fecha, Precio, Cantidad)
VALUES (1, 1, 1, '10-01-2023', 10, 2);


