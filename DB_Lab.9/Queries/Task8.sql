USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task8
GO
CREATE FUNCTION dbo.Function_Task8(@Nume_Prenume_Student VARCHAR(120))
RETURNS TABLE
AS
RETURN (SELECT Nume_Student + ' ' + Prenume_Student AS Nume_Prenume_Student, Disciplina, Nota, Data_Evaluare 
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN plan_studii.discipline
		ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		WHERE studenti.Nume_Student + ' ' + studenti.Prenume_Student = @Nume_Prenume_Student)

SELECT *
FROM dbo.Function_Task8('Dobrea Daniela')