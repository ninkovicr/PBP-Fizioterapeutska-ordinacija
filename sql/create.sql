-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`Zaposlen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Zaposlen`;

CREATE TABLE IF NOT EXISTS `mydb`.`Zaposlen` (
  `id` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fizioterapeut`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Fizioterapeut`;

CREATE TABLE IF NOT EXISTS `mydb`.`Fizioterapeut` (
  `datumZaposlenja` DATE NOT NULL,
  `idFizioterapeuta` INT NOT NULL,
  PRIMARY KEY (`idFizioterapeuta`),
  CONSTRAINT `fk_Fizioterapeut_Zaposlen1`
    FOREIGN KEY (`idFizioterapeuta`)
    REFERENCES `mydb`.`Zaposlen` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asistenat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Asistent`;

CREATE TABLE IF NOT EXISTS `mydb`.`Asistent` (
  `stepen` SMALLINT(1) NOT NULL,
  `idAsistenta` INT NOT NULL,
  PRIMARY KEY (`idAsistenta`),
  CONSTRAINT `fk_Asistenat_Zaposlen1`
    FOREIGN KEY (`idAsistenta`)
    REFERENCES `mydb`.`Zaposlen` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacijent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pacijent`;

CREATE TABLE IF NOT EXISTS `mydb`.`Pacijent` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `datumRodjenja` DATE NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terapija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Terapija`;

CREATE TABLE IF NOT EXISTS `mydb`.`Terapija` (
  `naziv` VARCHAR(25) NOT NULL,
  `vremeTrajanja` INT NOT NULL,
  `idFizioterapeuta` INT NOT NULL,
  PRIMARY KEY (`naziv`),
  INDEX `fk_Terapija_Fizioterapeut1_idx` (`idFizioterapeuta` ASC),
  CONSTRAINT `fk_Terapija_Fizioterapeut1`
    FOREIGN KEY (`idFizioterapeuta`)
    REFERENCES `mydb`.`Fizioterapeut` (`idFizioterapeuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sala`;

CREATE TABLE IF NOT EXISTS `mydb`.`Sala` (
  `broj` INT NOT NULL,
  `idAsistenta` INT NOT NULL,
  PRIMARY KEY (`broj`),
  INDEX `fk_Sala_Asistent1_idx` (`idAsistenta` ASC),
  CONSTRAINT `fk_Sala_Asistent1`
    FOREIGN KEY (`idAsistenta`)
    REFERENCES `mydb`.`Asistent` (`idAsistenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rasporedjena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Rasporedjena`;

CREATE TABLE IF NOT EXISTS `mydb`.`Rasporedjena` (
  `vremePocetka` TIME NOT NULL,
  `vremeKraja` TIME NOT NULL,
  `nazivTerapije` VARCHAR(25) NOT NULL,
  `brojSale` INT NOT NULL,
  PRIMARY KEY (`nazivTerapije`, `brojSale`),
  INDEX `fk_Rasporedjena_Sala1_idx` (`brojSale` ASC),
  CONSTRAINT `fk_Rasporedjena_Terapija1`
    FOREIGN KEY (`nazivTerapije`)
    REFERENCES `mydb`.`Terapija` (`naziv`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rasporedjena_Sala1`
    FOREIGN KEY (`brojSale`)
    REFERENCES `mydb`.`Sala` (`broj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sprava`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sprava`;

CREATE TABLE IF NOT EXISTS `mydb`.`Sprava` (
  `sifra` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sifra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sadrzaj`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sadrzaj`;

CREATE TABLE IF NOT EXISTS `mydb`.`Sadrzaj` (
  `kolicina` INT,
  `brojSale` INT NOT NULL,
  `sifraSprava` INT NOT NULL,
  PRIMARY KEY (`brojSale`, `sifraSprava`),
  INDEX `fk_Sadrzaj_Sprava1_idx` (`sifraSprava` ASC),
  CONSTRAINT `fk_Sadrzaj_Sala1`
    FOREIGN KEY (`brojSale`)
    REFERENCES `mydb`.`Sala` (`broj`),
  CONSTRAINT `fk_Sadrzaj_Sprava1`
    FOREIGN KEY (`sifraSprava`)
    REFERENCES `mydb`.`Sprava` (`sifra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zamena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Zamena`;

CREATE TABLE IF NOT EXISTS `mydb`.`Zamena` (
  `sifraSprave1` INT NOT NULL,
  `sifraSprave2` INT NOT NULL,
  PRIMARY KEY (`sifraSprave1`, `sifraSprave2`),
  INDEX `fk_Zamena_Sprava2_idx` (`sifraSprave2` ASC),
  CONSTRAINT `fk_Zamena_Sprava1`
    FOREIGN KEY (`sifraSprave1`)
    REFERENCES `mydb`.`Sprava` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zamena_Sprava2`
    FOREIGN KEY (`sifraSprave2`)
    REFERENCES `mydb`.`Sprava` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Nadredjen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Nadredjen`;

CREATE TABLE IF NOT EXISTS `mydb`.`Nadredjen` (
  `idFizioterapeuta` INT NOT NULL,
  `jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`idFizioterapeuta`, `jmbg`),
  INDEX `fk_Nadredjen_Pacijent1_idx` (`jmbg` ASC),
  CONSTRAINT `fk_Nadredjen_Fizioterapeut1`
    FOREIGN KEY (`idFizioterapeuta`)
    REFERENCES `mydb`.`Fizioterapeut` (`idFizioterapeuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nadredjen_Pacijent1`
    FOREIGN KEY (`jmbg`)
    REFERENCES `mydb`.`Pacijent` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Karton`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Karton`;

CREATE TABLE IF NOT EXISTS `mydb`.`Karton` (
  `jmbg` VARCHAR(13) NOT NULL,
  `rbrPosete` INT,
  `dijagnoza` VARCHAR(60) NOT NULL,
  `brTerapija` INT NOT NULL,
  `brUradjenih` INT NOT NULL,
  PRIMARY KEY (`jmbg`, `rbrPosete`),
  CONSTRAINT `fk_Karton_Pacijent1`
    FOREIGN KEY (`jmbg`)
    REFERENCES `mydb`.`Pacijent` (`jmbg`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
