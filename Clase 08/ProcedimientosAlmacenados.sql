-- Repaso de Procedimientos Almacenados

Use EjemploTriggersyTransaccionesDB;

-- Hacer un procedimiento almacenado que obtenga todos los movimientos de una cuenta
-- cuyo IDCuenta se envíe como parámetro
GO
Create Procedure SP_ObtenerMovimientos_IdCuenta (
    @IdCuenta int
)
As BEGIN

    Select M.*, C.IDCliente From Movimientos M
    Inner Join Cuentas C ON C.IDCuenta = M.IDCuenta
    Where M.IDCuenta = @IDCuenta

End

Exec SP_ObtenerMovimientos_IdCuenta 1;

-- Hacer un procedimiento que reciba IDCuenta, Importe y TipoMovimiento. El SP debe realizar la inserción
-- de un movimiento y actualizar el saldo de la cuenta (débito / crédito)

-- 3, 8000, 'C' -- Acreditar $8000 a la cuenta 3
GO

Create Procedure SP_AgregarMovimientoyActualizarSaldo(
    @IDCuenta int,
    @Importe money,
    @TipoMovimiento char
)
As Begin

    Begin Try

        Begin Transaction

        Insert into Movimientos(IDCuenta, Fecha, Importe, TipoMovimiento)
        Values (@IDCuenta, Getdate(), @Importe, @TipoMovimiento);

        If @TipoMovimiento = 'D' BEGIN
            Set @Importe = @Importe * -1;
        END

        Update Cuentas Set Saldo = Saldo + @Importe Where IdCuenta = @IDCuenta;

        Commit Transaction

    End Try
    Begin Catch
        Rollback Transaction
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        Raiserror('Ocurrió un error al agregar el movimiento: %s', 16, 100, @ErrorMessage);
    End Catch

End

Exec SP_ObtenerMovimientos_IdCuenta 4;

-- OK
Exec SP_AgregarMovimientoyActualizarSaldo 1, 10, 'D';

-- Intentamos debitar $300 a la cuenta 4 -- Error (de manera transacción se retrotrae todo el conjunto de instrucciones)
Exec SP_AgregarMovimientoyActualizarSaldo 4, 500, 'D';
