USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task2
GO
CREATE PROCEDURE Procedure_Task2
	@Nr_Studenti SMALLINT = NULL OUTPUT
AS
	SET @Nr_Studenti = (SELECT COUNT(DISTINCT(Id_Student))
						FROM studenti.studenti_reusita
						WHERE Nota < 5 OR Nota = NULL)

DECLARE @Nr_Students SMALLINT
EXECUTE Procedure_Task2 @Nr_Students OUTPUT

PRINT 'Nr. of students who did not pass at least one type of evaluation is: ' + CAST(@Nr_Students AS VARCHAR(5))