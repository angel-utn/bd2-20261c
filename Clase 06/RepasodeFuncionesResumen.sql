-- Funciones de resumen

-- Cantidad de operarios en la tabla
Select count(*) As CantidadOperarios From Operarios;

-- Cantidad de operarios en la tabla que nacieron después del año 2000
Select count(*) As CantidadOperarios From Operarios where datepart(year, FechaNacimiento) >= 2000;

-- Cantidad de operarios que tienen mail
Select count(Mail) As CantidadOperariosMail From Operarios;

Select count(*) As CantidadOperariosMail From Operarios Where Mail Is not null;

-- Cantidad de operarios que no tienen mail
Select count(*) As CantidadOperariosMail From Operarios Where Mail Is null;

-- Cantidad de operarios que pertenezcan a la especialidad 9
select count(*) from Operarios Where IdEspecialidad = 9;

-- Cantidad de especialidades que tienen los operarios
Select count(distinct IdEspecialidad) as CantidadEspecialidadesOperarios From Operarios;

-- Promedio de cantidad de pisos de los edificios
Select Avg(CantidadPisos * 1.0) From Edificios;

Select Avg(Cast(CantidadPisos as Decimal)) From Edificios;

-- La totalidad de m2 de edificios residenciales
Select IsNull(Sum(SuperficieM2), 0) As TotalidadM2 From Edificios Where Tipo = 'R';

-- Otras funciones de resumen
Select Max(FechaNacimiento) From Operarios;

-- Por cada edificio, la cantidad de órdenes de trabajo registradas.
Select 
    E.Nombre,
    Count(OT.IdOrden) As CantidadOT
From Edificios As E
Inner Join Contratos As C On C.IdEdificio = E.IdEdificio
Inner Join OrdenesTrabajo As OT On OT.IdContrato = C.IdContrato
Group By E.Nombre;

-- Por cada edificio, la cantidad de órdenes de trabajo registradas cuyo monto mensual de contrato supere los 200 mil.
Select 
    E.Nombre,
    Count(OT.IdOrden) As CantidadOT
From Edificios As E
Inner Join Contratos As C On C.IdEdificio = E.IdEdificio
Inner Join OrdenesTrabajo As OT On OT.IdContrato = C.IdContrato
Where C.MontoMensual > 200000
Group By E.Nombre;

-- Por cada tipo de edificio, la sumatoria de m2 de edificios mayores a 2000m2.
-- Sólo incluir aquellos tipos de edificio que totalicen más de 22 mil m2.
Select
    E.Tipo,
    Sum(E.SuperficieM2)
From Edificios E
where E.SuperficieM2 > 2000
group by E.Tipo
having Sum(E.SuperficieM2) > 22000;

