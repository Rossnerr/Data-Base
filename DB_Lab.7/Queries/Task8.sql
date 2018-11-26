USE universitatea
GO
CREATE SYNONYM info_profesori FOR cadre_didactice.profesori;
GO
CREATE SYNONYM info_discipline FOR plan_studii.discipline;
GO
CREATE SYNONYM info_studenti FOR studenti.studenti;
GO
CREATE SYNONYM info_reusita FOR studenti.studenti_reusita;

SELECT Nume_Student, Prenume_Student
FROM info_studenti
INNER JOIN info_reusita
ON info_studenti.Id_Student = info_reusita.Id_Student
INNER JOIN info_discipline
ON info_reusita.Id_Disciplina = info_discipline.Id_Disciplina
WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'

SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
FROM info_reusita
INNER JOIN info_profesori
ON info_reusita.Id_Profesor=info_profesori.Id_Profesor
GROUP BY Nume_Profesor, Prenume_Profesor

SELECT DISTINCT Nume_Student, Prenume_Student
FROM info_studenti
INNER JOIN info_reusita 
ON info_studenti.Id_Student = info_reusita.Id_Student
WHERE NOT info_studenti.Id_Student = Any (SELECT Id_Student
									 FROM info_reusita
									 WHERE Tip_Evaluare = 'Reusita curenta' and Nota > 5)