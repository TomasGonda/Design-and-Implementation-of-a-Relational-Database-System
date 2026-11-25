--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_KONTROLA_PRIHLASENIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MENO"."TRG_KONTROLA_PRIHLASENIA" 
before insert or update on ucastnik_kurzy
for each row
begin
    if :new.dat_odhlasenia is not null and :new.dat_odhlasenia < :new.dat_zapisu then
        raise_application_error (-20001, 'Datum odhlasenia mensi ako datum prihlasenia');
    end if;
end;

/
ALTER TRIGGER "MENO"."TRG_KONTROLA_PRIHLASENIA" ENABLE;
