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