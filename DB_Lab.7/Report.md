# Laboratory Work Nr. 7

### Purpose of the laboratory work
* Get familiar with diagrams
* Get familiar with schemes
* Get familiar with synonyms

### Tasks
1. Create a diagram of the database _universitatea_, using the standard form of visualisation. Its structure is described at the beginning of the practice part in chapter 4.
2. Add referencial constraints which are necessary for the columns _Sef_grupa_ and _Prof_Indrumator_ from the table _grupe_.
3. Add the table _orarul_ which was defined in the previous laboratory work to the created scheme. Table _orarul_ contains _Id_Disciplina_, _Id_Profesor_ and _Bloc_. The key of the table is formed by other 4 columns: _Id_Grupa_, _Zi_, _Ora_ and _Auditoriu_.
4. The above mentioned table _orarul_ should contain 2 secondary keys. First one is formed from columns: _Zi_, _Ora_, _Id_Grupa_ and _Id_Profesor_. The second one contains next columns: _Zi_, _Ora_, _Id_Grupa_ and _Id_Disciplina_.
5. In the diagram should be defined the referential constraints (FK-PK) for attributes: _Id_Disciplina_, _Id_Profesor_ and _Id_Grupa_ from table _orarul_.
6. Create 3 new schemes in database _universitatea_: _cadre_didactice_, _plan_studii_ and _studenti_. Transfer the table _profesori_ from _dbo_ scheme to the _cadre_didactice_ scheme. Perform the same stuff using tables _oraul_ and _discipline_ which should be transfered to _plan_studii_ scheme. Also transfer tables _studenti_ and _studenti_reusita_ to scheme called _studenti_. Write the corresponding SQL instructions.
7. Modify 2-3 queries presented in the 4th laboratory work. Use the explicit name of the tables and take into consideration the fact that they belong to new schemes.
8. Create synonyms in order to simplify the queries from exercise 7. Rewrite the queries using the new formed synonyms.  

### Laboratory work implementation

#### Task 1
In order to create a diagram of a certain database, we should choose first the database based on which the diagram will be created. Second thing I did was choosing from the list of available tables those which I would like to insert in my diagram. Because of the structure refered in condition I included in my diagram 5 tables: _discipline_, _grupe_, _studenti_, _profesori_ and _studenti_reusita_. The connections between tables were automatically established. This happend because at the creation time some constraints were defined. As it was mentioned in the task I used the standard form of visualisation. Below is attached the screen where the diagram is presented.

![Task 1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task1.PNG)

#### Task 2
In this task I added some referential constraints related to columns _Sef_grupa_ and _Prof_Indrumator_ from the table _grupe_ manually. As it can be remembered during laboratory work nr.6 the table _grupe_ suffered some changes and those changes had not been handled from referential point of view. In column _Sef_grupa_ is stored the Id of the student with the highest mark from a certain group. In column _Prof_Indrumator_ is stored the Id of the teacher with the largest number of hours with a certain group. So taking in consideration this information it seems obvious what referencial constraints should be added. They will be of FK-PK type. In first case as PK key will serve _Id_Student_ column from _studenti_ table and as a FK key _Sef_grupa_ from _grupe_ table. In the second one the PK will be _Id_Profesor_ column from _profesori_ table and as a FK key _Prof_Indrumator_ from _grupe_ table. The diagram in which will be presented these relations can be seen below.

![Task 2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task2.PNG)

#### Task 3
This task deals with editing an already existing diagram. To the diagram created above I added one more table called _orarul_. In order to perform this it is necessary to chose the existing diagram and then add a table to it. Because no referential constraint were defined at the creation time the added table will not be related to any of the tables existing in the diagram. The below screen shows it.

![Task 3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task3.PNG)

#### Task 4
The 4th task asks us to add 2 secondary keys to the table _orarul_. In Microsoft SQL Server Management Studio secondary keys are refered to unique keys. First I had chosen the table were the keys should be added then I added the keys themselves. In order to create first key I selected the columns mentioned in the condition and then set a name for it. The second key was created in the same manner using other columns and setting a different name. Screen with the both key presented can be find below.

![Task 4.1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task4.1.PNG)

![Task 4.2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task4.2.PNG)
