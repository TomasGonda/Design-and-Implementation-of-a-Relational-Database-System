--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function JE_PRIHLASENY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MENO"."JE_PRIHLASENY" (
    m_os_cislo in char,
    m_id_kurz in char,
    m_id_centra in number
)
return number
is
    v_pocet number;
begin

    select count(*) into v_pocet from ucastnik_kurzy uk 
    join ucastnik_centra uc on uk.os_cislo = uc.os_cislo_ucastnik
    where uk.os_cislo = m_os_cislo
    and uk.id_kurz = m_id_kurz
    and uc.id_centra = m_id_centra
    and uk.dat_odhlasenia is null;

    return v_pocet;
end;

/
