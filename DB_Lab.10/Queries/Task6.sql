USE universitatea
GO
DROP TRIGGER IF EXISTS Trigger_Task6 ON DATABASE
GO
CREATE TRIGGER Trigger_Task6 ON DATABASE
FOR alter_table
AS
	DECLARE @column_modified VARCHAR(20)
	DECLARE @command VARCHAR(500)
	DECLARE @command2 VARCHAR(500)
	DECLARE @object VARCHAR(50)
	DECLARE @schema VARCHAR(50)

	SET @command = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'nvarchar(max)')


	SET @object = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(max)')			
									

	SET @column_modified = EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/Alter/Columns/Name)[1]', 
												'nvarchar(max)')

	SET @schema = EVENTDATA().value('(/EVENT_INSTANCE/SchemaName)[1]', 'nvarchar(max)')	
												
	IF @column_modified = 'Id_Profesor'
	BEGIN
		SELECT @command2 = REPLACE(@command, @schema + '.' + @object, 'dbo.profesori_new')
		EXECUTE(@command2)
		SELECT @command2 = REPLACE(@command, @schema + '.' + @object, 'studenti.studenti_reusita')
		EXECUTE(@command2)
		SELECT @command2 = REPLACE(@command, @schema + '.' + @object, 'plan_studii.orarul')
		EXECUTE(@command2)
	END

ALTER TABLE cadre_didactice.profesori
ALTER COLUMN Id_Profesor SMALLINT