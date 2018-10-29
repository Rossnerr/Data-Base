USE universitatea

SELECT DISTINCT Nume_Student, Prenume_Student
FROM studenti
INNER JOIN studenti_reusita 
ON studenti.Id_Student = studenti_reusita.Id_Student
WHERE NOT studenti.Id_Student = Any (SELECT Id_Student
									 FROM studenti_reusita
									 WHERE Tip_Evaluare = 'Reusita curenta' and Nota > 5)