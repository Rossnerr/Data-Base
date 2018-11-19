USE universitatea

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Ora, Auditoriu, Bloc, Zi)
VALUES((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Structuri de date si algoritmi'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Bivol' AND Prenume_Profesor = 'Ion'),
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'), '08:00', 502, 'B', 'Luni'),

	  ((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Programe aplicative'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Mircea' AND Prenume_Profesor = 'Sorin'),	   
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'), '11:30', 502, 'B', 'Luni'),

      ((SELECT Id_Disciplina FROM discipline WHERE Disciplina = 'Baze de date'),
	   (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor = 'Micu' AND Prenume_Profesor = 'Elena'),   
	   (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = 'INF171'), '13:00', 502, 'B', 'Luni')