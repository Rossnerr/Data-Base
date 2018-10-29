USE universitatea

SELECT Id_Student, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Studiate
FROM dbo.studenti_reusita
GROUP BY Id_Student

SELECT Id_Student, COUNT(Id_Disciplina) AS Nr_Discipline_Nesustinute
FROM dbo.studenti_reusita
WHERE Tip_Evaluare='Reusita curenta' AND Nota BETWEEN 0 AND 4
GROUP BY Id_Student