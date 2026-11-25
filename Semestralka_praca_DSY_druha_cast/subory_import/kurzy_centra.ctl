LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/kurzy_centra.unl'
INTO TABLE kurz_centra
FIELDS TERMINATED BY '|'
(
  ID_CENTRA,
ID_KURZ
)