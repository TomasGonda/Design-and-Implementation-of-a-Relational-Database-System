--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_DATUM_PLATNOSTI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MENO"."TRG_DATUM_PLATNOSTI" 
before insert or update on cennik
for each row
begin
    if inserting then
        if :new.platnost_od is null then
            :new.platnost_od := sysdate;
        end if;
    end if;

    if updating then
        if :new.cena != :old.cena then
            :new.platnost_od := sysdate;
        end if;
    end if;
end;

/
ALTER TRIGGER "MENO"."TRG_DATUM_PLATNOSTI" ENABLE;
