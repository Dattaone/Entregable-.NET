USE [master]
GO
/****** Object:  Database [DBCARRITO]    Script Date: 2/06/2024 23:15:23 ******/
CREATE DATABASE [DBCARRITO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBCARRITO', FILENAME = N'C:\sql\DBCARRITO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBCARRITO_log', FILENAME = N'C:\sql\DBCARRITO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBCARRITO] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBCARRITO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBCARRITO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBCARRITO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBCARRITO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBCARRITO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBCARRITO] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBCARRITO] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBCARRITO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBCARRITO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBCARRITO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBCARRITO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBCARRITO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBCARRITO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBCARRITO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBCARRITO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBCARRITO] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBCARRITO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBCARRITO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBCARRITO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBCARRITO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBCARRITO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBCARRITO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBCARRITO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBCARRITO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBCARRITO] SET  MULTI_USER 
GO
ALTER DATABASE [DBCARRITO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBCARRITO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBCARRITO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBCARRITO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBCARRITO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBCARRITO] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBCARRITO] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBCARRITO] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBCARRITO]
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Venta]    Script Date: 2/06/2024 23:15:23 ******/
CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[Total] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[MARCA]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCA](
	[IdMarca] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](500) NULL,
	[Descripcion] [varchar](500) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[Precio] [decimal](10, 2) NULL,
	[Stock] [int] NULL,
	[RutaImagen] [varchar](100) NULL,
	[NombreImagen] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CARRITO]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARRITO](
	[IdCarrito] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NULL,
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_obtenerCarritoCliente]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_obtenerCarritoCliente] (
    @IdCliente int
)
returns table
as
return(
select p.IdProducto,m.Descripcion[DesMarca],p.Nombre,p.Precio,c.Cantidad,p.RutaImagen,p.NombreImagen 
from CARRITO c
inner join PRODUCTO p on p.IdProducto=c.IdProducto
inner join MARCA m on m.IdMarca = p.IdMarca
where c.IdCliente = @IdCliente
)
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellidos] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Clave] [varchar](150) NULL,
	[Reestablecer] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEPARTAMENTO]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEPARTAMENTO](
	[IdDepartamento] [varchar](2) NOT NULL,
	[Descripcion] [varchar](45) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_VENTA]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VENTA](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NULL,
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[Total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DISTRITO]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISTRITO](
	[IdDistrito] [varchar](6) NOT NULL,
	[Descripcion] [varchar](45) NOT NULL,
	[IdProvincia] [varchar](4) NOT NULL,
	[IdDepartamento] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVINCIA]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVINCIA](
	[IdProvincia] [varchar](4) NOT NULL,
	[Descripcion] [varchar](45) NOT NULL,
	[IdDepartamento] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellidos] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Clave] [varchar](150) NULL,
	[Reestablecer] [bit] NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENTA]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENTA](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NULL,
	[TotalProducto] [int] NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[Contacto] [varchar](50) NULL,
	[IdDistrito] [varchar](10) NULL,
	[Telefono] [varchar](50) NULL,
	[Direccion] [varchar](500) NULL,
	[IdTransaccion] [varchar](50) NULL,
	[FechaVenta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [Reestablecer]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[MARCA] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MARCA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT ((1)) FOR [Reestablecer]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[VENTA] ADD  DEFAULT (getdate()) FOR [FechaVenta]
GO
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[CLIENTE] ([IdCliente])
GO
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD FOREIGN KEY([IdMarca])
REFERENCES [dbo].[MARCA] ([IdMarca])
GO
ALTER TABLE [dbo].[VENTA]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[CLIENTE] ([IdCliente])
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarCategoria]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditarCategoria](
 @IdCategoria int,
 @Descripcion varchar(100),
 @Activo bit,
 @Mensaje varchar(500) output,
 @Resultado bit output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria != @IdCategoria)
 begin
 update top (1) CATEGORIA set
 Descripcion = @Descripcion,
 Activo = @Activo
 where IdCategoria = @IdCategoria
 SET @Resultado = 1
 end
 else
 set @Mensaje = 'La Categoria ya Existe'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarMarca]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditarMarca](
 @IdMarca int,
 @Descripcion varchar(100),
 @Activo bit,
 @Mensaje varchar(500) output,
 @Resultado bit output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion and IdMarca != @IdMarca)
 begin
 update top (1) Marca set
 Descripcion = @Descripcion,
 Activo = @Activo
 where IdMarca = @IdMarca
 SET @Resultado = 1
 end
 else
 set @Mensaje = 'La Marca ya Existe'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarProducto]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditarProducto](
@IdProducto int,
@Nombre varchar(100),
@Descripcion varchar(100),
@IdMarca varchar(100),
@IdCategoria varchar(100),
@Precio decimal(10,2),
@stock int,
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre AND IdProducto != @IdProducto)
	begin 
		update PRODUCTO set
		Nombre = @Nombre,
		Descripcion = @Descripcion,
		IdMarca = @IdMarca,
		IdCategoria = @IdCategoria,
		Precio = @Precio,
		Stock = @Stock,
		Activo = @Activo
		where IdProducto = @IdProducto

		SET @Resultado = 1
	end 
	else 
		set @Mensaje = 'El producto ya existe'
