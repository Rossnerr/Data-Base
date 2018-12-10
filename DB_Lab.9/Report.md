# Laboratory Work Nr. 9

### Purpose of the laboratory work
* Get familiar with stored procedure
* Get familiar with functions defined by users

### Tasks
1. Create stored procedures based on exercises from the 4th laboratory work. The input parameters of the procedures should coincide with 
the instructions after the WHERE clause in those exercises.
2. Create a stored procedure with no input parameters and one output parameter. The output parameter should return the number of students
who did not pass at least one type of evaluation.
3. Create a stored procedure which will insert the information about a new student in the database. As input parameters should be: 
student's personal information and _Cod_Grupa_. Generate all the necessary entrances for the _studenti_reusita_ table. Set the inserted
marks as NULL.
4. Let suppose that a teacher is leaving the university. Create a stored procedure which will re-asign all the entrancies of the old teacher from the _studenti_reusita_ table to the new one. The input parameters should be: _First_Name_ and _Last_Name_ of the teacher who is supposed to leave, _First_Name_ and _Last_Name_ of the new teacher, _Discipline_. In case that there are wrong data introduced a warning message should be displayed.
5. Create a stored procedure which will determine the beste 3 students at a certain discipline. The exam mark of the found students should be incremented by one, although the maximum allow mark is 10. As the input parameter should serve _Nume_Disciplina_. The procedure should return _Cod_Grupa_, _Nume_Prenume_Student_, _Disciplina_, _Nota_Veche_ and _Nota_Noua_.
6. Create functions based on exercises from the 4th laboratory work. The input parameters of the procedures should coincide with 
the instructions after the WHERE clause in those exercises.
7. Create a funtion which will calculate the age of a student. The function's prototype should look like: 
<nume_functie>(<Data_Nastere_Student>).
8. Create a function which will return the student's results. The function's prototype is: <nume_functie>(<Nume_Prenume_Student>). The result should be displayed as a table with following columns: _Nume_Prenume_Student_, _Disciplina_, _Nota_ and _Data_Evaluare_.
9. Create a function which will find the best or the worst student from a group. The function's prototype look like: <nume_functie>(<Cod_Grupa>, <is_good>). The parameter <is_good> can take 2 values: 'best' and 'worst'. The function should return a table with the following columns: _Grupa_, _Nume_Prenume_Student_, _Nota_Medie_ and _is_good_. The _Nota_Medie_'s values should have 2 numbers after the decimal dot.

 ### Laboratory work implementation

#### Task 1
1st Stored Procedure
```sql
USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task1_1
GO
CREATE PROCEDURE Procedure_Task1_1
	@Tip_Evaluare VARCHAR(20) = 'Examen',
	@Data_Evaluare VARCHAR(10) = '2018-%-%',
	@Nota_Min SMALLINT = 4,
	@Nota_Max SMALLINT = 8,
	@Disciplina VARCHAR(60) = 'Baze de date'
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	INNER JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare = @Tip_Evaluare AND Data_Evaluare LIKE @Data_Evaluare 
			AND Nota BETWEEN @Nota_Min AND @Nota_Max AND Disciplina = @Disciplina

EXECUTE Procedure_Task1_1
```

![Task1_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task1_1.PNG)

2nd Stored Procedure
```sql
USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task1_2
GO
CREATE PROCEDURE Procedure_Task1_2
	@Tip_Evaluare VARCHAR(20) = 'Reusita curenta',
	@Nota_Min SMALLINT = 5
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	WHERE NOT studenti.Id_Student = ANY (SELECT Id_Student
											FROM studenti.studenti_reusita
											WHERE Tip_Evaluare = @Tip_Evaluare AND Nota > @Nota_Min)

EXECUTE Procedure_Task1_2
```

![Task1_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task1_2.PNG)

#### Task 2
```sql
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
```

![Task2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task2.PNG)

#### Task 3
```sql
USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task3
GO
CREATE PROCEDURE Procedure_Task3
	@Nume_Student VARCHAR(50),
	@Prenume_Student VARCHAR(50),
	@Data_Nastere_Student DATE,
	@Adresa_Postala_Student VARCHAR(500),
	@Cod_Grupa CHAR(6)
AS
BEGIN
	DECLARE @Id_Student INT	
	SET @Id_Student = (SELECT MAX(Id_Student) FROM studenti.studenti) + 1

	INSERT INTO studenti.studenti
	VALUES(@Id_Student, @Nume_Student, @Prenume_Student, @Data_Nastere_Student, @Adresa_Postala_Student)

	INSERT INTO studenti.studenti_reusita
	VALUES(@Id_Student, 
			100, 
			100,
			(SELECT Id_Grupa FROM dbo.grupe WHERE Cod_Grupa = @Cod_Grupa),
			'Examen',
			NULL,
			NULL)
END

EXEC Procedure_Task3 @Nume_Student = 'Cotofana', @Prenume_Student = 'Sergiu', @Data_Nastere_Student = '1997-02-17', @Adresa_Postala_Student = 'mun.Chisinau', @Cod_Grupa = 'TI171'
```

