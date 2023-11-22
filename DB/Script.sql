USE [master]
GO
/****** Object:  Database [Biblioteca]    Script Date: 22/11/2023 10:29:08 ******/
CREATE DATABASE [Biblioteca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Biblioteca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Biblioteca_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Biblioteca] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteca] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [Biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteca] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Biblioteca] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Biblioteca] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Biblioteca', N'ON'
GO
ALTER DATABASE [Biblioteca] SET QUERY_STORE = ON
GO
ALTER DATABASE [Biblioteca] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Biblioteca]
GO
/****** Object:  Table [dbo].[Libro]    Script Date: 22/11/2023 10:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Libro](
	[ISBN] [varchar](13) NOT NULL,
	[Titulo] [varchar](255) NULL,
	[Autor] [varchar](255) NULL,
	[Editorial] [varchar](255) NULL,
	[AnoPublicacion] [int] NULL,
	[CopiasDisponibles] [int] NULL,
	[Genero] [varchar](50) NULL,
	[FechaBaja] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Socio]    Script Date: 22/11/2023 10:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Socio](
	[IDUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Direccion] [varchar](255) NULL,
	[Telefono] [varchar](15) NULL,
	[Correo] [varchar](100) NULL,
	[LibrosPrestados] [int] NULL,
	[FechaBaja] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamo]    Script Date: 22/11/2023 10:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamo](
	[IDPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[IDLibro] [varchar](13) NULL,
	[IDUsuario] [int] NULL,
	[FechaPrestamo] [date] NULL,
	[FechaDevolucionPrevista] [date] NULL,
	[FechaDevolucionReal] [date] NULL,
	[Status] [varchar](20) NULL,
	[FechaBaja] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaPrestamo]    Script Date: 22/11/2023 10:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaPrestamo] AS
SELECT P.IDPrestamo, L.Titulo AS TituloLibro, S.Nombre AS NombreSocio, P.FechaPrestamo, P.FechaDevolucionPrevista, P.FechaDevolucionReal, P.Status
FROM Prestamo P
JOIN Libro L ON P.IDLibro = L.ISBN
JOIN Socio S ON P.IDUsuario = S.IDUsuario
WHERE P.FechaBaja IS NULL AND L.FechaBaja IS NULL AND S.FechaBaja IS NULL;

GO
/****** Object:  View [dbo].[VistaLibro]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Vista para obtener información detallada de los libros
CREATE VIEW [dbo].[VistaLibro] AS
SELECT ISBN, Titulo, Autor, Editorial, AnoPublicacion, CopiasDisponibles, Genero
FROM Libro
WHERE FechaBaja IS NULL;
GO
/****** Object:  View [dbo].[VistaSocio]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaSocio] AS
SELECT IDUsuario, Nombre, Direccion, Telefono, Correo, LibrosPrestados
FROM Socio
WHERE FechaBaja IS NULL;
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[IDEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Cargo] [varchar](50) NULL,
	[Telefono] [varchar](15) NULL,
	[Correo] [varchar](100) NULL,
	[FechaBaja] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaEmpleado]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaEmpleado] AS
SELECT IDEmpleado, Nombre, Cargo, Telefono, Correo
FROM Empleado
WHERE FechaBaja IS NULL;
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD FOREIGN KEY([IDLibro])
REFERENCES [dbo].[Libro] ([ISBN])
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Socio] ([IDUsuario])
GO
/****** Object:  StoredProcedure [dbo].[AgregarEmpleado]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarEmpleado]
    @Nombre VARCHAR(100),
    @Cargo VARCHAR(50),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    INSERT INTO Empleado (Nombre, Cargo, Telefono, Correo)
    VALUES (@Nombre, @Cargo, @Telefono, @Correo);
END;
GO
/****** Object:  StoredProcedure [dbo].[AgregarLibro]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarLibro]
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
GO
/****** Object:  StoredProcedure [dbo].[AgregarSocio]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarSocio]
    @Nombre VARCHAR(100),
    @Direccion VARCHAR(255),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    INSERT INTO Socio (Nombre, Direccion, Telefono, Correo)
    VALUES (@Nombre, @Direccion, @Telefono, @Correo);
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarEmpleado]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarEmpleado]
    @IDEmpleado INT
AS
BEGIN
    UPDATE Empleado
    SET FechaBaja = GETDATE()
    WHERE IDEmpleado = @IDEmpleado AND FechaBaja IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarLibro]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarLibro]
    @ISBN VARCHAR(13)
AS
BEGIN
    UPDATE Libro
    SET FechaBaja = GETDATE()
    WHERE ISBN = @ISBN AND FechaBaja IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarSocio]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarSocio]
    @IDUsuario INT
AS
BEGIN
    UPDATE Socio
    SET FechaBaja = GETDATE()
    WHERE IDUsuario = @IDUsuario AND FechaBaja IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[ModificarEmpleado]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarEmpleado]
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
GO
/****** Object:  StoredProcedure [dbo].[ModificarLibro]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLibro]
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
GO
/****** Object:  StoredProcedure [dbo].[ModificarSocio]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarSocio]
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
GO
/****** Object:  StoredProcedure [dbo].[RealizarDevolucion]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RealizarDevolucion]
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
GO
/****** Object:  StoredProcedure [dbo].[RealizarPrestamo]    Script Date: 22/11/2023 10:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RealizarPrestamo]
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
GO
USE [master]
GO
ALTER DATABASE [Biblioteca] SET  READ_WRITE 
GO
