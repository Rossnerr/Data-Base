USE universitatea
GO
CREATE SCHEMA cadre_didactice AUTHORIZATION dbo;
GO
CREATE SCHEMA plan_studii AUTHORIZATION dbo;
GO
CREATE SCHEMA studenti AUTHORIZATION dbo;
GO
ALTER SCHEMA cadre_didactice TRANSFER dbo.profesori;
GO 
ALTER SCHEMA plan_studii TRANSFER dbo.orarul
GO
ALTER SCHEMA plan_studii TRANSFER dbo.discipline;
GO
ALTER SCHEMA studenti TRANSFER dbo.studenti;
GO
ALTER SCHEMA studenti TRANSFER dbo.studenti_reusita;