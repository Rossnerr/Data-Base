USE universitatea
SELECT Nume_Student, Prenume_Student
FROM dbo.studenti
INNER JOIN dbo.studenti_reusita
ON dbo.studenti.Id_Student = dbo.studenti_reusita.Id_Student
INNER JOIN dbo.discipline
ON dbo.studenti_reusita.Id_Disciplina = dbo.discipline.Id_Disciplina
WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'