# Laboratory Work Nr. 6

### Purpose of the laboratory work
* Get familiar with tables
* Get familiar with indexes

### Tasks
1. Write a T-SQL instruction in order to populate _Adresa_Postala_Profesor_ column from the table _profesori_.  The value that should be
added is 'mun. Chisinau'. It should be inserted in the rows where the _Adresa_Postala_Profesor_ is NULL.
2. Modify the scheme of the table _grupe_, so that:
 * The column _Cod_Grupa_ will accept just UNIQUE values and will not accept NULL values;
 * Keep in mind that the Primary Key was already set to the column _Id_Grupa_.
3. Add 2 new columns _Sef_grupa_ and _Prof_Indrumator_ both of INT type to the table _grupe_. Populate the new columns with the candidates
who will fit the best the following requirement:
 * _Sef_grupa_ should have the highest average mark from his group on all the types of evaluations and at all the courses. The same student
 can not be the monitor for 2 groups.
 * _Prof_Indrumator_ should have the maximal amount of hours with a certain group. If there is no such a candidate, then the teacher with
 the minimal id will be chosen. A teacher can not be the supervisor of 2 groups.
 * Write the corresponding instructions using ALTER, SELECT, UPDATE clauses.
4. Write a T-SQL instruction which will increase the marks of group monitors at all the courses. The highest mark, 10, can not be increased.
5. Create a new table _profesori_new_. It should next columns: _Id_Profesor_, _Nume_Profesor_, _Prenume_Profesor_, Localitate, _Adresa_1_
and _Andresa_2_.
 * The column _Id_Profesor_ should be defined as a PK and based on it a CLUSTERED index should be built.
 * The column _Localitate_ should have a DEFAULT property. The default value for this column is 'mun.Chisinau'.
 * Insert all the data from table _profesori_ to table _profesori_new_. Write the corresponding T-SQL instructions. Next are presented
 source columns and destination columns: _Id_Profesor_ = _Id_Profesor_; _Nume_Profesor_ = _Nume_Profesor_; _Prenume_Profesor_ = 
 _Prenume_Profesor_; _Adresa_Postala_Profesor_ = _Localitate_; _Adresa_Postala_Profesor_ = _Adresa_1_; _Adresa_Postala_Profesor_ =
 _Adresa_2_. The column _Localitate_ should contain just the information about locality from _Adresa_Postala_Profesor_ column. In _Adresa_1_
 should be kept the name of the street and in _Adresa_2_ the building number and the appartment number.
 6. Insert into the table _orarul_ data which belong to the group 'CIB171' which id is 1. The inserted data are set for Monday. All the 
 lessons will take place in the building 'B'. Below are presented some other details about the insertion:
 
 (_Id_Disciplina_ = 107, _Id_Profesor_ = 101, Ora = '08:00', Auditoriu = 202);
 
 (_Id_Disciplina_ = 108, _Id_Profesor_ = 101, Ora = '11:30', Auditoriu = 501);
 
 (_Id_Disciplina_ = 119, _Id_Profesor_ = 117, Ora = '13:00', Auditoriu = 501);
 
 7. Write the necessary T-SQL instructions in order to populate the table _orarul_ with data which belongs to the group 'INF171'. The day
 will be Monday. Some of the data should be collected by using SELECT instructions and introduced in the table. The data which need to be
 introduced is:
 
 (_Ora_ = '08.00', _Disciplina_ = 'Structuri de date si algoritmi', Profesor = 'Bivol Ion');
 
 (_Ora_ = '11.30', _Disciplina_ = 'Programe aplicative', Profesor = 'Mircea Sorin');
 
 (_Ora_ = '13.00', _Disciplina_ = 'Baze de date', 'Profesor' = 'Micu Elena');
 
 8. Create the indexes which will improve the execution performance of the queries created in the 4th laboratory work. Analyze the results.
 The indexes should be placed in the filegroup named 'userdatafgroup1'.
 
 ### Laboratory work implementation

#### Task 1
```sql
USE universitatea

UPDATE profesori 
SET Adresa_Postala_Profesor = 'mun. Chisinau' 
WHERE Adresa_Postala_Profesor IS NULL;
```

![Task 1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task1.PNG)

#### Task 2
```sql
USE universitatea

ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) NOT NULL

ALTER TABLE grupe 
ADD UNIQUE(Cod_Grupa)
```

![Task 2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task2.PNG)

