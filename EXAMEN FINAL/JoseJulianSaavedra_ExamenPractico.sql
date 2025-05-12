
-- EJERCICIO 1 ----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Distribuidoras (
    idDistribuidor INT PRIMARY KEY,
    Distribuidor VARCHAR(100),
    Direccion VARCHAR(100),
    Email VARCHAR(100),
    PaginaWeb VARCHAR(100),
    Telefono VARCHAR(15),
    Contactos VARCHAR(100),
    Logo VARCHAR(100)
);

CREATE TABLE Generos (
    idGenero INT PRIMARY KEY,
    Genero VARCHAR(50)
);

CREATE TABLE Nacionalidades (
    idNacionalidad INT PRIMARY KEY,
    Nacionalidad VARCHAR(50),
    Bandera VARCHAR(100)
);

CREATE TABLE Peliculas (
    idPelicula INT PRIMARY KEY,
    Titulo VARCHAR(100),
    FechaEstreno DATE,
    Duracion INT,
    Foto VARCHAR(100),
    Argumento VARCHAR(255),
    Actores VARCHAR(255),
    Director VARCHAR(100),
    Precio INT,
    idDistribuidor INT,
    idGenero INT,
    idNacionalidad INT,
    FOREIGN KEY (idGenero) REFERENCES Generos(idGenero),
    FOREIGN KEY (idNacionalidad) REFERENCES Nacionalidades(idNacionalidad),
    FOREIGN KEY (idDistribuidor) REFERENCES Distribuidoras(idDistribuidor)
);

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Direccion VARCHAR(100),
    CPostal VARCHAR(10),
    PaginaWeb VARCHAR(100),
    Imagen_Cliente VARCHAR(100)
);

CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    Fecha DATE,
    Precio INT,
    Cantidad INT,
    idPelicula INT,
    idCliente INT,
    FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

-- EJERCICIO 2 --------------------------------------------------------------------------------------------------------------------

INSERT INTO Clientes (idCliente, Nombre, Direccion, Email, CPostal, PaginaWeb, Imagen_Cliente)
VALUES (1, 'Cliente 1', 'Calle Falsa 123', 'cliente1@gmail.com', '28001', 'www.cliente1.com', 'cliente1.jpg');

INSERT INTO Distribuidoras (idDistribuidor, Distribuidor, Direccion, Email, PaginaWeb, Telefono, Contactos, Logo)
VALUES (1, 'Distribuidora 1', 'Calle Falsa 456', 'distribuidora1@gmail.com', 'www.distribuidora1.com', '123456789', 'Contacto 1', 'logo1.jpg');

INSERT INTO Generos (idGenero, Genero)
VALUES (1, 'Accion');

INSERT INTO Nacionalidades (idNacionalidad, Nacionalidad, Bandera)
VALUES (1, 'Española', 'bandera1.jpg');

INSERT INTO Peliculas (idPelicula, idDistribuidor, idGenero, idNacionalidad, Titulo, FechaEstreno, Duracion, Foto, Argumento, Actores, Director, Precio)
VALUES (1, 1, 1, 1, 'Pelicula 1', '01-01-2023', 120, 'pelicula1.jpg', 'Argumento de la pelicula 1', 'Actor 1, Actor 2', 'Director 1', 10);

INSERT INTO Pedidos (idPedido, idCliente, idPelicula, Fecha, Precio, Cantidad)
VALUES (1, 1, 1, '10-01-2023', 10, 2);

-- EJERCICIO 3 -------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertarCliente (p_idCliente clientes.idCliente%TYPE, 
                                             p_nombre clientes.nombre%TYPE, 
                                             p_email clientes.email%TYPE, 
                                             p_direccion clientes.direccion%TYPE,
                                             p_cPostal clientes.cPostal%TYPE,
                                             p_paginaWeb clientes.paginaWeb%TYPE,
                                             p_imagen_cliente clientes.imagen_cliente%TYPE)
AS
BEGIN
    INSERT INTO clientes 
    VALUES (p_idCliente, p_nombre, p_email, p_direccion, p_cPostal, p_paginaWeb, p_imagen_cliente);
    COMMIT;
END insertarCliente;

EXEC insertarCliente(2, 'Damian', 'damian@gmail.com', 'Calle Falsa 321', '28001', 'www.damian.com', 'damian.jpg');

SELECT * FROM clientes WHERE idCliente = 2;

-- EJERCICIO 4 -------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION obtenerPrecio (p_idPelicula peliculas.idPelicula%TYPE)
RETURN peliculas.precio%TYPE
AS
    v_precio peliculas.precio%TYPE;
BEGIN
    SELECT precio INTO v_precio FROM peliculas WHERE idPelicula = p_idPelicula;
    RETURN v_precio;
END obtenerPrecio;

SELECT obtenerPrecio(1) AS Precio_Pelicula_1 FROM DUAL;

-- EJERCICIO 5 -------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE updateClient (p_idCliente clientes.idCliente%TYPE, p_email clientes.email%TYPE, p_direccion clientes.direccion%TYPE)
AS
BEGIN
    UPDATE clientes
    SET direccion = p_direccion,
        email = p_email
    WHERE idCliente = p_idCliente;
    COMMIT; 
END;

EXEC updateClient(2, 'damiangervilla@gmail.com', 'Calle 4321');

SELECT * FROM clientes WHERE idCliente = 2;

-- EJERCICIO 6 -------------------------------------------------------------------------------------------------------

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

SELECT getFilmDuration('Pelicula 1') AS duracion_pelicula FROM DUAL;


-- EJERCICIO 7 -------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW v_peliculas 
AS
    SELECT p.titulo, p.FechaEstreno, p.Actores, p.Argumento, g.genero, n.nacionalidad 
    FROM peliculas p
    JOIN generos g 
    ON p.idGenero = g.idGenero
    JOIN nacionalidades n
    ON p.idNacionalidad = n.idNacionalidad;

SELECT * FROM v_peliculas;

-- EJERCICIO 8 -------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE getView
AS
    CURSOR c_peliculas IS 
        SELECT *
        FROM v_peliculas;
BEGIN
    FOR r_pelicula IN c_peliculas LOOP
        DBMS_OUTPUT.PUT_LINE('Titulo: ' || r_pelicula.titulo || ', Genero: ' || r_pelicula.genero || ', Nacionalidad: ' || r_pelicula.nacionalidad);
    END LOOP;
END getView;

EXEC getView;

    

SELECT * FROM v_peliculas WHERE nacionalidad = 'Española';