![Task3_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task3_1.PNG)

![Task3_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task3_2.PNG)

#### Task 4
```sql
USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task4
GO
CREATE PROCEDURE Procedure_Task4
	@Nume_Profesor_Vechi VARCHAR(60),	
	@Prenume_Profesor_Vechi VARCHAR(60),
	@Nume_Profesor_Nou VARCHAR(60),
	@Prenume_Profesor_Nou VARCHAR(60),
	@Nume_Disciplina VARCHAR(255)
AS
BEGIN
	IF(SELECT COUNT(*)
			FROM cadre_didactice.profesori
			WHERE Nume_Profesor = @Nume_Profesor_Vechi AND Prenume_Profesor = @Prenume_Profesor_Vechi) <> 1
		BEGIN
			RAISERROR('Old Teacher: There is no such a teacher', 16, 1)
		END
	IF(SELECT COUNT(*)
			FROM cadre_didactice.profesori
			WHERE Nume_Profesor = @Nume_Profesor_Nou AND Prenume_Profesor = @Prenume_Profesor_Nou) <> 1
		BEGIN
			RAISERROR('New Teacher: There is no such a teacher', 16, 1)
		END
	IF(SELECT COUNT(*)
			FROM plan_studii.discipline
			WHERE Disciplina = @Nume_Disciplina) <> 1
		BEGIN
			RAISERROR('Discipline: There is no such a discipline', 16, 1)
		END
	
	UPDATE studenti.studenti_reusita
	SET Id_Profesor = (SELECT Id_Profesor
						FROM cadre_didactice.profesori
						WHERE Nume_Profesor = @Nume_Profesor_Nou AND Prenume_Profesor = @Prenume_Profesor_Nou)
	WHERE Id_Profesor = (SELECT Id_Profesor
							FROM cadre_didactice.profesori
							WHERE Nume_Profesor = @Nume_Profesor_Vechi AND 
							Prenume_Profesor = @Prenume_Profesor_Vechi) AND
			Id_Disciplina = (SELECT Id_Disciplina
								FROM plan_studii.discipline
								WHERE Disciplina = @Nume_Disciplina)								
END

EXECUTE Procedure_Task4 'Frent', 'Tudor', 'Popescu', 'Gabriel', 'Cercetari operationale'
```

![Task4_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task4_1.PNG)

![Task4_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task4_2.PNG)

#### Task 5
```sql
USE universitatea
GO
DROP PROCEDURE IF EXISTS Procedure_Task5
GO
CREATE PROCEDURE Procedure_Task5
	@Nume_Disciplina VARCHAR(255)
AS
BEGIN
	DECLARE @Best_students TABLE
	(
		Id_Student INT,
		Nota_Maxima INT 
	)

	INSERT INTO @Best_students
	SELECT TOP(3) studenti_reusita.Id_Student, SUM(Nota) AS Nota_Maxima
	FROM studenti.studenti_reusita
	JOIN studenti.studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Disciplina = @Nume_Disciplina
	GROUP BY studenti_reusita.Id_Student
	ORDER BY Nota_Maxima DESC

	SELECT Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume_Student, Disciplina, 
		Nota AS Nota_Veche, IIF(Nota < 10, Nota + 1, Nota) AS Nota_Noua
	FROM studenti.studenti_reusita
	JOIN studenti.studenti
	ON studenti_reusita.Id_Student = studenti.Id_Student
	JOIN dbo.grupe
	ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
	JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare = 'Examen' AND Disciplina = @Nume_Disciplina AND 
			studenti_reusita.Id_Student IN (SELECT Id_Student FROM @Best_students)

	UPDATE studenti.studenti_reusita
	SET Nota = Nota + 1
	WHERE Id_Student IN (SELECT Id_Student FROM @Best_students) AND Nota < 10
END

EXECUTE Procedure_Task5 'Modelarea sistemelor'
```

![Task5](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task5.PNG)

#### Task 6
1st Function
```sql
USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task6_1
GO
CREATE FUNCTION dbo.Function_Task6_1(@Tip_Evaluare VARCHAR(20), @Data_Evaluare VARCHAR(10), @Nota_Min SMALLINT,
									@Nota_Max SMALLINT, @Disciplina VARCHAR(60))
RETURNS TABLE
AS
RETURN (SELECT Nume_Student, Prenume_Student
		FROM studenti.studenti
		JOIN studenti.studenti_reusita
		ON studenti.Id_Student = studenti_reusita.Id_Student
		JOIN plan_studii.discipline
		ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		WHERE Tip_Evaluare = @Tip_Evaluare AND Data_Evaluare LIKE @Data_Evaluare 
			AND Nota BETWEEN @Nota_Min AND @Nota_Max AND Disciplina = @Disciplina)

SELECT *
FROM dbo.Function_Task6_1('Examen', '2018-%-%', 4, 8, 'Baze de date')
```

