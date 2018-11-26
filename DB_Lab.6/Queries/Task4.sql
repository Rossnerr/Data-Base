USE universitatea

UPDATE studenti_reusita
SET Nota = Nota + 1
WHERE Id_Student IN (SELECT Sef_grupa 
FROM grupe) AND Nota <> 10