# Laboratory Work Nr. 11

### Purpose of the laboratory work
* Get familiar with the process of restoration a databe
* Learn how to restore a database

### Tasks
1. Create a folder called 'Backup_lab11'. Perform a full backup of the 'universitatea' database in the previous mentioned folder. The backup file should be called 'exercitiul1.bak'. Write the corresponding T-SQL instruction.
2. Write a T-SQL instruction which will perform a differentiate backup of the 'universitatea' database. The backup file should be called 'exercitiul2.bak'.
3. Write a T-SQL instruction which will perform a log backup of the 'universitatea' database. The backup file should be called 'exercitiul3.bak'.
4. Perform the restoration of the above created backup files. Restoration should be executed in a new database called 'universitatea_lab11'. Files of the new database should be included in the folde 'Backup_lab11'. Write the corresponding T-SQL instruction.

 ### Laboratory work implementation

#### Task 1
```sql
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
```

![Task1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.11/Screens/Task1.PNG)

#### Task 2
```sql
USE universitatea
GO
IF EXISTS(SELECT * FROM master.dbo.sysdevices WHERE name='device02')
EXEC sp_dropdevice 'device02', 'delfile'
GO
EXEC sp_addumpdevice 'DISK', 'device02', 'C:\DB_Lab.11\Backup_lab.11\exercitiul2.bak'
GO
BACKUP DATABASE universitatea
TO device02
```

![Task2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.11/Screens/Task2.PNG)

#### Task 3
```sql
USE universitatea
GO
IF EXISTS(SELECT * FROM master.dbo.sysdevices WHERE name='device03')
EXEC sp_dropdevice 'device03', 'delfile'
GO
EXEC sp_addumpdevice 'DISK', 'device03', 'C:\DB_Lab.11\Backup_lab.11\exercitiul3.bak'
GO
BACKUP LOG universitatea
TO device03
```

![Task3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.11/Screens/Task3.PNG)

#### Task 4
```sql
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
```

![Task4](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.11/Screens/Task4.PNG)
