USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task1_1
GO
CREATE PROCEDURE Procedure_Task1_1
	@Tip_Evaluare VARCHAR(20) = 'Examen',
	@Data_Evaluare VARCHAR(10) = '2018-%-%',
	@Nota_Min SMALLINT = 4,
	@Nota_Max SMALLINT = 8,
	@Disciplina VARCHAR(60) = 'Baze de date'
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	INNER JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare = @Tip_Evaluare AND Data_Evaluare LIKE @Data_Evaluare 
			AND Nota BETWEEN @Nota_Min AND @Nota_Max AND Disciplina = @Disciplina

EXECUTE Procedure_Task1_1