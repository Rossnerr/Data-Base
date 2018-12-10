# Laboratory Work Nr. 10

### Purpose of the laboratory work
* Get familiar with triggers
* Learn how to create them
* Learn how to use them

### Tasks
1. Modify the trigger named 'intrare_noua' in such a way that if _Auditoriul_ will get updated a message will be displayed. Beside the name
of the discipline and the hour, the message should contain the name of the group, the day, the campus, the old classromm and the new
classroom.
2. Create the trigger which will ensure the correct data insertion in tables _studenti_ and _studenti_reusita_ tables. Also it should prevent from the foreign key errors.
3. Create the trigger which will deny the right of decrementing the marks from _studenti_reusita_ table and changing the values of _Data_Evaluarii_ where those are not null. The trigger should be enabled only when the students of 'CIB171' group are affected. In case of an attemption an appropriate message should be displayed.
4. Create a DDL trigger which will not permit to modify the _Id_Disciplina_ column in the tables within the 'universitatea' database. An appropriate message should be displayed.
5. Create a DDL trigger which will not allow to modify the 'universitatea' database scheme at any time beside the working hours.
6. Create a DLL trigger which will make the corresponding changes in all other tables if it will detect a change on a column _Id_Profesor_ in one of the tables.

 ### Laboratory work implementation

#### Task 1
```sql
USE universitatea
GO
DROP TRIGGER IF EXISTS plan_studii.Trigger_Task1
GO
CREATE TRIGGER plan_studii.Trigger_Task1 on plan_studii.orarul
	AFTER UPDATE
	AS SET NOCOUNT ON
		IF(UPDATE(Auditoriu))
			BEGIN
				SELECT  DISTINCT 'Spre atentia studentilor din grupa ' +
						grupe.Cod_Grupa + '!' +
						'Lectia la disciplina "' + 
						UPPER(discipline.Disciplina) +
						'" de la ora ' +
						CAST(inserted.Ora AS VARCHAR(5)) +
						' care trebuia sa se desfasoare in ziua de ' +
						inserted.Zi +
						' in aula ' +
						CAST(deleted.Auditoriu AS CHAR(3)) +
						' din blocul ' +
						inserted.Bloc +
						' a fost transferata in aula ' + 
						CAST(inserted.Auditoriu AS CHAR(3)) + '.'
				FROM inserted
				JOIN plan_studii.discipline
				ON inserted.Id_Disciplina = discipline.Id_Disciplina
				JOIN deleted
				ON deleted.Id_Disciplina = discipline.Id_Disciplina
				JOIN dbo.grupe
				ON inserted.Id_Grupa = grupe.Id_Grupa
			END
GO

UPDATE plan_studii.orarul
SET Auditoriu = 301
WHERE Zi = 'Luni'
```

![Task1_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task1_1.PNG)

![Task1_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task1_2.PNG)

![Task1_3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task1_3.PNG)

![Task1_4](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task1_4.PNG)

#### Task 2
```sql
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
```

![Task2_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task2_1.PNG)

![Task2_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task2_2.PNG)

#### Task 3
```sql
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
```

![Task3_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task3_1.PNG)

![Task3_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task3_2.PNG)

![Task3_3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task3_3.PNG)

![Task3_4](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task3_4.PNG)

#### Task 4
```sql
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
```

![Task4](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task4.PNG)

#### Task 5
```sql
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
```

![Task5](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task5.PNG)

#### Task 6
```sql
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
```

![Task6_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task6_1.PNG)

![Task6_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task6_2.PNG)

![Task6_3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.10/Screens/Task6_3.PNG)
