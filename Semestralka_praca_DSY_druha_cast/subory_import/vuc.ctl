LOAD DATA
INFILE 'PATHvuc.unl'
INTO TABLE vyssi_uzemny_celok
FIELDS TERMINATED BY '|'
(
  ID_VUC,
  ID_UZEMIE,
  NAZOV_VUC
)