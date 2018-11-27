# Laboratory Work Nr.2

### Purpose of the laboratory
* Creation of a database
* Maintenance of a database

### Objectives
* Instalation of the software
* Ability to work with a database software

### Tasks
* Create a database in "MyDocuments\Data" directory. The primary file should have an autogrowth property set to 16 MB and its size should 
be limited to 128 MB. Set the autogrowth

### Laboratory work implementation
In this laboratory work I had to perform 4 main tasks. So I will go through all of them.

#### Task 1
First of all I created a database in the required directory. How to do this? Is not that hard, just go find "Databases" folder, righ-click on it and choose 
"New Database" option. Once I created it a new window showed up. There were presented 2 files: the primary file and the log file. The files
mentioned previously are mandatory in all the databases. Primary Files contain the startup information for the database and points to the 
other files in the database. Every database have only one primary file. This type of files have .mdf extension. Log Files are considered to 
be the transaction log files because the hold the log information that is used to recover the database. There must be at least one log file
for each database. The file extension for transaction logs is .ldf. In order to place the database in a certain directory I changed the
paths of the primary and log file.

Next in this task is required to set the autogrowth property of the primary file to 16 MB and limit its size to 128 MB and for the log file
is required to set its autogrowth property to 64 MB and limit its size to 1024 MB. Autogrowth property is used to offer some information
about the database is supposed to grow. There are 2 options. The grow can be shown in percentage or megabytes. I chose the second one
according to the condition. Limited to(MB) option is used in order to specify the maximum size.

The last point of this task was to create a new filegroup for the secondary files, make it default and set autogrowth property to 64 MB and maximum size to 1024 MB. In order to create a new file group choose "Filegroups" option from the "New Database" window. In the "Rows" section press the "Add Filegroup" button. After I checked the "Default" box. This means that objects that will be created without a specified filegroup they will be attached to the default one. Just one filegroup can be set as a default one at a time.

![Exercise 1.1](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%201.1.png)

![Exercise 1.2](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%201.2.PNG)

#### Task 2
This task is similar to the previous one because a new database have to be created. In this database just the log file should be placed
in another directory that's why only the log file's path shout be replaced. Also the logical name should be different from the file
name. So I changed the file name.

Here there some extra options that should be confgured in a certain way. The created database should be compatible with "MS SQL Server 2017" and its access should be limited to a one user at a time. In order to realize these condition I chose "Options" section in the "New Database" window. After I set the compatibility level to the one mentioned in the conditions. In order to configure its access find the "Restrict Access" option and choose the Single-User mode.

![Exercise 2.1](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%202.1.PNG)

![Exercise 2.2](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%202.2.PNG)

#### Task 3
A database maintenance plan is a set of specific tasks that need to be performed regularly on databases to ensure their adequate performance and availability. There are 2 ways of creating a maintenance plan. You can do it with the help of the assistent or manually. I chose to do it with the assistent help. First of all I named my maintenance plan and schedule it accordingly to the task. This plan will be performed every friday at 00.00. Because the plan should erase the unused space when it grows up to 2000 MB I chose "Shrink Database" option as a maintenance task. After this I selected the option that gives the oportunity to return the freed space to the operating system. Also I chose to save the reports about executing this plan to a certain directory indicated in the task. I applied the maintenance plan created in task 3 to the database created in the task 1.

![Exercise 3.1](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%203.1.PNG)

![Exercise 3.2](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%203.2.PNG)

![Exercise 3.3](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%203.3.PNG)

#### Task 4
This task is similar to the third one. The difference is that here I used more than one maintenance task in the same plan. The created plan was applied to the database created in the task 2. First of all I gave named this plan as it is mentioned in the task. This plan should perform 3 steps. First and second step are related to the same maintenance task and it is "Rebuild Index". Its purpose is to rebuild indexes from all the tables. Also the free space on the page should be changed to 10%. And the sort process of the indexes should take place in tempdb. After the rebuilding is done the statistics are colected. The third step is performed by the "Clean Up History" task. I used this task in order to clean up the Backup-Restore history. The history older than 6 weeks will be deleted according to my settings. I scheduled the plan to be executed in the first Sunday of the each month. It mean one Sunday in every 5 weeks. As in the previous task the report of the executed plan is saved in a certaind directory indicated in the task.

![Exercise 4.1](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%204.1.PNG)

![Exercise 4.2](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%204.2.PNG)

![Exercise 4.3](https://github.com/Rossnerr/Data-Base/blob/master/Screens/Exercise%204.3.PNG)
