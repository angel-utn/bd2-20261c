Use MantenimientoEdilicio;

-- INNER JOIN

-- Listado de edificios con el nombre del edificio, direccion y con el nombre de su localidad.
Select
    E.Nombre As 'Edificio', 
    E.Direccion,
    L.Nombre As 'Localidad'
From Edificios E
Inner Join Localidades L On E.IdLocalidad = L.IdLocalidad;

-- Listado de operarios con nombre y apellidos, nombre de localidad y nombre de especialidad
Select
    Concat(Ope.Apellido, ', ', Ope.Nombre) As Apenom,
    Loc.Nombre As 'Localidad',
    Esp.Nombre As 'Especialidad'
From Operarios Ope
Inner Join Especialidades Esp On Esp.IdEspecialidad = Ope.IdEspecialidad
Inner Join Localidades Loc On Loc.IdLocalidad = Ope.IdLocalidad
Where Esp.Nombre = 'Gas';

-- Un listado con Descripcion y fecha de las órdenes de trabajo 
-- y el nombreMaterial, cantidad y unid de medida de los insumos
Select 
    OT.Descripcion,
    OT.Fecha,
    Insu.NombreMaterial,
    Insu.Cantidad,
    Insu.Unidad
From OrdenesTrabajo OT
Inner Join Insumos Insu On OT.IdOrden = Insu.IdOrden;

-- LEFT y RIGHT JOINS (Left Outer y Right Outer)

-- Listado de todos los operarios (IdOperario, Apellido, Nombre,) 
-- con sus órdenes de trabajo asignadas (Descripcion, CostoTotal), 
-- incluyendo aquellos que nunca recibieron ninguna orden.

Select
    Ope.IdOperario,
    Ope.Apellido,
    Ope.Nombre,
    Ot.IdOrden,
    Ot.Descripcion,
    Ot.CostoTotal
From Operarios Ope
Left Join OrdenesTrabajo Ot On Ope.IdOperario = Ot.IdOperario;

-- Listado de todos los operarios (IdOperario, Apellido, Nombre,) 
-- que  nunca recibieron ninguna orden de trabajo.
Select
    Ope.IdOperario,
    Ope.Apellido,
    Ope.Nombre
From Operarios Ope
Left Join OrdenesTrabajo Ot On Ope.IdOperario = Ot.IdOperario
Where Ot.IdOrden Is Null;

-- Operarios (Apellido, Nombre) y sus localidades (IdLocalidad, Localidad).
-- Completar con operarios que no tengan localidades.

Select Op.nombre, Op.Apellido, Loc.IdLocalidad, Loc.Nombre As 'Localidad'
from Operarios Op
left join Localidades Loc On Op.IdLocalidad = Loc.IdLocalidad;

-- Operarios (Apellido, Nombre) y sus localidades (IdLocalidad, Localidad).
-- Completar con localides que no tengan operarios.

Select Op.nombre, Op.Apellido, Loc.IdLocalidad, Loc.Nombre As 'Localidad'
from Operarios Op
right join Localidades Loc On Op.IdLocalidad = Loc.IdLocalidad;

-- Operarios (Apellido, Nombre) y sus localidades (IdLocalidad, Localidad).
-- Completar con operarios que no tengan localidades.
-- Completar con localides que no tengan operarios.
Select Op.nombre, Op.Apellido, Loc.IdLocalidad, Loc.Nombre As 'Localidad'
from Operarios Op
full join Localidades Loc On Op.IdLocalidad = Loc.IdLocalidad;


-- Cross Join
-- Producto cartesiano entre operarios y especialidades
Select
    Ope.IdOperario,
    Ope.Apellido,
    Ope.Nombre,
    Esp.*
From Operarios Ope
Cross Join Especialidades Esp;


-- Listado de pares de edificios con el mismo tipo (residencial, comercial o industrial) 
-- con el nombre de ambos edificios y la cantidad de pisos de ambos edificios.
Select
    Ed1.Tipo,
    Ed1.IdEdificio as 'Id1',
    Ed1.Nombre As 'Edificio 1',
    Ed1.CantidadPisos As 'CantidadPisos 1',
    Ed2.IdEdificio as 'Id2',
    Ed2.Nombre As 'Edificio 2',
    Ed2.CantidadPisos As 'CantidadPisos 2'
From Edificios Ed1
Inner Join Edificios Ed2 On Ed1.IdEdificio < Ed2.IdEdificio
Where Ed1.Tipo = Ed2.Tipo
Order by Ed1.Tipo Asc;




