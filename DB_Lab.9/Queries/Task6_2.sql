USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task6_2
GO
CREATE FUNCTION dbo.Function_Task6_2(@Tip_Evaluare VARCHAR(20), @Nota_Min SMALLINT)
RETURNS TABLE
AS
RETURN (SELECT Nume_Student, Prenume_Student
		FROM studenti.studenti
		INNER JOIN studenti.studenti_reusita
		ON studenti.Id_Student = studenti_reusita.Id_Student
		WHERE NOT studenti.Id_Student = ANY (SELECT Id_Student
												FROM studenti.studenti_reusita
												WHERE Tip_Evaluare = @Tip_Evaluare AND Nota > @Nota_Min))

SELECT *
FROM dbo.Function_Task6_2('Reusita curenta', 5) 