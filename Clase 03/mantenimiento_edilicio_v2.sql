CREATE DATABASE MantenimientoEdilicio
COLLATE Latin1_General_CI_AI;
GO
USE MantenimientoEdilicio;
GO

CREATE TABLE Especialidades (
    IdEspecialidad SMALLINT PRIMARY KEY IDENTITY(1,1),
    Nombre         VARCHAR(60)   NOT NULL,
    PrecioHoraReferencia DECIMAL(10,2) NOT NULL
);

CREATE TABLE Localidades (
    IdLocalidad SMALLINT PRIMARY KEY IDENTITY(1,1),
    Nombre      VARCHAR(60) NOT NULL
);

CREATE TABLE Edificios (
    IdEdificio       INT           PRIMARY KEY IDENTITY(1,1),
    Nombre           VARCHAR(100)  NOT NULL,
    Direccion        VARCHAR(150)  NOT NULL,
    IdLocalidad      SMALLINT      NOT NULL REFERENCES Localidades(IdLocalidad),
    Tipo             CHAR(1)       NOT NULL CHECK (Tipo IN ('R','C','I')),
    SuperficieM2     DECIMAL(10,2) NOT NULL,
    AnioConstruccion INT           NOT NULL,
    CantidadPisos    INT           NOT NULL CHECK (CantidadPisos > 0),
    NombreContacto   VARCHAR(100)  NULL
);

CREATE TABLE Operarios (
    IdOperario      INT           PRIMARY KEY IDENTITY(1,1),
    Nombre          VARCHAR(60)   NOT NULL,
    Apellido        VARCHAR(60)   NOT NULL,
    FechaNacimiento DATE          NOT NULL,
    IdEspecialidad  SMALLINT      NOT NULL REFERENCES Especialidades(IdEspecialidad),
    IdLocalidad     SMALLINT      NULL     REFERENCES Localidades(IdLocalidad),
    Telefono        VARCHAR(20)   NULL,
    Mail            VARCHAR(100)  NULL,
    Domicilio       VARCHAR(150)  NULL,
    Activo          BIT           NOT NULL DEFAULT 1
);

CREATE TABLE Contratos (
    IdContrato    INT           PRIMARY KEY IDENTITY(1,1),
    IdEdificio    INT           NOT NULL REFERENCES Edificios(IdEdificio),
    FechaInicio   DATE          NOT NULL,
    FechaFin      DATE          NULL,
    MontoMensual  DECIMAL(12,2) NOT NULL,
    Suspendido    BIT           NOT NULL DEFAULT 0
);

CREATE TABLE OrdenesTrabajo (
    IdOrden         INT           PRIMARY KEY IDENTITY(1,1),
    IdContrato      INT           NOT NULL REFERENCES Contratos(IdContrato),
    IdOperario      INT           NOT NULL REFERENCES Operarios(IdOperario),
    Fecha           DATE          NOT NULL,
    Descripcion     VARCHAR(250)  NOT NULL,
    Prioridad       TINYINT       NOT NULL CHECK (Prioridad IN (1,2,3)),
    Estado          TINYINT       NOT NULL CHECK (Estado IN (1,2,3)),
    HorasEstimadas  DECIMAL(6,2)  NULL,
    CostoTotal      DECIMAL(12,2) NULL
);

CREATE TABLE Insumos (
    IdInsumo       INT           PRIMARY KEY IDENTITY(1,1),
    IdOrden        INT           NOT NULL REFERENCES OrdenesTrabajo(IdOrden),
    NombreMaterial VARCHAR(100)  NOT NULL,
    Cantidad       DECIMAL(10,2) NOT NULL,
    Unidad         VARCHAR(10)   NOT NULL CHECK (Unidad IN ('m','kg','litro','unidad')),
    CostoUnitario  DECIMAL(10,2) NOT NULL
);
GO

INSERT INTO Especialidades (Nombre, PrecioHoraReferencia) VALUES
('Electricidad',          1850.00),
('Plomería',              1700.00),
('Pintura',               1400.00),
('Gas',                   2100.00),
('Albañilería',           1550.00),
('Mantenimiento General', 1200.00);

