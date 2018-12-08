# Laboratory Work Nr. 8

### Purpose of the laboratory work
* Get familiar with views
* Get familiar with common table expressions
* Lear how to administrate views and common table expressions

### Tasks
1. Create 2 views based on exercises from 4th laboratory work. One of them should be created using the 'View Designer' and the other using
the 'Query Editor'.
2. Write an example of INSERT, UPDATE and DELETE instruction on the created views. Leave some comments about the obtained results.
3. Write the SQL instructions which will modify the created views so that, there will not be possible to modify or delete the tables on
which views are defined. Also the views should not accept DML operations in case that conditions under WHERE clause are not respected.
4. Write the instructions which will test the properties added in 3rd task.
5. Rewrite 2 queries from the 4th laboratory work so that the subqueries will be represented as commont table expressions.
6. There is a graph presented in the figure below. There is a need in traversing it from node 3 to node 0. Represent the graph traversal
using the recursive common table expression.

![Graph](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Graph.PNG)

 ### Laboratory work implementation

#### Task 1
Query Editor:
```sql
CREATE VIEW Task1_1 AS
SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
FROM studenti.studenti_reusita
INNER JOIN cadre_didactice.profesori
ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
GROUP BY Nume_Profesor, Prenume_Profesor
```

![Task1_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task1_1.PNG)

View Designer:

![Task1_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task1_2.PNG)

#### Task 2
```sql
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
```

#### Task 3
```sql
ALTER VIEW dbo.Task1_1
WITH SCHEMABINDING
AS
	SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
	FROM studenti.studenti_reusita
	INNER JOIN cadre_didactice.profesori
	ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
	GROUP BY Nume_Profesor, Prenume_Profesor
WITH CHECK OPTION

ALTER VIEW dbo.View_Task1_2
WITH SCHEMABINDING
AS
	SELECT Nume_Student, Prenume_Student
	FROM studenti.studenti
	INNER JOIN studenti.studenti_reusita
	ON studenti.Id_Student = studenti_reusita.Id_Student
	INNER JOIN plan_studii.discipline
	ON studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	WHERE Tip_Evaluare='Examen' AND Data_Evaluare LIKE '2018-%-%' AND Nota BETWEEN 4 AND 8 AND Disciplina='Baze de date'
WITH CHECK OPTION
```

#### Task 4
```sql
USE universitatea
GO
ALTER TABLE cadre_didactice.profesori
DROP COLUMN Nume_Profesor
```

![Task 4_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task4_1.PNG)

```sql
USE universitatea
GO
UPDATE dbo.View_Task1_2
SET Disciplina = 'Cercetari Operationale'
WHERE Nume_Student LIKE 'C%'
```

![Task4_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task4_2.PNG)

#### Task 5
```sql
USE universitatea
GO
WITH CTE_1 AS (
	SELECT Nume_Profesor, Prenume_Profesor, COUNT(DISTINCT Id_Disciplina) AS Nr_Discipline_Predate
	FROM studenti.studenti_reusita
	INNER JOIN cadre_didactice.profesori
	ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
	GROUP BY Nume_Profesor, Prenume_Profesor
)

SELECT *
FROM CTE_1
```

![Task5_1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task5_1.PNG)

```sql
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
```

![Task5_2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task5_2.PNG)

#### Task 6
```sql
USE universitatea

DECLARE @graph TABLE
(
	Current_Node SMALLINT,
	Next_Node SMALLINT
)

INSERT @graph
SELECT 0, NULL
UNION ALL
SELECT 5, 0
UNION ALL
SELECT 1, 0
UNION ALL
SELECT 2, 1
UNION ALL
SELECT 3, 2
UNION ALL
SELECT 4, 2;

WITH CTE_Graph AS(
	SELECT *
	FROM @graph
	WHERE Current_Node = 3
	UNION ALL
	SELECT graph.*
	FROM @graph AS graph
	INNER JOIN CTE_Graph
	ON graph.Current_Node = CTE_Graph.Next_Node
)

SELECT *
FROM CTE_Graph
```

![Task6](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.8/Screens/Task6.PNG)
