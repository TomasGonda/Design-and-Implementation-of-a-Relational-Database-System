LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/zam_kurzy.unl'
INTO TABLE zamestnanec_kurzy
FIELDS TERMINATED BY '|'
(
OS_CISLO_ZAMESTNANEC,
ID_KURZ,
JE_VEDUCI
)