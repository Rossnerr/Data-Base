USE universitatea
GO
DROP TRIGGER IF EXISTS Trigger_Task4 ON DATABASE
GO
CREATE TRIGGER Trigger_Task4 ON DATABASE
FOR ALTER_TABLE
AS
	DECLARE @Column_Modified VARCHAR(20)

	SET @column_modified = EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]', 
												'nvarchar(max)')

	IF @column_modified = 'Id_Disciplina'
	BEGIN
		RAISERROR ('Modifcarea coloanei Id_Disciplina in tabelele bazei de date universitate este interzisa',
						16, 1)
		ROLLBACK 
	END

ALTER TABLE plan_studii.discipline
ALTER COLUMN Id_Disciplina SMALLINT