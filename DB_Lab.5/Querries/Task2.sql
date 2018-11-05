USE universitatea

DECLARE @CONTOR INT

SET @CONTOR = (SELECT COUNT(*)
				FROM studenti_reusita
				INNER JOIN discipline
				ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
				INNER JOIN studenti
				ON studenti_reusita.Id_Student = studenti.Id_Student
				WHERE Tip_Evaluare LIKE '%Testul 1%' AND Disciplina LIKE '%Baze de date%'  AND Nota IN (1, 2, 3, 4, 5, 7, 9, 10))

IF @CONTOR >= 10
	SELECT TOP 10 Nume_Student, Prenume_Student
	FROM studenti_reusita
	INNER JOIN discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	INNER JOIN studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	WHERE Tip_Evaluare LIKE '%Testul 1%' AND Disciplina LIKE '%Baze de date%'  AND Nota IN (1, 2, 3, 4, 5, 7, 9, 10)
ELSE
	PRINT 'There are less than 10 students which satisfy the specified condition.'