insert into krajina (id_krajina, nazov_krajina) values (1, 'Slovensko');
insert into krajina (id_krajina, nazov_krajina) values (2, 'Cesko');

select * from krajina;
select * from uzemie;
select * from vyssi_uzemny_celok;
select * from obec;
select * from osoba;
select * from zamestnanec;
select * from centrum_vc;
select * from ucastnik_centra;
select * from kurz;
select * from zamestnanec_kurzy;
select * from ucastnik_kurzy;
select * from kurz;
select * from kurz_centra;
select * from cennik;
select * from miestnost;
select * from rozvrh_kurzy;
select * from zamestnanec_centra;

select * from kurz join kurz_centra using (id_kurz);
commit;

//TRIGGRE
//1 - Ked sa zmeni cena v cenniku pridanim alebo updatom, nadstavi sa aktualny datum ako datum platnosti_od
create or replace trigger trg_datum_platnosti
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

select * from cennik;

//Nadstavi novu cenu polozky, do datumu sa automaticky prida sysdate
update cennik set cena = 55 where cenova_uroven = 1;

//2 - ked datum odhlasenia v ucastnici kurzy je mensi ako datum prihlasenia vyhodi error
create or replace trigger trg_kontrola_prihlasenia
before insert or update on ucastnik_kurzy
for each row
begin
    if :new.dat_odhlasenia is not null and :new.dat_odhlasenia < :new.dat_zapisu then
        raise_application_error (-20001, 'Datum odhlasenia mensi ako datum prihlasenia');
    end if;
end;
/

select * from ucastnik_kurzy;

commit;
//Vyhodi error kedze datum prihlasenia je mensi ako datum zapisu;
update ucastnik_kurzy set dat_odhlasenia = TO_DATE('09/01/2025', 'DD/MM/YYYY') where os_cislo = '100001';

//PROCEDURA

//1 Pred prihlasenim ucastnika na kurz skontroluje, ci je na kurze miesto

