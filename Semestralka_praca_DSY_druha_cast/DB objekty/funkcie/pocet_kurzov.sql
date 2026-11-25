--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function POCET_KURZOV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MENO"."POCET_KURZOV" (
    m_os_cislo in char
)
return number
is
    v_pocet number;
begin
select count(*) into v_pocet from ucastnik_kurzy where os_cislo = m_os_cislo and dat_odhlasenia is null;
return v_pocet;
end;

/
