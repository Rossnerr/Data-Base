ALTER VIEW dbo.Task1_1
WITH SCHEMABINDING
AS
	SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
	FROM studenti.studenti_reusita
	INNER JOIN cadre_didactice.profesori
	ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
	GROUP BY Nume_Profesor, Prenume_Profesor
WITH CHECK OPTION

ALTER VIEW dbo.View_Task1_2
WITH SCHEMABINDING
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	INNER JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'
WITH CHECK OPTION