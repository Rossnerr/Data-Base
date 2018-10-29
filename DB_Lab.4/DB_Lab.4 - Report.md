# Laboratory Work Nr. 4

### Purpose of the laboratory
* SELECT Instruction
* TRANSACT-SQL

### Objectives
* Elements of T-SQL and PL SQL/language

### Tasks
1. Find the students who obtained a mark greater than 4 and less than 8 for the exam "examen" at the discipline called "Baza de date" in 2018. The result should contain student's last and first names.  
    
2. Get the number of the discplines taught by each teacher. The result should contain teacher's last name "Nume_Profesor" and first name "Prenume_Profesor".

3. Find the students' last name and first name who didn't get a pass mark which is considered to be greater than 5 for the сurrent situation "Reusita Curenta" at any discipline.   

### Laboratory work implementation

#### Task 1


#### Task 2
The answer is: DECIMAL(2,1). The first column accepts INT type and the second accepts DECIMAL(2,1) type. Taking in consideration the precedence rules the result should be of DECIMAL type. As we can see in the first column there are integers formed just from one digit and in the second column there are numbers that belongs to DECIMAL(2,1) type. The obtained result after multypling these 2 columns can be stored in a column with DECIMAL(2,1) data type.

#### Task 3
First I created a database called "universitatea" as it was mentioned in the task. Within this database I created 2 tables called "grupe" and "discipline". The tables structure were respected in accordance with the task.

![Exercise 3.1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.3/Screens/Exercise%203.1.PNG)

![Exercise 3.2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.3/Screens/Exercise%203.2.PNG)

![Exercise 3.3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.3/Screens/Exercise%203.3.PNG)

#### Task 4
After I had created the necessary database and tables in the previous task I introduced the required information in those tables. Then  content of the tables can be seen below:

![Exercise 4.1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.3/Screens/Exercise%204.1.PNG)

![Exercise 4.2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.3/Screens/Exercise%204.2.PNG)

### Conclusion
In this laboratory work I performed certain tasks while working with database tables. I learned how to create, modify and delete a table. In tables we can introduce data of different types. There are a lot of data types allowed to use in SQL Server 2017. In order to make sure that desired data was introduced we can apply the integrity constraints. They will help to keep our database safe. An important thing is the precedence rule that allows us to find out the type of the result while performing some calculations between different data types.  