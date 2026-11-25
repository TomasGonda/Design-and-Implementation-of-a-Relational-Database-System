LOAD DATA
INFILE 'D:/Desktop/databazy/Semestralka_cast_3/subory_import/zamestnanci.unl'
INTO TABLE zamestnanec
FIELDS TERMINATED BY '|'
(
  OS_CISLO,
  ROD_CISLO,
  POZICIA,
PRACOVNY_UVAZOK,
HODINOVA_MZDA
)