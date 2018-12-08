USE universitatea

CREATE UNIQUE NONCLUSTERED INDEX Ix_studenti_reusita on studenti.studenti_reusita(Id_Student, Id_Disciplina, Tip_Evaluare, Data_Evaluare, Nota)
WHERE Tip_Evaluare = 'Examen' AND Nota > 4
ON userdatafgroup1

CREATE UNIQUE NONCLUSTERED INDEX Ix_studenti_reusita2 on studenti.studenti_reusita(Id_Student, Id_Disciplina, Tip_Evaluare, Data_Evaluare, Nota)
WHERE Tip_Evaluare = 'Examen' AND Nota < 8
ON userdatafgroup1

SELECT Nume_Student, Prenume_Student
FROM studenti.studenti
INNER JOIN studenti.studenti_reusita
ON studenti.Id_Student = studenti_reusita.Id_Student
INNER JOIN plan_studii.discipline
ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'