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