end

GO
/****** Object:  StoredProcedure [dbo].[sp_EditarUsuario]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_EditarUsuario](
@IdUsuario int,
@Nombre varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo and @IdUsuario != @IdUsuario)
 begin
 update top (1) USUARIO set
 Nombre = @Nombre,
 Apellidos = @Apellidos,
 Correo = @Correo,
 Activo = @Activo
 where IdUsuario = @IdUsuario
 set @Resultado = 1
 end
 else
 set @Mensaje = 'El correo del usuario ya existte'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarCarrito]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EliminarCarrito](
    @IdCliente int,
    @IdProducto int,
    @Resultado bit OUTPUT
)
as
begin
set @Resultado = 1
declare @cantidadproducto int = (select Cantidad from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto)
begin try
begin transaction OPERACION
update PRODUCTO set Stock = Stock + @cantidadproducto where IdProducto = @IdProducto
delete top (1) from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto
commit transaction OPERACION
end try
begin catch
set @Resultado = 0
rollback transaction OPERACION
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarCategoria]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_EliminarCategoria](
 @IdCategoria int,
 @Mensaje varchar(500) output,
 @Resultado bit output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (
 select * from PRODUCTO p
 inner join CATEGORIA c on c.IdCategoria = p.IdCategoria
 where p.IdCategoria=@IdCategoria)
 begin
 delete top (1) from CATEGORIA where IdCategoria = @IdCategoria
 set @Resultado = 1
 end
 else
 set @Mensaje = 'La Categoria se Encuentra Relacionado a un Producto'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarMarca]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EliminarMarca](
 @IdMarca int,
 @Mensaje varchar(500) output,
 @Resultado bit output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (
 select * from PRODUCTO p
 inner join MARCA m on m.IdMarca = p.IdMarca
 where p.IdMarca=@IdMarca)
 begin
 delete top (1) from MARCA where IdMarca = @IdMarca
 set @Resultado = 1
 end
 else
 set @Mensaje = 'La Marca se Encuentra Relacionado a un Producto'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarProducto]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_EliminarProducto](
@IdProducto int,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM DETALLE_VENTA dv 
	Inner Join PRODUCTO p on p.IdProducto = dv.IdProducto
	where p.IdProducto = @IdProducto)
	begin 
		delete top (1) from PRODUCTO where IdProducto = @IdProducto
		SET @Resultado = 1
	end 
	else 
		set @Mensaje = 'El producto se encuentra relacionado a una venta'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ExisteCarrito]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExisteCarrito] (
    @IdCliente int,
    @IdProducto int,
    @Resultado bit OUTPUT
)
as
begin if exists(select * from carrito where idcliente = @IdCliente and idproducto = @IdProducto)
set @Resultado = 1
else 
set @Resultado = 0
end 
GO
/****** Object:  StoredProcedure [dbo].[sp_OperacionCarrito]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_OperacionCarrito] 
(
    @IdCliente int,
    @IdProducto int,
    @Sumar bit,
    @Mensaje varchar(500) OUTPUT,
    @Resultado bit OUTPUT
)
AS
BEGIN
    SET @Resultado = 1
    SET @Mensaje = ''

    DECLARE @existecarrito bit = IIF(EXISTS(SELECT * FROM CARRITO WHERE idcliente = @IdCliente AND idproducto = @IdProducto), 1, 0)
    DECLARE @stockproducto int = (SELECT Stock FROM PRODUCTO WHERE IdProducto = @IdProducto)

    BEGIN TRY
        BEGIN TRANSACTION OPERACION;

        IF (@Sumar = 1)
        BEGIN
            IF (@stockproducto > 0)
            BEGIN
                IF (@existecarrito = 1)
                    UPDATE CARRITO SET Cantidad = Cantidad + 1 WHERE idcliente = @IdCliente AND idproducto = @IdProducto
                ELSE
                    INSERT INTO CARRITO (IdCliente, IdProducto, Cantidad) VALUES (@IdCliente, @IdProducto, 1)

                UPDATE PRODUCTO SET Stock = Stock - 1 WHERE IdProducto = @IdProducto
            END
            ELSE
            BEGIN
                SET @Resultado = 0
                SET @Mensaje = 'El Producto no Cuenta con Stock Disponible'
            END
        END
        ELSE
        BEGIN
            UPDATE CARRITO SET Cantidad = Cantidad - 1 WHERE idcliente = @IdCliente AND idproducto = @IdProducto

            UPDATE PRODUCTO SET Stock = Stock + 1 WHERE IdProducto = @IdProducto
        END

        COMMIT TRANSACTION OPERACION
    END TRY
    BEGIN CATCH
        SET @Resultado = 0
        SET @Mensaje = ERROR_MESSAGE()
        ROLLBACK TRANSACTION OPERACION
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCategoria]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[sp_RegistrarCategoria](
 @Descripcion varchar(100),
 @Activo bit,
 @Mensaje varchar(500) output,
 @Resultado int output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
 begin
 insert into CATEGORIA (Descripcion, Activo) values
 (@Descripcion, @Activo)
 SET @Resultado = SCOPE_IDENTITY()
 end
 else
 set @Mensaje = 'La Categoria ya Existe'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCliente]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarCliente](
@Nombre varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CLIENTE where Correo = @Correo)
	begin 
		insert into CLIENTE(Nombre,Apellidos,Correo,Clave, Reestablecer) values
		(@Nombre, @Apellidos,@Correo,@Clave,0)
		SET @Resultado = SCOPE_IDENTITY()
	end 
	else 
		set @Mensaje = 'El Correo del Usuario ya Existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarMarca]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarMarca](
 @Descripcion varchar(100),
 @Activo bit,
 @Mensaje varchar(500) output,
 @Resultado int output
 )
 as
 begin
 SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
 begin
 insert into MARCA (Descripcion, Activo) values
 (@Descripcion, @Activo)
 SET @Resultado = SCOPE_IDENTITY()
 end
 else
 set @Mensaje = 'La Marca ya Existe'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarProducto]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarProducto](
@Nombre varchar(100),
@Descripcion varchar(100),
@IdMarca varchar(100),
@IdCategoria varchar(100),
@Precio decimal(10,2),
@stock int,
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
	begin 
		insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria, Precio, Stock, Activo) values
		(@Nombre, @Descripcion,@IdMarca,@IdCategoria,@Precio,@Stock,@Activo)

		SET @Resultado = scope_identity()
	end 
	else 
		set @Mensaje = 'El producto ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarUsuario]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_RegistrarUsuario](
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Clave varchar(150),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
SET @Resultado = 0
 IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
 begin
 insert into USUARIO(Nombre,Apellidos,Correo,Clave,Activo) values
 (@Nombres, @Apellidos, @Correo, @Clave, @Activo)
 SET @Resultado = SCOPE_IDENTITY()
 end
 else
 set @Mensaje = 'El correo del usuario ya existte'
 end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteDashboard]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ReporteDashboard]
as
begin
select
(select count(*) from CLIENTE)[TotalCliente],
(select isnull(sum(cantidad),0) from DETALLE_VENTA)[TotalVenta],
(select count(*) from PRODUCTO)[TotalProducto]
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentas]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ReporteVentas](
@fechainicio varchar(10),
@fechafin varchar(10),
@idtransaccion varchar(50)
)
as
begin
set dateformat dmy;
select CONVERT (VARCHAR,v.FechaVenta,103)[FechaVenta],CONCAT(c.Nombre,' ',c.Apellidos)[Cliente],
p.Nombre[Producto],p.Precio,dv.Cantidad,dv.Total,v.IdTransaccion
from DETALLE_VENTA dv
inner join PRODUCTO p on p.IdProducto = dv.IdProducto
inner join VENTA v on v.IdVenta = dv.IdVenta
inner join CLIENTE c on c.IdCliente = v.IdCliente
where CONVERT(date, v.FechaVenta) between @fechainicio and @fechafin
and v.IdTransaccion = iif(@idtransaccion = '',v.IdTransaccion,@idtransaccion)
end
GO
/****** Object:  StoredProcedure [dbo].[usp_RegistrarVenta]    Script Date: 2/06/2024 23:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RegistrarVenta](
    @IdCliente INT,
    @TotalProducto INT,
    @MontoTotal DECIMAL(18,2),
    @Contacto VARCHAR(100),
    @IdDistrito VARCHAR(6),
    @Telefono VARCHAR(10),
    @Direccion VARCHAR(100),
    @IdTransaccion VARCHAR(50),
    @DetalleVenta [EDetalle_Venta] READONLY,
    @Resultado BIT OUTPUT,
    @Mensaje VARCHAR(500) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        DECLARE @idventa INT = 0
        SET @Resultado = 1
        SET @Mensaje = ''

        BEGIN TRANSACTION registro

        INSERT INTO VENTA (IdCliente, TotalProducto, MontoTotal, Contacto, IdDistrito, Telefono, Direccion, IdTransaccion)
        VALUES (@IdCliente, @TotalProducto, @MontoTotal, @Contacto, @IdDistrito, @Telefono, @Direccion, @IdTransaccion)

        SET @idventa = SCOPE_IDENTITY()

        INSERT INTO DETALLE_VENTA (IdVenta, IdProducto, Cantidad, Total)
        SELECT @idventa, IdProducto, Cantidad, Total FROM @DetalleVenta

        DELETE FROM CARRITO WHERE IdCliente = @IdCliente

        COMMIT TRANSACTION registro
    END TRY
    BEGIN CATCH
        SET @Resultado = 0
        SET @Mensaje = ERROR_MESSAGE()
        ROLLBACK TRANSACTION registro
    END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [DBCARRITO] SET  READ_WRITE 
GO
