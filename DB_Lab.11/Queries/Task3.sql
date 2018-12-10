USE universitatea
GO
IF EXISTS(SELECT * FROM master.dbo.sysdevices WHERE name='device03')
EXEC sp_dropdevice 'device03', 'delfile'
GO
EXEC sp_addumpdevice 'DISK', 'device03', 'C:\DB_Lab.11\Backup_lab.11\exercitiul3.bak'
GO
BACKUP LOG universitatea
TO device03