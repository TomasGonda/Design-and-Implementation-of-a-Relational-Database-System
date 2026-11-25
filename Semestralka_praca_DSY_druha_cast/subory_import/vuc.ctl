LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/vuc.unl'
INTO TABLE vyssi_uzemny_celok
FIELDS TERMINATED BY '|'
(
  ID_VUC,
  ID_UZEMIE,
  NAZOV_VUC
)