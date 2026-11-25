LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/rozvrh_kurzov.unl'
INTO TABLE rozvrh_kurzy
FIELDS TERMINATED BY '|'
(
  ID_ROZVRHU,
ID_KURZ,
ID_MIESTNOSTI,
DATUM DATE "DD/MM/YYYY",
CAS_OD DATE "HH24:MI",
CAS_DO DATE "HH24:MI",
POZNAMKA NULLIF POZNAMKA=BLANKS
)