USE universitatea
GO
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='device01')
EXEC sp_dropdevice 'device01' , 'delfile';
GO
EXEC sp_addumpdevice 'DISK', 'device01', 'C:\DB_Lab.11\Backup_lab.11\exercitiul1.bak'
GO
BACKUP DATABASE universitatea
TO device01
WITH FORMAT, 
		NAME = 'universitatea - Full Database Backup'