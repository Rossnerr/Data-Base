USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task9
GO
CREATE FUNCTION dbo.Function_Task9(@Cod_Grupa CHAR(6), @Is_Good VARCHAR(15))
RETURNS @Ret TABLE (
	Grupa CHAR(6),
	Nume_Prenume_Student VARCHAR(120),
	Nota DECIMAL(4, 2),
	Criteriu_cautare VARCHAR(15)
)
AS
BEGIN
	IF @Is_Good = 'Sirguincios'
	BEGIN
		INSERT @Ret
		SELECT TOP(1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume,  
			CAST(AVG(CAST(Nota AS DECIMAL(4, 2))) AS DECIMAL(4, 2)) AS Nota_Medie, @Is_Good
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN dbo.grupe
		ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
		WHERE Cod_Grupa = @Cod_Grupa
		GROUP BY  Cod_Grupa, Nume_Student + ' ' + Prenume_Student
		ORDER BY Nota_Medie DESC
		RETURN
	END
	IF @Is_Good = 'Slab'
		BEGIN
		INSERT @Ret
		SELECT TOP(1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume,  
			CAST(AVG(CAST(Nota AS DECIMAL(4, 2))) AS DECIMAL(4, 2)) AS Nota_Medie, @Is_Good
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN dbo.grupe
		ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
		WHERE Cod_Grupa = @Cod_Grupa
		GROUP BY  Cod_Grupa, Nume_Student + ' ' + Prenume_Student
		ORDER BY Nota_Medie ASC
		RETURN
	END
	RETURN
END

SELECT *
FROM dbo.Function_Task9('CIB171', 'Sirguincios')

SELECT *
FROM dbo.Function_Task9('CIB171', 'Slab')