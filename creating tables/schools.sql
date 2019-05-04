CREATE TABLE ilayn_.schools (
   idschools INT NOT NULL,
   idFamily INT NOT NULL,
   schoolname VARCHAR(45) NOT NULL,
   location VARCHAR(45) NULL,
   level VARCHAR(45) NULL,
   PRIMARY KEY (idschools));
   
ALTER TABLE ilayn_.schools 
 ADD CONSTRAINT idFamily
   FOREIGN KEY (idFamily)
   REFERENCES ilayn_.family (id)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION;
   