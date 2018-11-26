USE universitatea

SELECT Nume_Student, Prenume_Student
FROM studenti.studenti
INNER JOIN studenti.studenti_reusita
ON studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
INNER JOIN plan_studii.discipline
ON studenti.studenti_reusita.Id_Disciplina = plan_studii.discipline.Id_Disciplina
WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'

SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
FROM studenti.studenti_reusita
INNER JOIN cadre_didactice.profesori
ON studenti.studenti_reusita.Id_Profesor=cadre_didactice.profesori.Id_Profesor
GROUP BY Nume_Profesor, Prenume_Profesor

SELECT DISTINCT Nume_Student, Prenume_Student
FROM studenti.studenti
INNER JOIN studenti.studenti_reusita 
ON studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
WHERE NOT studenti.studenti.Id_Student = Any (SELECT Id_Student
									 FROM studenti.studenti_reusita
									 WHERE Tip_Evaluare = 'Reusita curenta' and Nota > 5)