--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_PSC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MENO"."TRG_PSC" 
before insert or update on obec
for each row
declare
    v_pocet number;
begin
    select count(*) into v_pocet from obec where PSC = :new.PSC and (:old.PSC is null or PSC <> :old.PSC);

    if v_pocet > 0 then 
        raise_application_error (-20001, 'PSC uz existuje');
    end if;
end;

/
ALTER TRIGGER "MENO"."TRG_PSC" ENABLE;
