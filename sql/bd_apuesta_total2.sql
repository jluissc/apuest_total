-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bd_apuesta_total
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_apuesta_total
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_apuesta_total` DEFAULT CHARACTER SET utf8mb4 ;
USE `bd_apuesta_total` ;

-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`channel_attention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`channel_attention` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `channel` VARCHAR(45) NOT NULL,
  `flag` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client` (
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
-- Table `bd_apuesta_total`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`profile` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `profile` VARCHAR(45) NOT NULL,
  `status` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`employed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`employed` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `names` VARCHAR(45) NOT NULL,
  `last_pat` VARCHAR(45) NOT NULL,
  `last_mat` VARCHAR(45) NOT NULL,
  `type_doc` INT(11) NOT NULL,
  `num_doc` INT(11) NOT NULL,
  `status` TINYINT(4) NOT NULL,
  `profile_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `profile_id` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `employed_ibfk_1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `bd_apuesta_total`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`bank` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bank` VARCHAR(45) NOT NULL,
  `flag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client_pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client_pay` (
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
  INDEX `client_id` (`client_id` ASC) VISIBLE,
  INDEX `employed_id` (`employed_id` ASC) VISIBLE,
  INDEX `channel_attention_id` (`channel_attention_id` ASC) VISIBLE,
  INDEX `fk_client_pay_bank1_idx` (`bank_id` ASC) VISIBLE,
  CONSTRAINT `client_pay_ibfk_1`
    FOREIGN KEY (`client_id`)
    REFERENCES `bd_apuesta_total`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_pay_ibfk_2`
    FOREIGN KEY (`employed_id`)
    REFERENCES `bd_apuesta_total`.`employed` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_pay_ibfk_3`
    FOREIGN KEY (`channel_attention_id`)
    REFERENCES `bd_apuesta_total`.`channel_attention` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_pay_bank1`
    FOREIGN KEY (`bank_id`)
    REFERENCES `bd_apuesta_total`.`bank` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`client_pay_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`client_pay_log` (
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
-- Table `bd_apuesta_total`.`pay_modify`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`pay_modify` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `client_pay_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pay_modify_client_pay1_idx` (`client_pay_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_modify_client_pay1`
    FOREIGN KEY (`client_pay_id`)
    REFERENCES `bd_apuesta_total`.`client_pay` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_apuesta_total`.`modification_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_apuesta_total`.`modification_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `modification_type` VARCHAR(45) NOT NULL,
  `flag` TINYINT NOT NULL,
  `pay_modify_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_modification_type_pay_modify1_idx` (`pay_modify_id` ASC) VISIBLE,
  CONSTRAINT `fk_modification_type_pay_modify1`
    FOREIGN KEY (`pay_modify_id`)
    REFERENCES `bd_apuesta_total`.`pay_modify` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bd_apuesta_total` ;

-- -----------------------------------------------------
-- procedure clientPayData
-- -----------------------------------------------------

DELIMITER $$
USE `bd_apuesta_total`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientPayData`(IN `client_id` INT)
BEGIN
     IF client_id = 0 THEN
        SELECT cp.id, c.id as id_client, cp.amount, c.player_id, c.name, c.last_pat, c.last_mat, cp.day, cp.hour, ca.channel, e.names, cp.bank 
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id;
    ELSE
        SELECT cp.id, c.id as id_client, cp.amount, c.player_id, c.name, c.last_pat, c.last_mat, cp.day, cp.hour, ca.channel, e.names, cp.bank 
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id
        WHERE c.id = client_id;
    END IF;
    END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
