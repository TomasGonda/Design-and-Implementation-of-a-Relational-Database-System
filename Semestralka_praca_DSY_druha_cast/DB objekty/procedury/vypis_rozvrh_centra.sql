--------------------------------------------------------
--  File created - nedeľa-mája-10-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure VYPIS_ROZVRH_CENTRA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "GONDA1"."VYPIS_ROZVRH_CENTRA" (
m_id_centra in number
)
is
begin
    for zaznam in (
        select k.id_kurz, k.nazov_kurzu, r.datum, r.cas_od, r.cas_do, m.nazov as miestnost from kurz k 
            join kurz_centra kc on k.id_kurz = kc.id_kurz
            join rozvrh_kurzy r on r.id_kurz = k.id_kurz
            join miestnost m on r.id_miestnosti = m.id_miestnosti
            where kc.id_centra = m_id_centra
            order by k.id_kurz, r.datum, r.cas_od
    )
    loop
        dbms_output.put_line (
            'Kurz: ' || zaznam.nazov_kurzu ||
            ' | Datum: ' || zaznam.datum ||
            ' | Cas: ' || zaznam.cas_od || ' - ' || zaznam.cas_do ||
            ' | Miestnost: ' || zaznam.miestnost
        );
    end loop;
end;

/
