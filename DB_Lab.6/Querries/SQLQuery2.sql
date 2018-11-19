USE universitatea

ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) not null;

ALTER TABLE grupe 
ADD UNIQUE(Cod_Grupa)