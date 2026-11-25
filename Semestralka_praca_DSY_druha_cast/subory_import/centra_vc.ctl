LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/centra_vc.unl'
INTO TABLE centrum_vc
FIELDS TERMINATED BY '|'
(
  ID_CENTRA,
PSC,
NAZOV_CENTRA,
ADRESA,
KONTAKT
)