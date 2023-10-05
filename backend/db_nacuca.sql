-- MySQL Script generated by MySQL Workbench
-- Thu Oct  5 19:32:02 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`md_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`md_type` (
  `tpsUuid` VARCHAR(128) NOT NULL,
  `tpsName` VARCHAR(60) NOT NULL,
  `tpsDescription` VARCHAR(45) NULL,
  `tpsIsDisabled` TINYINT(1) NOT NULL DEFAULT 0,
  `tpsCreatedAt` DATETIME NOT NULL,
  `tpsModifiedAt` DATETIME NULL,
  PRIMARY KEY (`tpsUuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`md_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`md_user` (
  `usrUuid` VARCHAR(128) NOT NULL,
  `usrName` VARCHAR(100) NOT NULL,
  `usrEmail` VARCHAR(100) NOT NULL,
  `usrPassword` VARCHAR(128) NOT NULL,
  `usrContact` VARCHAR(14) NOT NULL,
  `usrCpf` VARCHAR(11) NOT NULL,
  `usrBirth` DATE NOT NULL,
  `tps_Uuid` VARCHAR(128) NOT NULL,
  `usrIsDisabled` TINYINT(1) GENERATED ALWAYS AS (0) VIRTUAL,
  `usrCreatedAt` DATETIME NOT NULL,
  `usrModifiedAt` DATETIME NULL,
  PRIMARY KEY (`usrUuid`, `tps_Uuid`),
  UNIQUE INDEX `usrEmail_UNIQUE` (`usrEmail` ASC) VISIBLE,
  UNIQUE INDEX `usrCpf_UNIQUE` (`usrCpf` ASC) VISIBLE,
  UNIQUE INDEX `usrUuid_UNIQUE` (`usrUuid` ASC) VISIBLE,
  INDEX `fk_md_user_md_type1_idx` (`tps_Uuid` ASC) VISIBLE,
  CONSTRAINT `fk_md_user_md_type1`
    FOREIGN KEY (`tps_Uuid`)
    REFERENCES `mydb`.`md_type` (`tpsUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`md_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`md_category` (
  `catUuid` VARCHAR(128) NOT NULL,
  `catName` VARCHAR(80) NOT NULL,
  `catDescription` VARCHAR(150) NULL,
  `catIsDisabled` TINYINT(1) NOT NULL DEFAULT 0,
  `catCreatedAt` DATETIME NOT NULL,
  `catModifiedAt` DATETIME NULL,
  `md_categorycol` VARCHAR(45) NULL,
  PRIMARY KEY (`catUuid`),
  UNIQUE INDEX `catUuid_UNIQUE` (`catUuid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`md_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`md_course` (
  `crsUuid` VARCHAR(128) NOT NULL,
  `crsName` VARCHAR(100) NOT NULL,
  `crsDescription` VARCHAR(45) NULL,
  `crsImage` VARCHAR(250) NULL DEFAULT NULL,
  `crsDate` DATE NOT NULL,
  `crsHour` TIME NOT NULL,
  `crsRecurrency` INT NOT NULL,
  `crsRating` INT NULL DEFAULT NULL,
  `usr_Uuid` VARCHAR(128) NOT NULL,
  `cat_Uuid` VARCHAR(128) NOT NULL,
  `crsIsDisabled` TINYINT(1) NOT NULL DEFAULT 0,
  `crsCreatedAt` DATETIME NOT NULL,
  `crsModifiedAt` DATETIME NULL,
  PRIMARY KEY (`crsUuid`, `usr_Uuid`, `cat_Uuid`),
  UNIQUE INDEX `crsUuid_UNIQUE` (`crsUuid` ASC) VISIBLE,
  INDEX `fk_md_course_md_user_idx` (`usr_Uuid` ASC) VISIBLE,
  INDEX `fk_md_course_md_category1_idx` (`cat_Uuid` ASC) VISIBLE,
  CONSTRAINT `fk_md_course_md_user`
    FOREIGN KEY (`usr_Uuid`)
    REFERENCES `mydb`.`md_user` (`usrUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_md_course_md_category1`
    FOREIGN KEY (`cat_Uuid`)
    REFERENCES `mydb`.`md_category` (`catUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ev_courseComment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ev_courseComment` (
  `cmtUuid` VARCHAR(128) NOT NULL,
  `cmtComment` TEXT NOT NULL,
  `cmtCreatedAt` DATETIME NOT NULL,
  `usr_Uuid` VARCHAR(128) NOT NULL,
  `crs_Uuid` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`cmtUuid`, `usr_Uuid`, `crs_Uuid`),
  INDEX `fk_md_user_has_md_course_md_course1_idx` (`crs_Uuid` ASC) VISIBLE,
  INDEX `fk_md_user_has_md_course_md_user1_idx` (`usr_Uuid` ASC) VISIBLE,
  UNIQUE INDEX `cmtUuid_UNIQUE` (`cmtUuid` ASC) VISIBLE,
  CONSTRAINT `fk_md_user_has_md_course_md_user1`
    FOREIGN KEY (`usr_Uuid`)
    REFERENCES `mydb`.`md_user` (`usrUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_md_user_has_md_course_md_course1`
    FOREIGN KEY (`crs_Uuid`)
    REFERENCES `mydb`.`md_course` (`crsUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`md_newslatter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`md_newslatter` (
  `nltUuid` VARCHAR(128) NOT NULL,
  `nltEmail` VARCHAR(100) NOT NULL,
  `nltIsDisabled` TINYINT(1) NOT NULL DEFAULT 0,
  `nltCreatedAt` DATETIME NOT NULL,
  `nltModifiedAt` DATETIME NULL,
  `md_newslattercol` VARCHAR(45) NULL,
  PRIMARY KEY (`nltUuid`),
  UNIQUE INDEX `nltUuid_UNIQUE` (`nltUuid` ASC) VISIBLE,
  UNIQUE INDEX `nltEmail_UNIQUE` (`nltEmail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ev_forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ev_forum` (
  `frmUuid` VARCHAR(128) NOT NULL,
  `frmTitle` VARCHAR(100) NOT NULL,
  `frmDescription` TEXT NULL,
  `frmIsClosed` TINYINT(1) NOT NULL DEFAULT 0,
  `frmIsDisabled` TINYINT(1) NOT NULL DEFAULT 0,
  `cat_Uuid` VARCHAR(128) NOT NULL,
  `frmCreatedAt` DATETIME NOT NULL,
  `frmModifiedAt` DATETIME NULL,
  PRIMARY KEY (`frmUuid`, `cat_Uuid`),
  UNIQUE INDEX `frmUuid_UNIQUE` (`frmUuid` ASC) VISIBLE,
  INDEX `fk_ev_forum_md_category1_idx` (`cat_Uuid` ASC) VISIBLE,
  CONSTRAINT `fk_ev_forum_md_category1`
    FOREIGN KEY (`cat_Uuid`)
    REFERENCES `mydb`.`md_category` (`catUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ev_forumComment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ev_forumComment` (
  `fcmUuid` VARCHAR(128) NOT NULL,
  `fcmComment` TEXT NOT NULL,
  `fcmCreatedAt` DATETIME NOT NULL,
  `usr_Uuid` VARCHAR(128) NOT NULL,
  `frm_Uuid` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`fcmUuid`, `usr_Uuid`, `frm_Uuid`),
  INDEX `fk_md_user_has_ev_forum_ev_forum1_idx` (`frm_Uuid` ASC) VISIBLE,
  INDEX `fk_md_user_has_ev_forum_md_user1_idx` (`usr_Uuid` ASC) VISIBLE,
  UNIQUE INDEX `fcmUuid_UNIQUE` (`fcmUuid` ASC) VISIBLE,
  CONSTRAINT `fk_md_user_has_ev_forum_md_user1`
    FOREIGN KEY (`usr_Uuid`)
    REFERENCES `mydb`.`md_user` (`usrUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_md_user_has_ev_forum_ev_forum1`
    FOREIGN KEY (`frm_Uuid`)
    REFERENCES `mydb`.`ev_forum` (`frmUuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
