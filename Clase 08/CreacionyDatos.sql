Create Database EjemploTriggersyTransaccionesDB
Collate Latin1_General_CI_AI
Go
Use EjemploTriggersyTransaccionesDB
Go
Create Table Clientes(
    IDCliente int not null primary key,
    Apellidos varchar(50) not null,
    Nombres varchar(50) not null,
    Estado bit not null default (1)
)

Create Table TiposCuenta(
    IDTipoCuenta varchar(2) not null primary key,
    Nombre varchar(50) not null
)

Create Table Cuentas(
    IDCuenta int not null primary key identity (1, 1),
    IDCliente int not null foreign key references Clientes(IDCliente),
    IDTipoCuenta varchar(2) not null foreign key references TiposCuenta(IDTipoCuenta),
    FechaApertura date not null,
    FechaBaja date null,
    LimiteDescubierto money not null,
    Saldo money not null
)
 
Create Table Movimientos(
    IDMovimiento bigint not null primary key identity (1, 1),
    IDCuenta int not null foreign key references Cuentas(IdCuenta),
    Fecha datetime not null default (getdate()),
    Importe money not null check (Importe > 0),
    TipoMovimiento char not null check (TipoMovimiento in ('C', 'D'))
)

Alter Table Cuentas
Add Constraint Chk_SaldoCorrecto Check (Saldo >= LimiteDescubierto * -1)

-- Datos
Set Dateformat 'YMD'

INSERT INTO Clientes (IDCliente, Apellidos, Nombres, Estado) VALUES
(1, 'García', 'Juan', 1),
(2, 'Pérez', 'María', 1),
(3, 'López', 'Carlos', 1),
(4, 'Martínez', 'Ana', 1),
(5, 'Hernández', 'Luis', 1),
(6, 'Ramírez', 'Sofía', 1);

INSERT INTO TiposCuenta (IDTipoCuenta, Nombre) VALUES
('CC', 'Cuenta Corriente'),
('CA', 'Caja de Ahorro');

SET IDENTITY_INSERT Cuentas ON

INSERT INTO Cuentas (IDCuenta, IDCliente, IDTipoCuenta, FechaApertura, LimiteDescubierto, Saldo) VALUES
(1, 1, 'CC', '2025-01-01', 1000.00, 50.00),
(2, 1, 'CA', '2025-02-01', 0.00, 300.00),
(3, 2, 'CC', '2025-03-01', 2000.00, 400.00),
(4, 3, 'CA', '2025-04-01', 0.00, 200.00),
(5, 4, 'CC', '2025-05-01', 500.00, -100.00),
(6, 5, 'CA', '2025-06-01', 0.00, 500.00),
(7, 6, 'CC', '2025-07-01', 3000.00, -700.00),
(8, 1, 'CA', '2025-08-01', 0.00, 0.00),
(9, 3, 'CA', '2025-09-01', 0.00, 0.00),
(10, 5, 'CC', '2025-10-01', 1000.00, 0.00);

Set IDENTITY_INSERT Cuentas OFF

INSERT INTO Movimientos (IDCuenta, Fecha, Importe, TipoMovimiento) VALUES
(1, '2025-09-15', 200.00, 'C'),
(1, '2025-09-20', 150.00, 'D'),
(2, '2025-09-05', 300.00, 'C'),
(3, '2025-09-10', 400.00, 'C'),
(4, '2025-09-15', 200.00, 'C'),
(5, '2025-09-20', 100.00, 'D'),
(6, '2025-09-25', 500.00, 'C'),
(7, '2025-09-30', 700.00, 'D')