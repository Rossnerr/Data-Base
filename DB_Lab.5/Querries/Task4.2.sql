USE universitatea

DECLARE @CONTOR INT

SET @CONTOR = (SELECT COUNT(*)
				FROM studenti_reusita
				INNER JOIN discipline
				ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
				INNER JOIN studenti
				ON studenti_reusita.Id_Student = studenti.Id_Student
				WHERE Tip_Evaluare LIKE '%Testul 1%' AND Disciplina LIKE '%Baze de date%'  AND Nota IN (1, 2, 3, 4, 5, 7, 9, 10))

--Lines to produce the error
--SET @CONTOR = (SELECT COUNT(*)
--				FROM studenti
--				WHERE Id_Student = 100)

BEGIN TRY
IF @CONTOR <= 10
	RAISERROR('There are less than 10 students which satisfy the specified condition.', 13, 1)
ELSE 
	SELECT TOP 10 Nume_Student, Prenume_Student
	FROM studenti_reusita
	INNER JOIN discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	INNER JOIN studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	WHERE Tip_Evaluare LIKE '%Testul 1%' AND Disciplina LIKE '%Baze de date%'  AND Nota IN (1, 2, 3, 4, 5, 7, 9, 10)
END TRY

BEGIN CATCH
	PRINT 'An error occured.'
	PRINT 'Error Message : ' + ERROR_MESSAGE()
	PRINT 'Error Line : ' + CAST(ERROR_LINE() AS VARCHAR(2))
END CATCH