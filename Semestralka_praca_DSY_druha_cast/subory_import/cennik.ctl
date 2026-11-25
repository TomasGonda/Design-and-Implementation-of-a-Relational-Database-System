LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/cennik.unl'
INTO TABLE cennik
FIELDS TERMINATED BY '|'
(
  CENOVA_UROVEN,
CENA,
PLATNOST_OD DATE 'DD/MM/YYYY'
)