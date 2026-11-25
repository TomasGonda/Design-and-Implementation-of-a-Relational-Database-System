--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_MIESTNOST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "GONDA1"."TRG_MIESTNOST" 
before insert on miestnost
for each row
begin
    :new.id_miestnosti := 'M' || lpad(s_miestnost.nextval, 3, '0');
end;

/
ALTER TRIGGER "GONDA1"."TRG_MIESTNOST" ENABLE;