INSERT INTO Localidades (Nombre) VALUES
('Buenos Aires'),
('Pilar'),
('Avellaneda'),
('Quilmes'),
('Córdoba'),
('Rosario'),
('Lomas de Zamora'),
('Mendoza'),
('Morón'),
('Luján'),
('Tigre'),
('San Isidro'),
('Lanús'),
('Mar del Plata'),
('San Miguel'),
('Zárate'),
('Campana'),
('Necochea');

INSERT INTO Edificios (Nombre, Direccion, IdLocalidad, Tipo, SuperficieM2, AnioConstruccion, CantidadPisos, NombreContacto) VALUES
('Torre Rivadavia',          'Av. Rivadavia 1250',   1,  'R',  3200.00, 1998, 12, 'Marta Giménez'),
('Centro Empresarial Norte', 'Ruta 8 km 45',         2,  'C',  5800.00, 2005,  4, 'Rodrigo Sanz'),
('Depósito Sur',             'Calle 14 Nro 890',     3,  'I',  8500.00, 1985,  1, NULL),
('Edificio Palermo',         'Thames 2340',          1,  'R',  2100.00, 2012,  8, 'Claudia Ríos'),
('Planta Quilmes',           'Av. Calchaquí 3300',   4,  'I', 12000.00, 1979,  2, 'Jorge Peralta'),
('Galería del Sol',          'San Martín 678',       5,  'C',  3400.00, 2001,  3, 'Alicia Montero'),
('Consorcio Las Heras',      'Av. Las Heras 890',    1,  'R',  1800.00, 1965,  6, 'Daniel Fuentes'),
('Oficinas Belgrano',        'Juramento 1560',       1,  'C',  2700.00, 2018,  5, NULL),
('Galpón Norte',             'Ruta 9 km 22',         6,  'I',  9200.00, 1990,  1, NULL),
('Complejo Lomas',           'Av. H. Yrigoyen 4500', 7,  'R',  4100.00, 2008, 10, 'Patricia Suárez'),
('Local Corrientes',         'Av. Corrientes 3100',  1,  'C',   980.00, 2015,  1, 'Tomás Herrera'),
('Torre Libertad',           'Libertad 550',         8,  'R',  2900.00, 2003, 15, 'Silvia Agüero'),
('Depósito Morón',           'Av. Gaona 7800',       9,  'I',  6700.00, 1972,  1, NULL),
('Complejo Recoleta',        'Junín 1200',           1,  'R',  5200.00, 1995, 20, 'Fernando Leal'),
('Centro Logístico Oeste',   'Ruta 7 km 33',         10, 'C',  7300.00, 2010,  2, 'Nora Villalba'),
('Anexo Industrial Tigre',   'Av. Cazón 1800',       11, 'I',  4400.00, 2019,  1, NULL),
('Residencial del Lago',     'Costanera Norte 520',  12, 'R',  3100.00, 2022,  7, 'Laura Méndez');

