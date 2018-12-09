USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task4
GO
CREATE PROCEDURE Procedure_Task4
	@Nume_Profesor_Vechi VARCHAR(60),	
	@Prenume_Profesor_Vechi VARCHAR(60),
	@Nume_Profesor_Nou VARCHAR(60),
	@Prenume_Profesor_Nou VARCHAR(60),
	@Nume_Disciplina VARCHAR(255)
AS
BEGIN
	IF(SELECT COUNT(*)
			FROM cadre_didactice.profesori
			WHERE Nume_Profesor = @Nume_Profesor_Vechi AND Prenume_Profesor = @Prenume_Profesor_Vechi) <> 1
		BEGIN
			RAISERROR('Old Teacher: There is no such a teacher', 16, 1)
		END
	IF(SELECT COUNT(*)
			FROM cadre_didactice.profesori
			WHERE Nume_Profesor = @Nume_Profesor_Nou AND Prenume_Profesor = @Prenume_Profesor_Nou) <> 1
		BEGIN
			RAISERROR('New Teacher: There is no such a teacher', 16, 1)
		END
	IF(SELECT COUNT(*)
			FROM plan_studii.discipline
			WHERE Disciplina = @Nume_Disciplina) <> 1
		BEGIN
			RAISERROR('Discipline: There is no such a discipline', 16, 1)
		END
	
	UPDATE studenti.studenti_reusita
	SET Id_Profesor = (SELECT Id_Profesor
						FROM cadre_didactice.profesori
						WHERE Nume_Profesor = @Nume_Profesor_Nou AND Prenume_Profesor = @Prenume_Profesor_Nou)
	WHERE Id_Profesor = (SELECT Id_Profesor
							FROM cadre_didactice.profesori
							WHERE Nume_Profesor = @Nume_Profesor_Vechi AND 
							Prenume_Profesor = @Prenume_Profesor_Vechi) AND
			Id_Disciplina = (SELECT Id_Disciplina
								FROM plan_studii.discipline
								WHERE Disciplina = @Nume_Disciplina)								
END

EXECUTE Procedure_Task4 'Frent', 'Tudor', 'Popescu', 'Gabriel', 'Cercetari operationale'