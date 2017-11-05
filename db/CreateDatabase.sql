-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mass-shootings
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mass-shootings` ;

-- -----------------------------------------------------
-- Schema mass-shootings
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mass-shootings` DEFAULT CHARACTER SET utf8 ;
USE `mass-shootings` ;

-- -----------------------------------------------------
-- Table `mass-shootings`.`Locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mass-shootings`.`Locations` ;

CREATE TABLE IF NOT EXISTS `mass-shootings`.`Locations` (
  `id` INT NOT NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Latitude` DECIMAL(10,8) NULL,
  `Lognitude` DECIMAL(11,8) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mass-shootings`.`Incidents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mass-shootings`.`Incidents` ;

CREATE TABLE IF NOT EXISTS `mass-shootings`.`Incidents` (
  `id` INT NOT NULL,
  `Title` VARCHAR(45) NULL,
  `Date` DATE NULL,
  `Summary` VARCHAR(160) NULL,
  `Injured` INT NULL,
  `Fatalities` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `LocationId`
    FOREIGN KEY (`id`)
    REFERENCES `mass-shootings`.`Locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mass-shootings`.`Attackers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mass-shootings`.`Attackers` ;

CREATE TABLE IF NOT EXISTS `mass-shootings`.`Attackers` (
  `id` INT NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `LastName` VARCHAR(50) NULL,
  `Age` INT NULL,
  `Sex` ENUM('M', 'F', 'UNKNOWN') NULL DEFAULT 'UNKNOWN',
  `MentalHealthIssues` ENUM('YES', 'NO', 'UNCLEAR', 'UNKNOWN') NULL DEFAULT 'UNKNOWN',
  `Race` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `IncidentId`
    FOREIGN KEY (`id`)
    REFERENCES `mass-shootings`.`Incidents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mass-shootings`.`Victims`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mass-shootings`.`Victims` ;

CREATE TABLE IF NOT EXISTS `mass-shootings`.`Victims` (
  `id` INT NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `LastName` VARCHAR(50) NULL,
  `Sex` VARCHAR(15) NULL,
  `Status` ENUM('I', 'F', 'UNKNOWN') NULL DEFAULT 'UNKNOWN',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `IncidentId`
    FOREIGN KEY (`id`)
    REFERENCES `mass-shootings`.`Incidents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mass-shootings`.`Races`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mass-shootings`.`Races` ;

CREATE TABLE IF NOT EXISTS `mass-shootings`.`Races` (
  `id` INT NOT NULL,
  `RaceName` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `AttackerId`
    FOREIGN KEY (`id`)
    REFERENCES `mass-shootings`.`Attackers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