![Task6_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task6_1.PNG)

2nd Function
```sql
USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task6_2
GO
CREATE FUNCTION dbo.Function_Task6_2(@Tip_Evaluare VARCHAR(20), @Nota_Min SMALLINT)
RETURNS TABLE
AS
RETURN (SELECT Nume_Student, Prenume_Student
		FROM studenti.studenti
		INNER JOIN studenti.studenti_reusita
		ON studenti.Id_Student = studenti_reusita.Id_Student
		WHERE NOT studenti.Id_Student = ANY (SELECT Id_Student
												FROM studenti.studenti_reusita
												WHERE Tip_Evaluare = @Tip_Evaluare AND Nota > @Nota_Min))

SELECT *
FROM dbo.Function_Task6_2('Reusita curenta', 5) 
```

![Task6_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task6_2.PNG)

#### Task 7
```sql
USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task7
GO
CREATE FUNCTION dbo.Function_Task7(@Data_Nasterii_Student DATE)
RETURNS SMALLINT
AS
BEGIN
	DECLARE @Current_Date DATE
	DECLARE @Birthday_Pass INT

	SET @Current_Date = GETDATE()

	IF MONTH(@Data_Nasterii_Student) >= MONTH(@Current_Date)
	BEGIN
		IF DAY(@Data_Nasterii_Student) > DAY(@Current_Date)
		BEGIN
			SET @Birthday_Pass = 1
		END
		ELSE
		BEGIN
			SET @Birthday_Pass = 0
		END
	END
	ELSE
	BEGIN
		SET @Birthday_Pass = 0
	END

	RETURN(DATEDIFF(YEAR, @Data_Nasterii_Student, @Current_Date) - @Birthday_Pass)
END

SELECT Nume_Student, Prenume_Student, Data_Nastere_Student, dbo.Function_Task7(Data_Nastere_Student) AS Age
FROM studenti.studenti
```

![Task7](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task7.PNG)

#### Task 8
```sql
USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task8
GO
CREATE FUNCTION dbo.Function_Task8(@Nume_Prenume_Student VARCHAR(120))
RETURNS TABLE
AS
RETURN (SELECT Nume_Student + ' ' + Prenume_Student AS Nume_Prenume_Student, Disciplina, Nota, Data_Evaluare 
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN plan_studii.discipline
		ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		WHERE studenti.Nume_Student + ' ' + studenti.Prenume_Student = @Nume_Prenume_Student)

SELECT *
FROM dbo.Function_Task8('Dobrea Daniela')
```

![Task8](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task8.PNG)

#### Task 9
```sql
USE universitatea
GO
DROP FUNCTION IF EXISTS dbo.Function_Task9
GO
CREATE FUNCTION dbo.Function_Task9(@Cod_Grupa CHAR(6), @Is_Good VARCHAR(15))
RETURNS @Ret TABLE (
	Grupa CHAR(6),
	Nume_Prenume_Student VARCHAR(120),
	Nota DECIMAL(4, 2),
	Criteriu_cautare VARCHAR(15)
)
AS
BEGIN
	IF @Is_Good = 'Sirguincios'
	BEGIN
		INSERT @Ret
		SELECT TOP(1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume,  
			CAST(AVG(CAST(Nota AS DECIMAL(4, 2))) AS DECIMAL(4, 2)) AS Nota_Medie, @Is_Good
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN dbo.grupe
		ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
		WHERE Cod_Grupa = @Cod_Grupa
		GROUP BY  Cod_Grupa, Nume_Student + ' ' + Prenume_Student
		ORDER BY Nota_Medie DESC
		RETURN
	END
	IF @Is_Good = 'Slab'
		BEGIN
		INSERT @Ret
		SELECT TOP(1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student AS Nume_Prenume,  
			CAST(AVG(CAST(Nota AS DECIMAL(4, 2))) AS DECIMAL(4, 2)) AS Nota_Medie, @Is_Good
		FROM studenti.studenti_reusita
		JOIN studenti.studenti
		ON studenti_reusita.Id_Student = studenti.Id_Student
		JOIN dbo.grupe
		ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
		WHERE Cod_Grupa = @Cod_Grupa
		GROUP BY  Cod_Grupa, Nume_Student + ' ' + Prenume_Student
		ORDER BY Nota_Medie ASC
		RETURN
	END
	RETURN
END

SELECT *
FROM dbo.Function_Task9('CIB171', 'Sirguincios')

SELECT *
FROM dbo.Function_Task9('CIB171', 'Slab')
```

![Task9](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.9/Screens/Task9.PNG)
