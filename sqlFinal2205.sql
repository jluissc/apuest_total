


-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************
-- ******************************


-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bdapt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdapt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdapt` DEFAULT CHARACTER SET utf8mb4 ;
USE `bdapt` ;

-- -----------------------------------------------------
-- Table `bdapt`.`channel_attention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`channel_attention` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `channel` VARCHAR(45) NOT NULL,
  `flag` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`client` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_pat` VARCHAR(45) NOT NULL,
  `last_mat` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(4) NOT NULL,
  `type_doc` INT(11) NULL DEFAULT NULL,
  `num_doc` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`profile` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `profile` VARCHAR(45) NOT NULL,
  `status` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`employed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`employed` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `names` VARCHAR(45) NOT NULL,
  `last_pat` VARCHAR(45) NOT NULL,
  `last_mat` VARCHAR(45) NOT NULL,
  `type_doc` INT(11) NOT NULL,
  `num_doc` INT(11) NOT NULL,
  `status` TINYINT(4) NOT NULL,
  `profile_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`profile_id`)
    REFERENCES `bdapt`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`bank` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bank` VARCHAR(45) NOT NULL,
  `flag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdapt`.`client_pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`client_pay` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `amount` DECIMAL(11,2) NOT NULL,
  `day` DATE NOT NULL,
  `hour` TIME NOT NULL,
  `url_img` VARCHAR(100) NOT NULL,
  `flag` TINYINT(4) NOT NULL,
  `employed_id` INT(11) NOT NULL,
  `channel_attention_id` INT(11) NOT NULL,
  `bank_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`client_id`)
    REFERENCES `bdapt`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`employed_id`)
    REFERENCES `bdapt`.`employed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`channel_attention_id`)
    REFERENCES `bdapt`.`channel_attention` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`bank_id`)
    REFERENCES `bdapt`.`bank` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`client_pay_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`client_pay_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NULL DEFAULT NULL,
  `amount` DECIMAL(11,2) NULL DEFAULT NULL,
  `day` DATE NULL DEFAULT NULL,
  `hour` TIME NULL DEFAULT NULL,
  `url_img` VARCHAR(100) NULL DEFAULT NULL,
  `employed_id` INT(11) NULL DEFAULT NULL,
  `channel_attention_id` INT(11) NULL DEFAULT NULL,
  `flag` TINYINT(4) NULL DEFAULT NULL,
  `bank_id` INT NULL,
  `type_log` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdapt`.`modification_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`modification_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `modification_type` VARCHAR(45) NOT NULL,
  `flag` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdapt`.`pay_modify`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdapt`.`pay_modify` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `client_pay_id` INT(11) NOT NULL,
  `modification_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`client_pay_id`)
    REFERENCES `bdapt`.`client_pay` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`modification_type_id`)
    REFERENCES `bdapt`.`modification_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bdapt` ;

-- -----------------------------------------------------
-- procedure clientPayData
-- -----------------------------------------------------

DELIMITER $$
USE `bdapt`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientPayData`(IN `client_id` INT)
BEGIN
     IF client_id = 0 THEN
        SELECT cp.id, c.id as id_client, cp.amount, c.player_id, c.name, c.last_pat, c.last_mat, cp.day, cp.hour, ca.channel, e.names, b.bank 
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id
        LEFT JOIN bank b ON b.id = cp.bank_id;
    ELSE
        SELECT cp.id, c.id as id_client, cp.amount, c.player_id, c.name, c.last_pat, c.last_mat, cp.day, cp.hour, ca.channel, e.names, b.bank 
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id
        LEFT JOIN bank b ON b.id = cp.bank_id
        WHERE c.id = client_id;
    END IF;
    END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
