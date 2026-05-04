-- Aislamiento en transacciones:

select IDCuenta, Saldo from Cuentas Where IdCuenta = 3;

-- Descartar/Retrotraer cambios
Begin Transaction
Update Cuentas Set Saldo = Saldo + 200 Where IdCuenta = 3;
Rollback Transaction

-- Confirmación de cambios
Begin Transaction
Update Cuentas Set Saldo = Saldo + 200 Where IdCuenta = 3;
Commit Transaction