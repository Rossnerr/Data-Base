USE universitatea
GO
DROP TRIGGER IF EXISTS studenti.Trigger_Task2
GO
CREATE TRIGGER studenti.Trigger_Task2 ON studenti.studenti_reusita
INSTEAD OF INSERT
AS
	DECLARE @id_student_inserted INT
	
	SELECT @id_student_inserted = Id_Student FROM inserted
	
	if(@id_student_inserted IN (SELECT Id_Student
								FROM studenti.studenti))
	BEGIN
		INSERT INTO studenti.studenti_reusita
		SELECT * FROM inserted
	END
	ELSE
	BEGIN
		INSERT INTO studenti.studenti
		VALUES (@id_student_inserted, 'New_Nume', 'New_Prenume', '1997-05-12', 'mun.Chisinau')

		INSERT INTO studenti.studenti_reusita
		SELECT * FROM inserted
	END

INSERT INTO studenti.studenti_reusita
VALUES(177, 105, 110, 1, 'Examen', 9, '2018-12-20')