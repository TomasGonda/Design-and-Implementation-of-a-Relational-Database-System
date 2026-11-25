LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/obec.unl'
INTO TABLE obec
FIELDS TERMINATED BY '|'
(
  PSC,
  ID_VUC,
  NAZOV_OBCE,
  CAST_OBCE
)