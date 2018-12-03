INSERT INTO dbo.Task1_1
VALUES('Lovren', 'Nemanja', 2)
--Update or insert of view or function 'dbo.Task1_1' failed because it contains a derived or constant field.--

UPDATE dbo.Task1_1
SET Prenume_Profesor = 'Sandu'
WHERE Prenume_Profesor = 'Alexandru'
--Cannot update the view or function 'dbo.Task1_1' because it contains aggregates, or a DISTINCT or GROUP BY --
--clause, or PIVOT or UNPIVOT operator.--

DELETE FROM dbo.Task1_1
WHERE Nr_Discipline_Predate = 2
--View or function 'dbo.Task1_1' is not updatable because the modification affects multiple base tables.--

INSERT INTO dbo.View_Task1_2
VALUES('Lovren', 'Nemanja')
--Cannot insert the value NULL into column 'Id_Student', table 'universitatea.studenti.studenti'; column does--
--not allow nulls. INSERT fails.--

UPDATE dbo.View_Task1_2
SET Prenume_Student = 'Mihail'
WHERE Prenume_Student = 'Mihai'
--Works fine: 2 rows were affected--

DELETE FROM dbo.View_Task1_2
WHERE Prenume_Student = 'Mihail'
--View or function 'dbo.View_Task1_2' is not updatable because the modification affects multiple base tables.--