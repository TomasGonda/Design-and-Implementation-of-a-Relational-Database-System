--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure REGISTRACIA_KURZ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MENO"."REGISTRACIA_KURZ" (
    m_os_cislo in char,
    m_id_kurz in char,
    m_id_centra in number
)
is 
    v_existuje number;
begin

    v_existuje := je_prihlaseny (
        m_os_cislo,
        m_id_kurz,
        m_id_centra
    );

    if v_existuje > 0 then
        raise_application_error (-20003, 'Ucastnik je na dany kurz uz prihlaseny');
    else
        prihlas_na_kurz(
        m_os_cislo,
        m_id_kurz,
        m_id_centra
    );
    end if;
end;

/
