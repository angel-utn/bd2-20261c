Use MantenimientoEdilicio;
-- Ejemplos clásicos de SELECT

-- Todas las columnas de todas las filas de Edificios
Select * From Edificios;

-- Nombre, Direccion y Tipo de edificio
Select Nombre, Direccion, Tipo From Edificios;

-- Apellidos y nombres y fecha de nacimiento
Select Apellido + ', ' + Nombre AS 'ApellidoNombre' , FechaNacimiento As 'Nacimiento' From Operarios;

-- Apellidos y nombres y año de nacimiento
Select Apellido + ', ' + Nombre AS 'ApellidoNombre' , Year(FechaNacimiento) As 'Año Nacimiento' From Operarios;

-- Apellidos y nombres y un dato de contacto (Telefono -> Email -> Domicilio -> Incontactable)
Select Apellido, Nombre, IsNull(Telefono, 'SIN TELEFONO') As Telefono From Operarios;
Select Apellido, Nombre, IsNull(Mail, 'SIN MAIL') As Mail From Operarios;

-- Apellidos y nombres y un dato de contacto (Telefono -> Email -> Domicilio -> Incontactable)
Select 
    Apellido, 
    Nombre, 
    IsNull(Telefono, 
        IsNull(Mail, 
            IsNull(Domicilio, 'Incontactable'))) As 'Contacto' 
    From Operarios;

-- Apellidos y nombres y un dato de contacto (Telefono -> Email -> Domicilio -> Incontactable)
Select Apellido,
       Nombre,
       Coalesce(Telefono, Mail, Domicilio, 'Incontactable') As 'Contacto'
From Operarios;

-- Listado con el IdContrato y diferencia en días de las fechas de inicio y fin
Select IdContrato, FechaInicio, FechaFin, DATEDIFF(DAY, FechaInicio, FechaFin) As 'DiferenciaDias' From Contratos;

-- Nombre, Direccion y antigüedad en años

Select getdate();

Select Nombre, Direccion, AnioConstruccion, Year(getdate()) - AnioConstruccion As 'Antiguedad' From Edificios;


-- Order by
Select Nombre, Direccion, SuperficieM2 
From Edificios
Order by SuperficieM2 Desc;

Select Nombre, Direccion, CantidadPisos, SuperficieM2 From Edificios
Order by CantidadPisos Asc, SuperficieM2 Desc;

-- Distinct
Select Distinct CantidadPisos From Edificios;

Select Distinct Tipo, CantidadPisos From Edificios;

-- Decisión en la consulta SELECT
Select Nombre, Direccion,Tipo,
       Case Tipo
        When 'R' Then 'Residencial'
        When 'C' Then 'Comercial'
        When 'I' Then 'Industrial'
        Else 'Indeterminado'
       End As 'DescripcionTipo'
From Edificios; 

-- Añadir un clasificación a la antiguedad
Select 
    Nombre,
    Direccion, 
    AnioConstruccion, 
    Year(getdate()) - AnioConstruccion As 'Antiguedad',
    Case 
        When Year(getdate()) - AnioConstruccion >= 30 Then 'Antiguo'
        When Year(getdate()) - AnioConstruccion >= 10 Then 'Vintage'
        When Year(getdate()) - AnioConstruccion >= 0 Then 'Moderno'
        Else 'Futuro'
    End As 'DescripcionAntiguedad'
    From Edificios;

-- ----------------
--  WHERE
-- ----------------

-- Operario con IdOperario igual a 10
Select * From Operarios Where IdOperario = 10;

-- Operario con IdOperario igual a 100 -- No es error sino que devuelve set vacío
Select * From Operarios Where IdOperario = 100;

-- Edificios con más de 5000 m2
Select * From Edificios Where SuperficieM2 > 5000;

-- Edificios con más de 5000 m2 y se hayan construido antes del 2000
Select * From Edificios Where SuperficieM2 > 5000 And AnioConstruccion < 2000;

-- Contratos con un monto entre 150000 y 300000
Select * From Contratos Where MontoMensual >= 150000 AND MontoMensual <= 300000;

Select * From Contratos Where MontoMensual Between 150000 And 300000;

-- Operarios con IdEspecialidad 1, 3 y 5
Select * From Operarios Where IdEspecialidad = 1 Or IdEspecialidad = 3 Or IdEspecialidad = 5;

Select * From Operarios Where IdEspecialidad IN (1, 3, 5);

-- Operarios que no tienen IdEspecialidad 1, 3 y 5
Select * From Operarios Where IdEspecialidad <> 1 And IdEspecialidad <> 3 And IdEspecialidad <> 5;

Select * From Operarios Where IdEspecialidad Not IN (1, 3, 5);

-- Comparación de nulidad

-- Todos los datos de los contratos que tienen FechaFin
Select * From Contratos Where FechaFin Is Not Null;

-- Todos los datos de los contratos que no tienen FechaFin (tienen FechaFin NULL)
Select * From Contratos Where FechaFin Is Null;

-- Comparación de patrones en texto - LIKE
Select * From Operarios Where Apellido = 'Torres';

Select * From Operarios Where Apellido LIKE 'ri%';

Select * From Operarios Where Apellido LIKE 'r%i%';

Select * From Operarios Where Apellido LIKE '%ri%';

Select * From Operarios Where Nombre Like '__r%';