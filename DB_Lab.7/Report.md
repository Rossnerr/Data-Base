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

#### Task 5
Because no referential constraints were added to the table _orarul_. This task's purpose is to correct it. In the table _orarul_ there are 3 attributes which should create the link with other tables. They are: _Id_Disciplina_, _Id_Grupa_ and _Id_Profesor_. All these 3 will serve as FKs, while the PKs will be the same attributes but from different tables. After the settings of the keys are done the relationships will appear in the diagram. The diagram with the corresponding relationships is presented below.

![Task 5](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task5.PNG)

#### Task 6
In contrast to the tasks analyzed above this one permits its execution not only by using SQL Server Management Studio Graphical Interface but also by using the T-SQL language. Between these two methods I choose the second one. So I created a query that creates 3 new schemes: _cadre_didactice_, _plan_studii_ and _studenti_. While creating a new schema is mandatory to give it a name and a owner. The other stuff is optional. In order to set a owner the AUTHORIZATION clause is used. It should be followed by owner's name. After the schemes had been made I transfered objects between the schemes accordingly to the condition. In order to transfer them I used the modifying clause ALTER SCHEMA and TRANSFER clause. After the first one the name of the destination scheme should be written. And after the second one the source scheme and the name of the object that should be transfered are specified. In the screen presented below are shown all the created schemas and the transfered objects.

![Task6](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task6.PNG)

#### Task 7
In order to understand better how the schemes work and what are their purposes this task propose us to rewrite the queries created in the laboratory work nr. 4. Because some tables schemes are now different the name of the tables should now be written in an explicit way. Although the queries will not be executed because of not finding the object. The queries should output the same results. Results of the queries will be presented below. While the queries themselves can be found in _Querries_ folder.

![Task 7.1](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task7.1.PNG)

![Task 7.2](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task7.2.PNG)

![Task 7.3](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task7.3.PNG)

#### Task 8
This task can bee seen as a simplified way of writing the queries from previous exercise. In order to avoid writing everytime those long names consisting from 2 parts: name of the tables and name of the schemes I created synonyms for them. A synonym is an object of a database which offers an alternative name for an already existing object. Now I can refer to the synonyms as to the original object. In order to create a synonym I used CREATE SYNONYM clause followed by the name of the synonym. Right after its name is specified FOR clause and the scheme together with the name of the object for which the synononym have to be created. After the synonyms are created the queries can be rewritten and now I can refert to the tables using the coresponding synonym. The results of the queries are the same. In the next screen all the created synonyms are shown.

![Task 8](https://github.com/Rossnerr/Data-Base/blob/master/DB_Lab.7/Screens/Task8.PNG)

### Conclusion
During this laboratory work I get familiar with a lot of useful notions while working with a database. I find out how to create a diagram, how to edit it and how to establish referencial constraints between its tables if they were not defined at the creation time. In order to limit the access of a user to the database objects the schemes can be used. I discovered how to create a scheme and how to transfer objects between the schemes. In order to make the process of writing queries simpler while the objects involved in them are from different schemes this laboratory work introduced me to such a notion called synonym. They can be used in order to refer to the same object but with an alternative name.
