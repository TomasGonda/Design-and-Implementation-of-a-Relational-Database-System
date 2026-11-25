LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/osoba.unl'
INTO TABLE osoba
FIELDS TERMINATED BY '|'
(
  ROD_CISLO,
  PSC,
  MENO,
  PRIEZVISKO,
ADRESA,
KONTAKT,
POHLAVIE
)