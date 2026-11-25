--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function POCET_KURZOV_UCASTNIK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MENO"."POCET_KURZOV_UCASTNIK" (
    m_os_cislo in varchar2,
    m_id_centra in number
)
return number
is 
v_pocet number;
begin
    select count(distinct uk.id_kurz) into v_pocet from ucastnik_kurzy uk
    join kurz k on k.id_kurz = uk.id_kurz
    join ucastnik_centra uc on uk.os_cislo = uc.os_cislo_ucastnik
    where uk.os_cislo = m_os_cislo and uc.id_centra = m_id_centra;
    return v_pocet;
end;

/
