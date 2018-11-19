USE universitatea

--INSERT profesori(Adresa_Postala_Profesor) VALUES ('mun.Chisinau');

UPDATE profesori 
SET Adresa_Postala_Profesor = 'mun. Chisinau' 
WHERE Adresa_Postala_Profesor IS NULL;

SELECT *
FROM profesori