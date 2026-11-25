LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/miestnost.unl'
INTO TABLE miestnost
FIELDS TERMINATED BY '|'
(
  ID_MIESTNOSTI,
KAPACITA,
NAZOV
)