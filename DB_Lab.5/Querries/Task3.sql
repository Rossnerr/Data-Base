DECLARE @N1 INT, @N2 INT, @N3 INT;
SET @N1 = 60 * RAND();
SET @N2 = 60 * RAND();
SET @N3 = 60 * RAND();

SELECT @N1 as N1, @N2 as N2, @N3 as N3,
	CASE
		WHEN @N1 >= @N2 AND @N1 >= @N3 THEN @N1
		WHEN @N2 >= @N1 AND @N2 >= @N3 THEN @N2
		WHEN @N3 >= @N1 AND @N3 >= @N2 THEN @N3
	END AS 'Largest Number'