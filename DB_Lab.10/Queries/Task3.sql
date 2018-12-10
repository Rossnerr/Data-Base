USE universitatea
GO
DROP TRIGGER IF EXISTS studenti.trigger_task3
GO
CREATE TRIGGER studenti.trigger_task3 ON studenti.studenti_reusita
AFTER UPDATE
AS
	DECLARE @grupa CHAR(6)
	DECLARE @nota_original INT
	DECLARE @nota_modified INT
	DECLARE @data_evaluare DATE
	DECLARE @message_nota VARCHAR(500) = CONCAT('Atentie, nu se permite micsorarea notei stundentilor din 
	grupa CIB171!', CHAR(13))
	DECLARE @message_data_evaluare VARCHAR(500) = CONCAT('Atentie, nu se permite sa modificati data evaluarii 
	pentru studentii din grupa CIB171 daca aceasta nu este NULL!', CHAR(13))

	SELECT @nota_original = Nota
	FROM deleted

	SELECT @nota_modified = Nota
	FROM inserted

	SELECT @data_evaluare = Data_Evaluare
	FROM deleted
	
	SELECT @grupa = Cod_Grupa
	FROM inserted
	JOIN dbo.grupe
	ON inserted.Id_Grupa = grupe.Id_Grupa

	IF(@grupa = 'CIB171')
	BEGIN
		IF(UPDATE(Nota) AND @nota_original > @nota_modified)
		BEGIN
			RAISERROR(@message_nota, 16, 1)
			ROLLBACK TRANSACTION
		END
		IF(UPDATE(Data_Evaluare) and @data_evaluare is not null)
		BEGIN
			RAISERROR(@message_data_evaluare, 16, 1)
			ROLLBACK TRANSACTION
		END
	END

UPDATE studenti.studenti_reusita
SET Nota = 6
WHERE Id_Student = 100 AND Id_Disciplina = 107 AND Tip_Evaluare = 'Examen'

UPDATE studenti.studenti_reusita
SET Data_Evaluare = '2018-12-05'
WHERE Id_Student= 100 AND Id_Disciplina = 105 AND Tip_Evaluare = 'Examen'