LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/kurzy.unl'
INTO TABLE kurz
FIELDS TERMINATED BY '|'
(
  ID_KURZ,
CENOVA_UROVEN,
NAZOV_KURZU,
KAPACITA_KURZU
)