LOAD DATA
INFILE 'PATHkurzy_centra.unl'
INTO TABLE kurz_centra
FIELDS TERMINATED BY '|'
(
  ID_CENTRA,
ID_KURZ
)