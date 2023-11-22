CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE Libro (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titulo VARCHAR(255),
    Autor VARCHAR(255),
    Editorial VARCHAR(255),
    AnoPublicacion INT,
    CopiasDisponibles INT,
    Genero VARCHAR(50),
    FechaBaja DATE
);

CREATE TABLE Socio (
    IDUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Direccion VARCHAR(255),
    Telefono VARCHAR(15),
    Correo VARCHAR(100),
    LibrosPrestados INT,
    FechaBaja DATE
);


CREATE TABLE Prestamo (
    IDPrestamo INT PRIMARY KEY IDENTITY(1,1),
    IDLibro VARCHAR(13),
    IDUsuario INT,
    FechaPrestamo DATE,
    FechaDevolucionPrevista DATE,
    FechaDevolucionReal DATE,
    Status VARCHAR(20),
    FechaBaja DATE,
    FOREIGN KEY (IDLibro) REFERENCES Libro(ISBN),
    FOREIGN KEY (IDUsuario) REFERENCES Socio(IDUsuario)
);


CREATE TABLE Empleado (
    IDEmpleado INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Cargo VARCHAR(50),
    Telefono VARCHAR(15),
    Correo VARCHAR(100),
    FechaBaja DATE
);

CREATE VIEW VistaPrestamo AS
SELECT P.IDPrestamo, L.Titulo AS TituloLibro, S.Nombre AS NombreSocio, P.FechaPrestamo, P.FechaDevolucionPrevista, P.FechaDevolucionReal, P.Status
FROM Prestamo P
JOIN Libro L ON P.IDLibro = L.ISBN
JOIN Socio S ON P.IDUsuario = S.IDUsuario
WHERE P.FechaBaja IS NULL AND L.FechaBaja IS NULL AND S.FechaBaja IS NULL;


CREATE VIEW VistaLibro AS
SELECT ISBN, Titulo, Autor, Editorial, AnoPublicacion, CopiasDisponibles, Genero
FROM Libro
WHERE FechaBaja IS NULL;

CREATE VIEW VistaSocio AS
SELECT IDUsuario, Nombre, Direccion, Telefono, Correo, LibrosPrestados
FROM Socio
WHERE FechaBaja IS NULL;

CREATE VIEW VistaEmpleado AS
SELECT IDEmpleado, Nombre, Cargo, Telefono, Correo
FROM Empleado
WHERE FechaBaja IS NULL;


CREATE PROCEDURE RealizarPrestamo
    @IDLibro VARCHAR(13),
    @IDUsuario INT,
    @FechaPrestamo DATE,
    @FechaDevolucionPrevista DATE
AS
BEGIN
    INSERT INTO Prestamo (IDLibro, IDUsuario, FechaPrestamo, FechaDevolucionPrevista, Status)
    VALUES (@IDLibro, @IDUsuario, @FechaPrestamo, @FechaDevolucionPrevista, 'Prestado');

    UPDATE Libro
    SET CopiasDisponibles = CopiasDisponibles - 1
    WHERE ISBN = @IDLibro;

    UPDATE Socio
    SET LibrosPrestados = LibrosPrestados + 1
    WHERE IDUsuario = @IDUsuario;
END;

CREATE PROCEDURE RealizarDevolucion
    @IDPrestamo INT,
    @FechaDevolucionReal DATE
AS
BEGIN
    DECLARE @IDLibro VARCHAR(13);
    DECLARE @IDUsuario INT;

    SELECT @IDLibro = IDLibro, @IDUsuario = IDUsuario
    FROM Prestamo
    WHERE IDPrestamo = @IDPrestamo;

    UPDATE Prestamo
    SET FechaDevolucionReal = @FechaDevolucionReal, Status = 'Devuelto'
    WHERE IDPrestamo = @IDPrestamo;

    UPDATE Libro
    SET CopiasDisponibles = CopiasDisponibles + 1
    WHERE ISBN = @IDLibro;

    UPDATE Socio
    SET LibrosPrestados = LibrosPrestados - 1
    WHERE IDUsuario = @IDUsuario;
END;

CREATE PROCEDURE AgregarLibro
    @ISBN VARCHAR(13),
    @Titulo VARCHAR(255),
    @Autor VARCHAR(255),
    @Editorial VARCHAR(255),
    @AnoPublicacion INT,
    @CopiasDisponibles INT,
    @Genero VARCHAR(50)
AS
BEGIN
    INSERT INTO Libro (ISBN, Titulo, Autor, Editorial, AnoPublicacion, CopiasDisponibles, Genero)
    VALUES (@ISBN, @Titulo, @Autor, @Editorial, @AnoPublicacion, @CopiasDisponibles, @Genero);
END;

CREATE PROCEDURE AgregarSocio
    @Nombre VARCHAR(100),
    @Direccion VARCHAR(255),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    INSERT INTO Socio (Nombre, Direccion, Telefono, Correo)
    VALUES (@Nombre, @Direccion, @Telefono, @Correo);
END;

CREATE PROCEDURE AgregarEmpleado
    @Nombre VARCHAR(100),
    @Cargo VARCHAR(50),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    INSERT INTO Empleado (Nombre, Cargo, Telefono, Correo)
    VALUES (@Nombre, @Cargo, @Telefono, @Correo);
END;

CREATE PROCEDURE ModificarLibro
    @ISBN VARCHAR(13),
    @Titulo VARCHAR(255),
    @Autor VARCHAR(255),
    @Editorial VARCHAR(255),
    @AnoPublicacion INT,
    @CopiasDisponibles INT,
    @Genero VARCHAR(50)
AS
BEGIN
    UPDATE Libro
    SET Titulo = @Titulo, Autor = @Autor, Editorial = @Editorial, AnoPublicacion = @AnoPublicacion,
        CopiasDisponibles = @CopiasDisponibles, Genero = @Genero
    WHERE ISBN = @ISBN AND FechaBaja IS NULL;
END;

CREATE PROCEDURE ModificarSocio
    @IDUsuario INT,
    @Nombre VARCHAR(100),
    @Direccion VARCHAR(255),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE Socio
    SET Nombre = @Nombre, Direccion = @Direccion, Telefono = @Telefono, Correo = @Correo
    WHERE IDUsuario = @IDUsuario AND FechaBaja IS NULL;
END;

CREATE PROCEDURE ModificarEmpleado
    @IDEmpleado INT,
    @Nombre VARCHAR(100),
    @Cargo VARCHAR(50),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE Empleado
    SET Nombre = @Nombre, Cargo = @Cargo, Telefono = @Telefono, Correo = @Correo
    WHERE IDEmpleado = @IDEmpleado AND FechaBaja IS NULL;
END;

CREATE PROCEDURE EliminarLibro
    @ISBN VARCHAR(13)
AS
BEGIN
    UPDATE Libro
    SET FechaBaja = GETDATE()
    WHERE ISBN = @ISBN AND FechaBaja IS NULL;
END;

CREATE PROCEDURE EliminarSocio
    @IDUsuario INT
AS
BEGIN
    UPDATE Socio
    SET FechaBaja = GETDATE()
    WHERE IDUsuario = @IDUsuario AND FechaBaja IS NULL;
END;

CREATE PROCEDURE EliminarEmpleado
    @IDEmpleado INT
AS
BEGIN
    UPDATE Empleado
    SET FechaBaja = GETDATE()
    WHERE IDEmpleado = @IDEmpleado AND FechaBaja IS NULL;
END;



