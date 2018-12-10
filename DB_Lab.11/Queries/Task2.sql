USE universitatea
GO
IF EXISTS(SELECT * FROM master.dbo.sysdevices WHERE name='device02')
EXEC sp_dropdevice 'device02', 'delfile'
GO
EXEC sp_addumpdevice 'DISK', 'device02', 'C:\DB_Lab.11\Backup_lab.11\exercitiul2.bak'
GO
BACKUP DATABASE universitatea
TO device02