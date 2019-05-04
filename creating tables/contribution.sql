CREATE TABLE ilayn_.contribution (
   idcontribution INT NOT NULL,
   idFam INT NULL,
   amount INT NULL,
   PRIMARY KEY (idcontribution),
    INDEX idFam_idx (idFam ASC) VISIBLE,
   CONSTRAINT idFam
     FOREIGN KEY (idFam)
     REFERENCES ilayn_.family (id)
     ON DELETE SET NULL
     ON UPDATE SET NULL);

