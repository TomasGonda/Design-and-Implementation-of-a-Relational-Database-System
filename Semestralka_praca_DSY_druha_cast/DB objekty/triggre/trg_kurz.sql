--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_KURZ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MENO"."TRG_KURZ" 
before insert on kurz
for each row
begin
    :new.id_kurz := 'K' || lpad(s_kurz.nextval, 5, '0');
end;

/
ALTER TRIGGER "MENO"."TRG_KURZ" ENABLE;
