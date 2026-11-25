--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PRIHLAS_NA_KURZ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "GONDA1"."PRIHLAS_NA_KURZ" (
    m_os_cislo in char,
    m_id_kurz in char,
    m_id_centra in number
)
is
    v_kapacita number;
    v_pocet number;
begin
    select kapacita_kurzu into v_kapacita from kurz where id_kurz = m_id_kurz;

    select count(*) into v_pocet from ucastnik_kurzy uk 
    join ucastnik_centra uc on uk.os_cislo = uc.os_cislo_ucastnik
    where uk.id_kurz = m_id_kurz
    and uc.id_centra = m_id_centra
    and uk.dat_odhlasenia is null;

    if v_pocet >= v_kapacita then
        raise_application_error (-20002, 'Kurz v danom centre je uz plny');
    end if;

    insert into ucastnik_kurzy (
        os_cislo,
        id_kurz,
        dat_zapisu,
        dat_odhlasenia,
        hodnotenie,
        absolvovany
    ) values (
        m_os_cislo,
        m_id_kurz,
        sysdate,
        null,
        0,
        'N'
    );
end;

/
