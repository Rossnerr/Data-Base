USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task5
GO
CREATE PROCEDURE Procedure_Task5
	@Nume_Disciplina VARCHAR(255)
AS
BEGIN
	DECLARE @Best_students TABLE
	(
		Id_Student INT,
		Nota_Maxima INT 
	)

	INSERT INTO @Best_students
	SELECT TOP(3) studenti_reusita.Id_Student, SUM(Nota) AS Nota_Maxima
	FROM studenti.studenti_reusita
	JOIN studenti.studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Disciplina = @Nume_Disciplina
	GROUP BY studenti_reusita.Id_Student
	ORDER BY Nota_Maxima DESC

	SELECT Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume_Student, Disciplina, 
		Nota AS Nota_Veche, IIF(Nota < 10, Nota + 1, Nota) AS Nota_Noua
	FROM studenti.studenti_reusita
	JOIN studenti.studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	JOIN dbo.grupe
	ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
	JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare = 'Examen' AND Disciplina = @Nume_Disciplina AND 
			studenti_reusita.Id_Student IN (SELECT Id_Student FROM @Best_students)

	UPDATE studenti.studenti_reusita
	SET Nota = Nota + 1
	WHERE Id_Student IN (SELECT Id_Student FROM @Best_students) AND Nota < 10
END

EXECUTE Procedure_Task5 'Modelarea sistemelor'