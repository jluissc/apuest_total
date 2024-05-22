-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_apuesta_total
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_apuesta_total
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_apuesta_total` DEFAULT CHARACTER SET utf8 ;
USE `bd_apuesta_total` ;

-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_pat` VARCHAR(45) NOT NULL,
  `last_mat` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT NOT NULL,
  `type_doc` INT NULL,
  `num_doc` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profile` VARCHAR(45) NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`employed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`employed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `names` VARCHAR(45) NOT NULL,
  `last_pat` VARCHAR(45) NOT NULL,
  `last_mat` VARCHAR(45) NOT NULL,
  `type_doc` INT NOT NULL,
  `num_doc` INT NOT NULL,
  `status` TINYINT NOT NULL,
  `profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employed_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_employed_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `bd_apuesta_total`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`channel_attention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`channel_attention` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client_pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client_pay` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `amount` DECIMAL(11,2) NOT NULL,
  `day` DATE NOT NULL,
  `hour` TIME NOT NULL,
  `url_img` VARCHAR(100) NOT NULL,
  `flag` TINYINT NOT NULL,
  `employed_id` INT NOT NULL,
  `channel_attention_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_pay_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_client_pay_employed1_idx` (`employed_id` ASC) VISIBLE,
  INDEX `fk_client_pay_channel_attention1_idx` (`channel_attention_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_pay_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `bd_apuesta_total`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_pay_employed1`
    FOREIGN KEY (`employed_id`)
    REFERENCES `bd_apuesta_total`.`employed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_pay_channel_attention1`
    FOREIGN KEY (`channel_attention_id`)
    REFERENCES `bd_apuesta_total`.`channel_attention` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client_pay_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client_pay_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NULL,
  `amount` DECIMAL(11,2) NULL,
  `day` DATE NULL,
  `hour` TIME NULL,
  `url_img` VARCHAR(100) NULL,
  `employed_id` INT NULL,
  `channel_attention_id` INT NULL,
  `flag` TINYINT NULL,
  `type_log` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
