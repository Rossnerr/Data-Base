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

The last point of this task was to create a new filegroup for the secondary files, make it default and set autogrowth property to 64 MB and
maximum size to 1024 MB. In order to create a new file group choose "Filegroups" option from the "New Database" window. In the "Rows" 
section press the "Add Filegroup" button. After I checked the "Default" box. This means that objects that will be created without a 
specified filegroup they will be attached to the default one. Just one filegroup can be set as a default one at a time.

#### Task 2
This task is similar to the previous one because a new database have to be created. In this database just the log file should be placed
in another directory that's why onle the log file's path shout be replaced. Also the logical name should be different from the file
name. So I changed the file name.
