LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/uzemie.unl'
INTO TABLE uzemie
FIELDS TERMINATED BY '|'
(
  ID_UZEMIE,
  ID_KRAJINA,
  NAZOV_UZEMIA
)