USE universitatea
GO
DROP TRIGGER IF EXISTS Trigger_Task5 ON DATABASE
GO
CREATE TRIGGER Trigger_Task5 ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
	DECLARE @Time TIME
	DECLARE @Day INT

	SET @Day = DATEPART(WEEKDAY, EVENTDATA().value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(max)'))
	SET @Time = EVENTDATA().value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(max)')

	IF @Day NOT BETWEEN 2 AND 6
	BEGIN
		RAISERROR ('Modifcarea schemei bazei de date universitate in afara zilelor de lucru este interzisa!',
						16, 1)
		ROLLBACK
		RETURN
	END

	IF @Day BETWEEN 2 AND 6 AND @time NOT BETWEEN CAST('08:00' AS TIME) AND CAST('18:00' AS TIME)
	BEGIN
		RAISERROR ('Modifcarea schemei bazei de date universitate in afara orelor de lucru este interzisa!',
						16, 1)
		ROLLBACK
		RETURN
	END

CREATE TABLE dbo.facultati (
	Id_Facultate INT
)