LOAD DATA
INFILE 'PATHzam_centra.unl'
INTO TABLE zamestnanec_centra
FIELDS TERMINATED BY '|'
(
 OS_CISLO,
ID_CENTRA,
JE_VEDUCI
)