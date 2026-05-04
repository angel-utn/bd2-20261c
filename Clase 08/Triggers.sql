-- Triggers / Desencadenadores
-- ----------------------------

Use EjemploTriggersyTransaccionesDB;
Go

-- Cuando eliminemos una cuenta. Verificar:
-- El saldo de la cuenta no debe ser distinto a cero.
-- Que no haya sido eliminada anteriormente.
-- Establecer la fecha de baja y NO borrarla de manera física. Implementar baja lógica.

Create Trigger TR_BajaLogicaCuentas ON Cuentas
Instead Of Delete
As BEGIN

    Declare @IdCuenta bigint;
    Declare @Saldo money;
    Declare @FechaBaja date;

    Select @IdCuenta = IdCuenta, @Saldo = Saldo, @FechaBaja = FechaBaja From deleted;

    If @Saldo <> 0 BEGIN
        RAISERROR('El saldo de la cuenta debe ser cero para eliminarla', 16, 1);
        Return;
    End

    If @FechaBaja IS NOT NULL BEGIN
        RAISERROR('La cuenta ya fue dada de baja', 16, 1);
        Return;
    End

    Update Cuentas Set FechaBaja = Getdate() Where IDCuenta = @IdCuenta;

End

Select * From Cuentas;

Delete From Cuentas Where IDCuenta = 100;

Select @@ROWCOUNT;