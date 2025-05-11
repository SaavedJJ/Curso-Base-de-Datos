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




