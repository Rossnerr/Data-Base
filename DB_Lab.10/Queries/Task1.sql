USE universitatea
GO
DROP TRIGGER IF EXISTS plan_studii.Trigger_Task1
GO
CREATE TRIGGER plan_studii.Trigger_Task1 on plan_studii.orarul
	AFTER UPDATE
	AS SET NOCOUNT ON
		IF(UPDATE(Auditoriu))
			BEGIN
				SELECT  DISTINCT 'Spre atentia studentilor din grupa ' +
						grupe.Cod_Grupa + '!' +
						'Lectia la disciplina "' + 
						UPPER(discipline.Disciplina) +
						'" de la ora ' +
						CAST(inserted.Ora AS VARCHAR(5)) +
						' care trebuia sa se desfasoare in ziua de ' +
						inserted.Zi +
						' in aula ' +
						CAST(deleted.Auditoriu AS CHAR(3)) +
						' din blocul ' +
						inserted.Bloc +
						' a fost transferata in aula ' + 
						CAST(inserted.Auditoriu AS CHAR(3)) + '.'
				FROM inserted
				JOIN plan_studii.discipline
				ON inserted.Id_Disciplina = discipline.Id_Disciplina
				JOIN deleted
				ON deleted.Id_Disciplina = discipline.Id_Disciplina
				JOIN dbo.grupe
				ON inserted.Id_Grupa = grupe.Id_Grupa
			END
GO

UPDATE plan_studii.orarul
SET Auditoriu = 301
WHERE Zi = 'Luni'