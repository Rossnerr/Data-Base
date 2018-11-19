USE universitatea

CREATE TABLE orarul (
Id_Disciplina INT,
Id_Profesor INT,
Id_Grupa INT,
Ora TIME,
Auditoriu INT,
Bloc CHAR(1) DEFAULT('B'),
Zi CHAR(10)
PRIMARY KEY(Id_Disciplina, Id_Profesor, Id_Grupa));

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Ora, Auditoriu, Bloc, Zi)
VALUES(107, 101, 1, '08:00', 202, 'B', 'Luni'),
	  (108, 101, 1, '11:30', 501, 'B', 'Luni'),
      (119, 117, 1, '13:00', 501, 'B', 'Luni')