--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_RC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "GONDA1"."TRG_RC" 
before insert or update on osoba
for each row
declare
    v_pocet number;
begin
    select count(*) into v_pocet from osoba where rod_cislo = :new.rod_cislo and (:old.rod_cislo is null or rod_cislo <> :old.rod_cislo);

    if v_pocet > 0 then 
        raise_application_error (-20001, 'Rodne cislo uz existuje');
    end if;
end;

/
ALTER TRIGGER "GONDA1"."TRG_RC" ENABLE;
