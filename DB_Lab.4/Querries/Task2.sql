USE universitatea
SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
FROM dbo.studenti_reusita
INNER JOIN dbo.profesori
ON dbo.studenti_reusita.Id_Profesor=dbo.profesori.Id_Profesor
GROUP BY Nume_Profesor, Prenume_Profesor