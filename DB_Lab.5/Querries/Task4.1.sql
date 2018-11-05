DECLARE @N1 INT, @N2 INT, @N3 INT;
DECLARE @MAI_MARE INT;

SET @N1 = 60 * RAND();
SET @N2 = 60 * RAND();
SET @N3 = 60 * RAND();

--Lines to produce the error
--SET @N1 = 60;
--SET @N2 = 60;
--SET @N3 = 60;

BEGIN TRY
IF @N1 = @N2 AND @N1 = @N3	
	RAISERROR('All the numbers are equal.', 16, 1)
ELSE
IF @N1 > @N2
	SET @MAI_MARE = @N1;
ELSE
	SET @MAI_MARE = @N2;
IF @MAI_MARE < @N3
	SET @MAI_MARE = @N3;
	PRINT @N1;
	PRINT @N2;
	PRINT @N3;
	PRINT 'Mai mare = ' + CAST(@MAI_MARE AS VARCHAR(2));
END TRY

BEGIN CATCH
	PRINT 'An error occured.'
	PRINT 'Error Message: ' + ERROR_MESSAGE()
	PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(2))
END CATCH