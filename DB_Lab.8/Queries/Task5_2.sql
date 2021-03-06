USE universitatea
GO
WITH CTE_2 AS (
	SELECT Id_Student
	FROM studenti.studenti_reusita
	WHERE Tip_Evaluare = 'Reusita curenta' and Nota > 5
)

SELECT DISTINCT Nume_Student, Prenume_Student
FROM studenti.studenti
INNER JOIN studenti.studenti_reusita 
ON studenti.Id_Student = studenti_reusita.Id_Student
WHERE NOT studenti.Id_Student = Any (SELECT *
									 FROM CTE_2)