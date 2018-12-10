USE universitatea
GO
IF EXISTS(SELECT * FROM master.sys.databases WHERE name='universitatea_lab11')
DROP DATABASE universitatea_lab11
GO
RESTORE DATABASE universitatea_lab11
FROM device01
WITH MOVE 'universitatea' TO 'C:\DB_Lab.11\Backup_lab.11\universitatea_lab11.mdf',
		MOVE 'universitatea_log' TO 'C:\DB_Lab.11\Backup_lab.11\universitatea_lab11_log.ldf',
		MOVE 'firstfile' TO 'C:\DB_Lab.11\Backup_lab.11\universitatea_lab11_firstfile.mdf',
		NORECOVERY
GO
RESTORE DATABASE universitatea_lab11
FROM device02
WITH NORECOVERY
GO
RESTORE DATABASE universitatea_lab11
FROM device03
WITH NORECOVERY