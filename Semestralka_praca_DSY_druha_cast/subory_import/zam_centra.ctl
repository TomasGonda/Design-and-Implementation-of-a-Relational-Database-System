LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/zam_centra.unl'
INTO TABLE zamestnanec_centra
FIELDS TERMINATED BY '|'
(
 OS_CISLO,
ID_CENTRA,
JE_VEDUCI
)