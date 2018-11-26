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