create or replace procedure prihlas_na_kurz (
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

begin
    prihlas_na_kurz ('100020', 'K001', 1);
end;
/

//FUNKCIA

//1 Skontroluje, ci je ucastnik uz prihlaseny na dany kurz v danom centre; 
create or replace function je_prihlaseny (
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
//Test
select je_prihlaseny('100001', 'K001', 1) from dual;

//2 Procedura na kontrolu : Ci je ucastnik uz na dany kurz prihlaseny, ak ano, pozrie sa kapacita, ak je prihlasi ho to, ak nie je tak vyhodi chybu

create or replace procedure registracia_kurz (
    m_os_cislo in char,
    m_id_kurz in char,
    m_id_centra in number
)
is 
    v_existuje number;
begin
    
    //volanie funkcie
    v_existuje := je_prihlaseny (
        m_os_cislo,
        m_id_kurz,
        m_id_centra
    );
    
    //Volanie procedury na kontrolu kapacity
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

//Test
begin
    registracia_kurz('100001', 'K001', 1);
end;
/
//2 Funkcia ktory vrati pocet kurzov ucastnika
create or replace function pocet_kurzov (
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

//Test
select pocet_kurzov ('100001') from dual;

//Ku každému účastníkovi vypíšte koľko rôznych kurzov navštevoval v zadanom centre voľného času
select uk.os_cislo, count(distinct uk.id_kurz) as pocet_kurzov from ucastnik_kurzy uk 
    join ucastnik_centra uc on uk.os_cislo = uc.os_cislo_ucastnik 
    where uc.id_centra = 1 
    group by uk.os_cislo;
    
create or replace function pocet_kurzov_ucastnik (
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

select os_cislo_ucastnik, pocet_kurzov_ucastnik(os_cislo_ucastnik, 1)
 as pocet from ucastnik_centra;
 
//Vypíšte kurzy, na ktoré sú prihlásení minimálne 5 účastníci
create or replace view v_kurzy_s_min_5_ucastnikmi as
    select id_kurz, count(*) as pocet_ucastnikov from ucastnik_kurzy
        where dat_odhlasenia is null
        group by id_kurz
        having count(*) >= 5;
        
select * from v_kurzy_s_min_5_ucastnikmi;

//Ku každému kurzu v zadanom centre voľného času vypíšte jeho rozvrh 

/*select k.id_kurz, k.nazov_kurzu, r.datum, r.cas_od, r.cas_do, m.nazov as miestnost from kurz k 
    join kurz_centra kc on k.id_kurz = kc.id_kurz
    join rozvrh_kurzy r on r.id_kurz = k.id_kurz
    join miestnost m on r.id_miestnosti = m.id_miestnosti
    where kc.id_centra = 1
    order by k.id_kurz, r.datum, r.cas_od;*/

create or replace procedure vypis_rozvrh_centra (
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

set serveroutput on;

//Nepomenovany blok pre spustenie procedury
begin
    for centrum in (
        select id_centra, nazov_centra from centrum_vc
    )
    loop
        dbms_output.put_line (
            'Centrum: ' || centrum.nazov_centra || '   '
        );
        
        vypis_rozvrh_centra (centrum.id_centra);
        
        dbms_output.put_line (' ');
    end loop;
end;
/
    
//Pre každé centrum voľného času vypíšte počet aktuálne platných kurzov
create or replace view v_centrum_platne_kurzy as
    select c.id_centra, c.nazov_centra, count (distinct kc.id_kurz) as pocet_platnych_kurzov from centrum_vc c
        left join kurz_centra kc on c.id_centra = kc.id_centra
        left join rozvrh_kurzy r on kc.id_kurz = r.id_kurz
        where r.datum >= sysdate
        group by c.id_centra, c.nazov_centra
        order by c.id_centra;

select * from v_centrum_platne_kurzy;

//Pre zadané centrum voľného času vypíšte všetkých účastníkov spolu so sumou, ktorú doteraz zaplatili na jednotlivých kurzoch
select o.meno, o.priezvisko, sum(c.cena) as celkova_suma from osoba o 
    join ucastnik u on o.rod_cislo = u.rod_cislo
    join ucastnik_centra uc on u.os_cislo_ucastnik = uc.os_cislo_ucastnik
    join ucastnik_kurzy uk on u.os_cislo_ucastnik = uk.os_cislo
    join kurz k on uk.id_kurz = k.id_kurz
    join cennik c on k.cenova_uroven = c.cenova_uroven
    where uc.id_centra = 1
    group by o.meno, o.priezvisko
    order by sum(c.cena);

//Vypíšte účastníkov, ktorí nenavštevovali viac ako 2 centrá voľného času.
select o.meno, o.priezvisko, count (distinct uc.id_centra) as pocet_centier from osoba o
    join ucastnik u on o.rod_cislo = u.rod_cislo
    join ucastnik_centra uc on uc.os_cislo_ucastnik = u.os_cislo_ucastnik
    group by o.meno, o.priezvisko
    having count (distinct uc.id_centra) <= 2;

//Vypíšte lektorov, ktorí v zadanom centre voľného času nevyučovali viac ako 3 kurzy
select zk.os_cislo_zamestnanec, count (distinct zk.id_kurz) as pocet_kurzov from zamestnanec_kurzy zk
    join kurz k on zk.id_kurz = k.id_kurz
    join kurz_centra kc on k.id_kurz = zk.id_kurz
    where kc.id_centra = 1
    group by zk.os_cislo_zamestnanec
    having count (distinct zk.id_kurz) <= 3;

//Vypíšte kurzy, ktoré tento rok neboli otvorené z dôvodu nedostatočného počtu účastníkov (menej ako 3 prihlásení) v zadanom centre voľného času.
select k.id_kurz, k.nazov_kurzu, count (uk.os_cislo) as pocet_prihlasenych from kurz k 
    join kurz_centra kc on k.id_kurz = kc.id_kurz
    left join ucastnik_kurzy uk on k.id_kurz = uk.id_kurz
    where kc.id_centra = 1 and uk.dat_zapisu <= sysdate
    group by k.id_kurz, k.nazov_kurzu
    having count (uk.os_cislo) < 3;

//Vypíšte účastníkov, ktorí získali výborné hodnotenie z kurzov v zadanom centre voľného času.
select u.os_cislo_ucastnik, uk.hodnotenie from ucastnik u 
    join ucastnik_kurzy uk on uk.os_cislo = u.os_cislo_ucastnik
    join ucastnik_centra uc on uc.os_cislo_ucastnik = u.os_cislo_ucastnik
    where uc.id_centra = 1 and uk.hodnotenie = 1;
    
//Vypíšte detailné informácie o jednotlivých centrách voľného času spolu s lektormi, ktorí tam aktuálne vyučujú.
select * from centrum_vc join zamestnanec_centra using (id_centra) join zamestnanec using (os_cislo) where pozicia like 'Lektor%';

//Vypíšte účastníkov, ktorí sa odhlásili z kurzu do troch dní od prihlásenia
select os_cislo, id_kurz, dat_zapisu, dat_odhlasenia from ucastnik_kurzy where dat_odhlasenia is not null and dat_odhlasenia <= dat_zapisu + 3;

//Vypíšte lektorov, ktorí doteraz neboli účastníkmi žiadneho kurzu
select os_cislo, rod_cislo, pozicia from zamestnanec z where pozicia like 'Lektor%' and not exists (
    select 'x' from zamestnanec_kurzy zk where zk.os_cislo_zamestnanec = z.os_cislo
);

declare
    cursor c_lektori is 
        select os_cislo, rod_cislo, pozicia from zamestnanec
        where pozicia like 'Lektor%';
    
    v_pocet number;
begin
    for l in c_lektori loop
        select count(*) into v_pocet from zamestnanec_kurzy
        where os_cislo_zamestnanec = l.os_cislo;
        
        if v_pocet = 0 then
            dbms_output.put_line (
                'Lektor bez kurzu : ' || l.os_cislo || ' | ' || l.pozicia
            );
        end if;
    end loop;
end;
/
set serveroutput on;


//Vypíšte všetky kurzy v zadanom centre voľného času, ktoré sa nikdy nekonali v piatok

//Vypíšte informácie o centrách voľného času, ktoré ponúkajú kurz anglického jazyka pre začiatočníkov
select c.id_centra, c.nazov_centra, c.adresa, c.kontakt from centrum_vc c
    join kurz_centra kc on c.id_centra = kc.id_centra
    join kurz k on kc.id_kurz = k.id_kurz
    where k.nazov_kurzu like '%Anglictina%';

//Vypíšte kurzy, ktorých cena je menšia ako 100€
select k.id_kurz, k.nazov_kurzu, c.cena from kurz k join cennik c on k.cenova_uroven = c.cenova_uroven where c.cena < 100;

//Ku každému centru voľného času vypíšte percentuálny pomer žien a mužov, ktorí centrum navštevovali.

//SEKVENCIE
select max(id_krajina) from krajina;
select max(id_uzemie) from uzemie;
select max(id_vuc) from vyssi_uzemny_celok;
select max(psc) from obec;
select * from miestnost;

create sequence s_krajina
    start with 3
    increment by 1;
    
create sequence s_uzemie
    start with 11
    increment by 1;
    
create sequence s_vuc
    start with 11
    increment by 1;
    
create or replace trigger trg_psc
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

create or replace trigger trg_rc
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

create sequence s_zamestnanec
    start with 500011
    increment by 1
    minvalue 500000
    maxvalue 799999
    cycle;

create sequence s_centra_vc
    start with 15
    increment by 1;
    
create sequence s_ucastnik
    start with 100011
    increment by 1
    minvalue 100000
    maxvalue 499999
    cycle;

create sequence s_kurz
    start with 00001
    increment by 1;
    
create or replace trigger trg_kurz
before insert on kurz
for each row
begin
    :new.id_kurz := 'K' || lpad(s_kurz.nextval, 5, '0');
end;
/

create sequence s_rozvrh
    start with 6
    increment by 1;
    
create sequence s_miestnost
    start with 006
    increment by 1;
    
create or replace trigger trg_miestnost
before insert on miestnost
for each row
begin
    :new.id_miestnosti := 'M' || lpad(s_miestnost.nextval, 3, '0');
end;
/

create sequence s_cennik
    start with 5
    increment by 1;
    
commit;


//TESTY
update ucastnik_kurzy set dat_odhlasenia = TO_DATE('09/01/2025', 'DD/MM/YYYY') where os_cislo = '100001';

begin
    prihlas_na_kurz ('100020', 'K001', 1);
end;
/

select je_prihlaseny('100001', 'K001', 1) from dual;

begin
    registracia_kurz('100001', 'K001', 1);
end;
/

select pocet_kurzov ('100001') from dual;