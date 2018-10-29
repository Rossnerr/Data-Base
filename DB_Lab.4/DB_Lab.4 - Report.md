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
In order to obtain the correct result I have used 2 INNER JOINS. First JOIN is between studenti and studenti_reusita tables. It was made on Id_Student attributes from both tables. From the obtained result I can manipulate with the mark(greater than 4 and less than 8), type of the evaluation(Examen) and evaluation date(2018). But I also need to manipulate with the discipline name. Because the result of the first JOIN gives me the possibility to manipulate just the discipline id I introduced the second JOIN. It will join the discipline table on Id_Disciplina attribute. It helped me to manipulate with the discipline name(Baza de date). Considering the task, I have just displayed students last and first names in the result. These happend because of the introducing Nume_Student and Prenume_Student after SELECT clause.
![Task 1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.4/Screens/Task1.PNG)

#### Task 2
For solving this task I used just 1 INNER JOIN between studenti_reusita and profesori tables. It was done on Id_Profesor attributes with the equal sign between them. Basically it does the NATURAL JOIN between the above mentioned tables. After I used the COUNT aggregate function in order to count the disciplines. And because I don't want them to repeat I use the DISTINCT option. Is a good idea to use the ALIAS or AS option within an agregate function in order to give a name to the attribute which will display the number of disciplines. So I used it. As we know COUNT agregate function should work together with a GROUP BY clause in order to avoid the errors. In the GROUP BY clause I introduced all the attributes from the SELECT clause except the aggregate function. 
![Task 2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.4/Screens/Task2.PNG)

#### Task 3
This task was different from the the previous ones because it returns nothing and I used a subquerry in order to obtain a solution. By "returns nothing" I mean there are no such entries in the database that will satisfy the condition of the querry. The subquerry was used in order to find the students who have a mark greater than 5 at "Reusita curenta". Here I used 1 INNER JOIN between studenti and studenti_reusita tables. It was done Id_Student attributes. The students with a different id from those returned by the subquerry will be displayed.
![Task 3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.4/Screens/Task3.PNG)


### Conclusion
During this laboratory work I get introduced to T-SQL language. I learned how to create a query and which are its clauses. Queries can be of different dificulty level. The more complex queries use joins and aggreagation functions beside the regular clauses. Another important feature I have used in this laboratory work are the subqueries. Sometimes is much more easier to use a subquery beside multiple joins or other operations.  
