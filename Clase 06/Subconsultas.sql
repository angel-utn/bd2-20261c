-- Subconsultas escalares
-- ---------------------------

Select Avg(SuperficieM2) As PromedioM2 From Edificios;

-- Subconsulta escalar

-- Los edificios que tienen más superficie que el promedio de superficie (entre todos los edificios)
Select Nombre, SuperficieM2 From Edificios
Where SuperficieM2 > (Select Avg(SuperficieM2) From Edificios);

-- Variable (No es Subconsultas) -- Variables se ve en más detalle en las próximas clases
Declare @PromedioSupM2 Decimal(18, 4);
Set @PromedioSupM2 = (Select Avg(SuperficieM2) From Edificios);
Select Nombre, SuperficieM2 From Edificios
Where SuperficieM2 > @PromedioSupM2;

-- Por cada edificio, listar nombre y la cantidad de órdenes de trabajo del año 2024 y la cantidad de órdenes del año 2026.

/*
    CP.Nombre, SC.Cant2024, SC.2026
    -------------------------------
    Edificio Norte, 10, 9
    Edificio Sur, 3, 7
*/

Select E.Nombre,
    (
        Select Count(*) From OrdenesTrabajo OT
        Inner Join Contratos C ON OT.IdContrato = C.IdContrato
        Where Year(OT.Fecha) = 2024 And C.IdEdificio = E.IdEdificio
    ) As CantOt2024,
    (
        Select Count(*) From OrdenesTrabajo OT
        Inner Join Contratos C ON OT.IdContrato = C.IdContrato
        Where Year(OT.Fecha) = 2026 And C.IdEdificio = E.IdEdificio
    ) As CantOt2026
From Edificios E


-- Los operarios que no tienen ninguna orden de trabajo asignada

select distinct IdOperario from Operarios;

Select distinct Ope.IdOperario  From Operarios Ope
inner join OrdenesTrabajo OT ON Ope.IdOperario = OT.IdOperario;

-- Not In
Select * From Operarios
Where IdOperario Not In (
    Select distinct Ope.IdOperario  From Operarios Ope
    inner join OrdenesTrabajo OT ON Ope.IdOperario = OT.IdOperario
);

-- Not Exists
Select * From Operarios Ope
Where Not Exists (
    Select 1 From OrdenesTrabajo where IdOperario = Ope.IdOperario
);

-- Los edificios que tuvieron más órdenes de trabajo en 2024 que en 2026, pero que hayan tenido órdenes en ambos años.

Select * From (
    Select E.Nombre,
        (
            Select Count(*) From OrdenesTrabajo OT
            Inner Join Contratos C ON OT.IdContrato = C.IdContrato
            Where Year(OT.Fecha) = 2024 And C.IdEdificio = E.IdEdificio
        ) As CantOt2024,
        (
            Select Count(*) From OrdenesTrabajo OT
            Inner Join Contratos C ON OT.IdContrato = C.IdContrato
            Where Year(OT.Fecha) = 2026 And C.IdEdificio = E.IdEdificio
        ) As CantOt2026
    From Edificios E
) As EstadisticasEdificios
Where EstadisticasEdificios.CantOt2024 > EstadisticasEdificios.CantOt2026
And EstadisticasEdificios.CantOt2024 > 0 And EstadisticasEdificios.CantOt2026 > 0;

-- CTE -- Common Table Expresion
With EstadisticasEdificios As (
    Select E.Nombre,
        (
            Select Count(*) From OrdenesTrabajo OT
            Inner Join Contratos C ON OT.IdContrato = C.IdContrato
            Where Year(OT.Fecha) = 2024 And C.IdEdificio = E.IdEdificio
        ) As CantOt2024,
        (
            Select Count(*) From OrdenesTrabajo OT
            Inner Join Contratos C ON OT.IdContrato = C.IdContrato
            Where Year(OT.Fecha) = 2026 And C.IdEdificio = E.IdEdificio
        ) As CantOt2026
    From Edificios E
)

Select * From EstadisticasEdificios
Where EstadisticasEdificios.CantOt2024 > EstadisticasEdificios.CantOt2026
And EstadisticasEdificios.CantOt2024 > 0 And EstadisticasEdificios.CantOt2026 > 0;
