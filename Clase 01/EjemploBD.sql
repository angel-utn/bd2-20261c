create database Clase01
Go
Use Clase01
Go
create table Departamentos(
    IdDepartamento smallint not null primary key identity(1000, 1),
    Nombre varchar(50) not null,
    Observaciones varchar(100) null
)
Go
Create Table Empleados(
	Legajo smallint not null primary key,
	Apellidos varchar(70) not null,
	Nombres varchar(70) not null,
	Email varchar(100) not null unique,
	FechaIngreso date not null check (FechaIngreso <= getdate()),
	IdDepartamento smallint null foreign key references Departamentos(IdDepartamento)
)
Go
-- Modifica la tabla empleados para que la columna email tenga 200 caracteres
Alter Table Empleados
Alter column Email varchar(200) not null 
