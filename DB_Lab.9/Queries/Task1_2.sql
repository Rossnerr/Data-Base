USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task1_2
GO
CREATE PROCEDURE Procedure_Task1_2
	@Tip_Evaluare VARCHAR(20) = 'Reusita curenta',
	@Nota_Min SMALLINT = 5
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	WHERE NOT studenti.Id_Student = ANY (SELECT Id_Student
											FROM studenti.studenti_reusita
											WHERE Tip_Evaluare = @Tip_Evaluare AND Nota > @Nota_Min)

EXECUTE Procedure_Task1_2