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
