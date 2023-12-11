--- FUNCTIONS ---

CREATE FUNCTION LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(@fecha_nac DATETIME)
	RETURNS INT
BEGIN
	DECLARE @EDAD INT
	DECLARE @ID_RANGO INT
	
	SET @EDAD = YEAR(GETDATE()) - YEAR(@fecha_nac)

	IF @EDAD < 25
		SET @ID_RANGO = 1

	IF @EDAD BETWEEN 25 AND 35 
		SET @ID_RANGO = 2

	IF @EDAD BETWEEN 35 AND 55
		SET @ID_RANGO = 3

	IF @EDAD > 55
		SET @ID_RANGO = 4

	RETURN @ID_RANGO
	
END
GO


CREATE FUNCTION LOS_GDDS.FX_CALCULAR_RANGO_M2(@INMUEBLE NUMERIC(18,0))
    RETURNS INT
BEGIN
    DECLARE @SUPERFICIE_TOTAL NUMERIC(18,2)
    DECLARE @RANGO_M2 INT

    SET @SUPERFICIE_TOTAL = (SELECT i.SUPERFICIE_TOTAL FROM INMUEBLE i WHERE i.id = @INMUEBLE)

    IF @SUPERFICIE_TOTAL < 35
        SET @RANGO_M2 = 1

    IF @SUPERFICIE_TOTAL BETWEEN 35 AND 55
        SET @RANGO_M2 = 2

    IF @SUPERFICIE_TOTAL BETWEEN 55 AND 75
        SET @RANGO_M2 = 3

    IF @SUPERFICIE_TOTAL BETWEEN 75 AND 100
        SET @RANGO_M2 = 4
    
    IF @SUPERFICIE_TOTAL > 100
        SET @RANGO_M2 = 5

    RETURN @RANGO_M2
	
END
GO

CREATE FUNCTION LOS_GDDS.ObtenerFechaInicioMes(@idTiempo INT)
RETURNS DATE
AS
BEGIN
    DECLARE @fechaInicioMes DATE;

    SELECT @fechaInicioMes = DATEFROMPARTS(anio, mes, 1)
    FROM LOS_GDDS.BI_Tiempo
    WHERE id = @idTiempo;

    RETURN @fechaInicioMes;
END
GO

CREATE FUNCTION LOS_GDDS.ObtenerIdTiempoPorFecha(@fecha_inicio DATE, @fecha_fin DATE)
RETURNS INT
AS
BEGIN
    DECLARE @idTiempo INT;

    SELECT @idTiempo = id
    FROM LOS_GDDS.BI_Tiempo
    WHERE LOS_GDDS.ObtenerFechaInicioMes(id) BETWEEN DATEFROMPARTS(YEAR(@fecha_inicio), MONTH(@fecha_inicio), 1) AND DATEFROMPARTS(YEAR(@fecha_fin), MONTH(@fecha_fin), 1)

    RETURN @idTiempo;
END
GO