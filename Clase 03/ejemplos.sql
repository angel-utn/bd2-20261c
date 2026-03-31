-- ============================================================
-- Uso de funciones y concatenaciones
-- ============================================================

-- Obtener el nombre completo de los operarios concatenando su apellido y nombre
-- Ontener el apellido, nombre y datos de contacto de los operarios. Si el operario tiene mail registrado, mostrarlo; si no, mostrar su teléfono. Si no tiene ninguno de los dos, mostrar 'Sin contacto'.
-- Obtener nombre del edificio y su antigüedad en años
-- Otener datos de contrato y duración en días.

-- ============================================================
-- 1. WHERE  +  LIKE  /  BETWEEN  /  IN  /  IS NULL
-- ============================================================

-- Operarios cuyo apellido empieza con 'R'
-- Operarios con mail en dominio @gmail.com
-- Edificios cuyo nombre contiene la palabra 'Torre'
-- Contratos con monto mensual entre 150.000 y 300.000
-- Operarios nacidos entre 1980 y 1995
-- Órdenes realizadas en el primer trimestre de 2024
-- Edificios de tipo residencial o comercial
-- Operarios que no sean de especialidades 1, 4 ni 5
-- Operarios sin mail registrado
-- Operarios sin teléfono ni mail
-- Contratos con fecha de vencimiento definida

-- ============================================================
-- 2. CASE WHEN
-- ============================================================

-- Transformar el tipo de edificio a su nombre completo
-- Clasificar edificios por antigüedad (más de 30 años Antiguo, entre 10 y 30 años Intermedio, menos de 10 años Moderno)
-- Marcar si un operario tiene datos de contacto completos. Tiene teléfono y mail: 'Completo'; tiene solo uno de los dos: 'Parcial'; no tiene ninguno: 'Sin contacto'

-- ============================================================
-- 3. ORDER BY  (distintos tipos de datos)
-- ============================================================

-- Operarios ordenados por apellido y nombre (ASC)
-- Edificios ordenados por superficie de mayor a menor
-- Ordenes ordenadas por fecha descendente
-- Operarios ordenados por especialidad y luego por apellido

-- ============================================================
-- 4. DISTINCT
-- ============================================================

-- Ciudades donde hay edificios
-- Especialidades asignadas a operarios activos

-- ============================================================
-- 5. TOP  (ranking simple)
-- ============================================================

-- Top 3 edificios con mayor superficie
-- Top 5 operarios más jóvenes (por fecha de nacimiento)
-- Top 1: contrato más económico no suspendido

-- ============================================================
-- 6. TOP WITH TIES  (empates)
-- ============================================================
-- Top 2: Contratos con mayor monto (incluyendo empates)