INSERT INTO Operarios (Nombre, Apellido, FechaNacimiento, IdEspecialidad, IdLocalidad, Telefono, Mail, Domicilio, Activo) VALUES
('Carlos',    'Méndez',    '1985-03-12', 1, 1,    '1145678901', 'cmendez@gmail.com',    'Calle Falsa 123',       1),
('Néstor',    'Rodríguez', '1979-07-25', 2, 13,   '1156789012', 'nrodriguez@gmail.com', 'Av. Mitre 456',         1),
('Fabiana',   'López',     '1990-11-03', 3, 9,    '1167890123', NULL,                  'Belgrano 789',          1),
('Gustavo',   'Pereyra',   '1982-05-18', 4, 4,    '1178901234', 'gpereyra@yahoo.com',   'San Martín 321',        1),
('Marcelo',   'Aguirre',   '1975-09-30', 5, 1,    '1189012345', 'maguirre@outlook.com',   'Rivadavia 654',         1),
('Lucía',     'Fernández', '1993-02-14', 6, 6,    '1190123456', 'lfernandez@gmail.com', 'Corrientes 987',        1),
('Pablo',     'Torres',    '1988-08-07', 1, 8,    NULL,         NULL,                  'Libertad 111',          1),
('Ramón',     'Soria',     '1971-12-20', 2, 1,    '1112345678', 'rsoria@yahoo.com.ar',     'Tucumán 222',           0),
('Daniela',   'Herrera',   '1995-04-09', 3, 1,    '1123456789', 'dherrera@mail.com',   'Av. Callao 333',        1),
('Héctor',    'Vargas',    '1980-06-15', 4, 12,   '1134567890', 'hvargas@mail.com',    'Dorrego 444',           1),
('Miriam',    'Castro',    '1987-10-28', 5, NULL,  NULL,         NULL,                  NULL,                    0),
('Sebastián', 'Núñez',     '1992-01-17', 6, 5,    '1156780002', 'snunez@gmail.com',     'Urquiza 666',           1),
('Andrea',    'Blanco',    '1984-03-22', 1, 1,    '1167800003', 'ablanco@ymail.com',    'Hipólito Yrigoyen 777', 1),
('Roberto',   'Giménez',   '1969-11-11', 2, 1,    '1178900004', 'rgimenez@yahoo.com',   'Pueyrredón 888',        1),
('Verónica',  'Salinas',   '1998-07-04', 3, 1,    '1189000005', 'vsalinas@outlook.com',   'Arenales 999',          1),
('Pablo',     'Ríos',      '2000-03-15', 1, 1,    '1101110001', 'p.rios@hotmail.com',      'Maipú 100',             1),
('Cecilia',   'Romero',    '1997-08-22', 2, 6,    NULL,         NULL,                  'Urquiza 200',           1),
('Jorge',     'Erbes',     '1983-05-05', 5, NULL,  '1102220003','jerbes@hotmail.com',   NULL,                    1);

INSERT INTO Contratos (IdEdificio, FechaInicio, FechaFin, MontoMensual, Suspendido) VALUES
(1,  '2024-01-01', NULL,         185000.00, 0),
(2,  '2025-06-01', NULL,         320000.00, 0),
(3,  '2022-03-01', '2024-12-31', 210000.00, 0), 
(4,  '2024-01-01', NULL,         150000.00, 0),
(5,  '2023-08-01', NULL,         480000.00, 1),
(6,  '2024-09-01', NULL,         175000.00, 0),
(7,  '2023-04-01', '2025-04-01', 120000.00, 0), 
(8,  '2024-05-01', NULL,         290000.00, 0),
(9,  '2024-11-01', NULL,         390000.00, 1),
(10, '2024-07-01', NULL,         230000.00, 0),
(11, '2025-10-01', NULL,          95000.00, 0), 
(12, '2024-02-01', NULL,         200000.00, 0),
(13, '2021-05-01', '2024-05-01', 310000.00, 0), 
(14, '2025-03-01', NULL,         415000.00, 0), 
(15, '2024-11-01', NULL,         260000.00, 1),
(1,  '2026-01-01', NULL,         290000.00, 0), 
(2,  '2026-02-01', NULL,         200000.00, 0); 