#### Task 3
```sql
USE universitatea

ALTER TABLE grupe
ADD Sef_grupa INT, Prof_Indrumator INT

UPDATE grupe
SET grupe.Sef_grupa = (SELECT TOP(1) Id_Student
FROM studenti_reusita
WHERE studenti_reusita.Id_Grupa = grupe.Id_Grupa
GROUP BY Id_Student
ORDER BY AVG(Nota) DESC)

ALTER TABLE grupe
ADD UNIQUE (Sef_grupa)

UPDATE grupe
SET grupe.Prof_Indrumator = (SELECT TOP(1) Id_Profesor
FROM studenti_reusita
WHERE studenti_reusita.Id_Grupa = grupe.Id_Grupa
GROUP BY Id_Profesor
ORDER BY COUNT(Id_Disciplina) DESC, Id_Profesor DESC)

ALTER TABLE grupe
ADD UNIQUE (Prof_Indrumator)
```

![Task 3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task3.PNG)

#### Task 4
```sql
USE universitatea

UPDATE studenti_reusita
SET Nota = Nota + 1
WHERE Id_Student IN (SELECT Sef_grupa 
FROM grupe) AND Nota <> 10
```

![Task 4](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task4.PNG)

#### Task 5
```sql
USE universitatea

CREATE TABLE profesori_new (
	Id_Profesor INT PRIMARY KEY Clustered,
	Nume_Profesor VARCHAR(60),
	Prenume_Profesor VARCHAR(60),
	Localitate VARCHAR(255) DEFAULT('mun.Chisinau'),
	Adresa_1 VARCHAR(255),
	Adresa_2 VARCHAR(255));

INSERT INTO profesori_new(Id_Profesor, Nume_Profesor, Prenume_Profesor, Localitate, Adresa_1, Adresa_2)
SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor,
CASE 
	WHEN CHARINDEX('str.', Adresa_Postala_Profesor) > 0 THEN
		SUBSTRING(Adresa_Postala_Profesor, 1, CHARINDEX('str.', Adresa_Postala_Profesor) - 3)
	WHEN CHARINDEX('bd.', Adresa_Postala_Profesor) > 0 THEN 
		SUBSTRING(Adresa_Postala_Profesor, 1, CHARINDEX('bd.', Adresa_Postala_Profesor) - 3)
	WHEN CHARINDEX('mun.', Adresa_Postala_Profesor) > 0 THEN 
		SUBSTRING(Adresa_Postala_Profesor, 1, LEN(Adresa_Postala_Profesor))
END,

CASE 
	WHEN CHARINDEX('str.', Adresa_Postala_Profesor) > 0 THEN
		SUBSTRING(Adresa_Postala_Profesor, CHARINDEX('str.', Adresa_Postala_Profesor), PATINDEX('%[0-9]%', Adresa_Postala_Profesor) - CHARINDEX('str.', Adresa_Postala_Profesor) - 2)
	WHEN CHARINDEX('bd.', Adresa_Postala_Profesor) > 0 THEN 
		SUBSTRING(Adresa_Postala_Profesor, CHARINDEX('bd.', Adresa_Postala_Profesor), PATINDEX('%[0-9]%', Adresa_Postala_Profesor) - CHARINDEX('bd.', Adresa_Postala_Profesor) - 2)
END,

CASE 
	WHEN PATINDEX('%[0-9]%', Adresa_Postala_Profesor) > 0 THEN 
		SUBSTRING(Adresa_Postala_Profesor, PATINDEX('%[0-9]%', Adresa_Postala_Profesor), LEN(Adresa_Postala_Profesor) - PATINDEX('%[0-9]%', Adresa_Postala_Profesor) + 1)
END

FROM profesori
```

![Task 5](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task5.PNG)

#### Task 6
```sql
USE universitatea

CREATE TABLE orarul (
Id_Disciplina INT,
Id_Profesor INT,
Bloc CHAR(1) DEFAULT('B'),
Id_Grupa SMALLINT,
Zi CHAR(10),
Ora TIME,
Auditoriu INT,
PRIMARY KEY(Id_Grupa, Zi, Ora, Auditoriu));

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Bloc, Id_Grupa, Zi, Ora, Auditoriu)
VALUES(107, 101, 'B', 1, 'Luni', '08:00', 202),
	  (108, 101, 'B', 1, 'Luni', '11:30', 501),
      (119, 117, 'B', 1, 'Luni', '13:00', 501)
```

![Task 6](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task6.PNG)

#### Task 7
```sql
USE universitatea

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Bloc, Id_Grupa, Zi, Ora, Auditoriu)
VALUES((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Structuri de date si algoritmi'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Bivol' AND Prenume_Profesor = 'Ion'),
	   'B',
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'), 
	   'Luni',
	   '08:00',
	   502),

	  ((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Programe aplicative'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Mircea' AND Prenume_Profesor = 'Sorin'),
	   'B',	   
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'),
	   'Luni',
	   '11:30', 
	   502),

      ((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Baze de date'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Micu' AND Prenume_Profesor = 'Elena'),   
	   'B',
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'),
	   'Luni',
	   '13:00', 
	   502)
```

![Task 7](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.6/Screens/Task7.PNG)

     
