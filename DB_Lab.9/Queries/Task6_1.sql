USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task6_1
GO
CREATE FUNCTION dbo.Function_Task6_1(@Tip_Evaluare VARCHAR(20), @Data_Evaluare VARCHAR(10), @Nota_Min SMALLINT,
									@Nota_Max SMALLINT, @Disciplina VARCHAR(60))
RETURNS TABLE
AS
RETURN (SELECT Nume_Student, Prenume_Student
		FROM studenti.studenti
		JOIN studenti.studenti_reusita
		ON studenti.Id_Student = studenti_reusita.Id_Student
		JOIN plan_studii.discipline
		ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		WHERE Tip_Evaluare = @Tip_Evaluare AND Data_Evaluare LIKE @Data_Evaluare 
			AND Nota BETWEEN @Nota_Min AND @Nota_Max AND Disciplina = @Disciplina)

SELECT *
FROM dbo.Function_Task6_1('Examen', '2018-%-%', 4, 8, 'Baze de date')