INSERT INTO OrdenesTrabajo (IdContrato, IdOperario, Fecha, Descripcion, Prioridad, Estado, HorasEstimadas, CostoTotal) VALUES
(1,  1,  '2024-01-10', 'Revisión tablero eléctrico principal',          3,  3,  4.00,  12000.00),
(1,  7,  '2024-02-15', 'Reemplazo de luminarias en pasillo',             2,  3,  3.00,   8500.00),
(2,  2,  '2025-07-20', 'Reparación cañería rota en subsuelo',           3,  3,  6.00,  18000.00),
(2,  4,  '2025-08-05', 'Revisión instalación de gas en cocina',         3,  2,  5.00,  15000.00),
(3,  5,  '2024-02-01', 'Reparación de fisuras en pared exterior',       2,  3,  8.00,  22000.00),
(4,  3,  '2024-03-12', 'Pintura de escaleras y hall de entrada',        1,  2, 12.00,  19500.00),
(5,  10, '2024-01-08', 'Control de válvulas de gas planta baja',        3,  3,  3.00,  11000.00),
(6,  6,  '2024-10-20', 'Limpieza y mantenimiento general',              1,  3,  5.00,   7000.00),
(7,  14, '2024-03-01', 'Destape de cañería principal',                  3,  3,  2.00,   6500.00),
(8,  1,  '2024-06-18', 'Instalación toma corriente sala de servidores', 2,  2,  2.00,   9000.00),
(8,  13, '2024-07-02', 'Reemplazo de disyuntor tablero 3er piso',       3,  1,  1.50,   NULL),
(9,  5,  '2025-02-10', 'Reparación de piso de cemento en galpón',       2,  3, 10.00,  35000.00),
(10, 9,  '2024-08-25', 'Pintura de fachada exterior',                   1,  2, 20.00,  42000.00),
(10, 2,  '2025-04-10', 'Revisión de bomba de agua en tanque',           2,  1,  3.00,   NULL),
(12, 4,  '2024-02-28', 'Revisión de calefacción central a gas',         3,  3,  7.00,  24500.00),
(13, 5,  '2024-03-15', 'Reparación de viga fisurada en depósito',       3,  3, 15.00,  58000.00),
(14, 1,  '2025-04-01', 'Instalación de luces de emergencia por piso',   2,  2,  8.00,  31000.00),
(14, 7,  '2025-05-05', 'Revisión tablero general piso 10 al 20',        3,  1,  6.00,   NULL),
(16, 12, '2026-03-20', 'Relevamiento general de instalaciones',         1,  3,  5.00,   8200.00),
(2,  9,  '2026-05-01', 'Pintura interior oficinas piso 2',               1,  1,  NULL,   NULL),
(3,  14, '2024-05-10', 'Inspección cañerías pluviales',                 2,  1,  NULL,   NULL),
(17, 10, '2026-05-15', 'Control instalación eléctrica nuevo contrato',  2,  1,  NULL,   NULL);

INSERT INTO Insumos (IdOrden, NombreMaterial, Cantidad, Unidad, CostoUnitario) VALUES
(1,  'Cable unipolar 2.5mm',               50.00, 'm',      180.00),
(1,  'Disyuntor 20A',                       2.00, 'unidad', 850.00),
(2,  'Tubo LED 18W',                       12.00, 'unidad', 420.00),
(3,  'Caño PVC 110mm',                     10.00, 'm',      650.00),
(3,  'Pegamento PVC',                       2.00, 'litro',  380.00),
(4,  'Flexible de gas 1/2"',                3.00, 'unidad', 720.00),
(5,  'Cemento Portland',                   40.00, 'kg',      95.00),
(5,  'Arena fina',                         80.00, 'kg',      30.00),
(6,  'Pintura látex interior',             20.00, 'litro',  480.00),
(6,  'Rodillo de lana 23cm',                4.00, 'unidad', 320.00),
(7,  'Llave de paso 1"',                    2.00, 'unidad', 950.00),
(9,  'Sonda destascadora 15m',              1.00, 'unidad',1800.00),
(10, 'Cable unipolar 4mm',                 20.00, 'm',      250.00),
(12, 'Cemento de alta resistencia',        60.00, 'kg',     120.00),
(12, 'Malla de acero',                      5.00, 'unidad', 890.00),
(13, 'Pintura exterior impermeabilizante', 30.00, 'litro',  680.00),
(13, 'Sellador de fachada',                10.00, 'litro',  420.00),
(15, 'Llave de gas esfera 3/4"',            4.00, 'unidad', 870.00),
(16, 'Hierro corrugado 12mm',               6.00, 'm',      950.00),
(17, 'Luz de emergencia 120 lum.',         15.00, 'unidad',1200.00),
(19, 'Kit de herramientas relevamiento',    1.00, 'unidad',3500.00),
(22, 'Tester digital',                      1.00, 'unidad',2800.00);
GO