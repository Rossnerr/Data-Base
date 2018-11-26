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