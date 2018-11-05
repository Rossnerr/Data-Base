# Laboratory Work Nr. 5

### Purpose of the laboratory
* TRANSACT-SQL
* Procedural Instruction
* Variables
* Flow Control Structures
* Functions which use NULL value
* Exceptions

### Tasks
1. Complete the following lines of code in order to find the largest number among those 3 which are given.
2. Display the first ten students(First Name and Last Name) who took the Test 1 at Baze de date and get a mark different from 6 and 8. USE the IF...ELSE structure and variables.
3. Solve the same task as in the first exercise but now using the CASE structure.
4. Modify the task 1 and 2 so that you will be able process the errors by using TRY and CATCH and RAISERROR.

### Laboratory work implementation

#### Task 1
In the given lines of code there are declared 4 variables of integer type. Three of them are set to a value which are computed randomly. They are N1, N2 and N3. The forth one is used in order to store the largest number between those 3 and its name is MAI_MARE. 
Next I introduce few lines of code which help me to find out the largest number. First I use an IF statement in order to compare the first two numbers. If the N1 is larger than N2 its value is assigned to the variable MAI_MARE. The second IF statement is used because it can happen that the N2 will be larger so in this case the variable MAI_MARE will take its value. The last IF statement is used to compare the largest number between the first two which is stored in MAI_MARE with N3. If the MAI MARE variable is larger than the third number than it will keep its value otherwise it will take the value of the N3.
At the end I print those 3 numbers and the largest one among them.

![Task 1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task1.PNG)

#### Task 2
Because there are some conditions which must be followed while writing the querry I have performed the next steps. First I declared a variable of integer type called CONTOR. As its name suggests it will be used in order to count how many students of those which satisfy the task exists. I have perfomed that by joining three tables studenti_reusita, studenti and discipline. Now when I have all the attributes I need I start to choose only those who satisfies the requirements. By introducing the aggregation function COUNT(*) I count how many students there will be. The obtained value I store in the CONTOR variable.
Next I check if there are more than 10 students of these type I display only the first ten. If not I print a message that tells "There are less than 10 students which satisfy the specified condition". The comparison is made by using an IF...ELSE structure.

![Task 2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task2.PNG)

#### Task 3
This task's requirement was to use CASE structure for performing the exercise 1. So I decided to do it the following way. The declaration and initialization parts ramain the same as in the previous exercise.
Reading the given theory I found out that CASE structure can be used in SET instructions so next I decided to set the variable MAI_MARE with the corresponding value by using CASE structure. My CASE strcture consists from 3 WHEN conditions. First checks if N1 is larger than N2 and N3 and if so it sets the value of the variable MAI_MAIRE equal to N1. Second one performs the same but using N2 and third one is doing the same but for N3. Is important to mention here that when a condition result is TRUE the value after THEN is returned and no more conditions are checked.

![Task 3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task3.PNG)

#### Task 4
In this task I worked with exceptions or errros and tried to handle them. It was up to me to decide how the errors should be handled and when they should occur.
For the Task 1 I decided to introduce an error in case that all the numbers will be equal. Why so? Because it is not possible to choose the largest number if all of them are equl. So after the declaration and initializtion parts I introduced the TRY block where it checks if the numbers are equal or not. In case that they are equal a RAISERROR instruction is used in order to raise an error. The RAISERROR instructions takes 3 arguments: message of the error, its severity and its state. In case that the numbers are not equal it will find the largest number among the given ones and print them. I introduced this part of code in TRY block because it can generate an error.
After TRY block always should follow the CATCH block. After the error is raised in the TRY block the execution goes to CATCH block. Which is used in order to handle the occured error. I handle the error by printing that an error occured. Also I print error's message and number of line which generate the error.

![Task 4.1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task4.1NoErrors.PNG)

![Task 4.1 Error](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task4.1Errors.PNG)

The same treatment for the errors I have introduced in Task 2. The difference consists in the condition that will raise the error. Here the error will appear in case that there will not be 10 students which satisfy the condition.

![Task 4.2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task4.2NoErrors.PNG)

![Task 4.2 Errors](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.5/Screens/Task4.2Errors.PNG)

Above were presented 2 type of screens. First when no errors are met. And second when an error occurs.

### Conclusion
During this laboratory work I get advanced in T-SQL language. I found out that beside writing querries I can do some programming in T-SQL too. I learned how to work with the variables, how to declare and initialize them. Also I used some of the flow control structures in order to perform certain tasks. I learned their behaviour and how I can combine them with different clauses or instructions. Because the errors are a part of the programming it is very useful to know how to handle them and sometimes how to raise them if it is necessary. These things I learned while performing the laboratory work too.
