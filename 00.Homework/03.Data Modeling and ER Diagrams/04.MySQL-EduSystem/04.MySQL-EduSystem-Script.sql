SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `educationsystem` DEFAULT CHARACTER SET utf8 ;
USE `educationsystem` ;

-- -----------------------------------------------------
-- Table `educationsystem`.`Faculties`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Faculties` (
  `Id` INT NOT NULL AUTO_INCREMENT ,
  `Name` VARCHAR(45) NOT NULL ,
  `UniversityId` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `idFaculties_UNIQUE` (`Id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`Departments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Departments` (
  `Id` INT NOT NULL AUTO_INCREMENT ,
  `FacultyId` INT NOT NULL ,
  `Name` VARCHAR(45) NOT NULL ,
  `Courses_id` INT NOT NULL ,
  `Faculties_Id` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  INDEX `fk_Departments_Courses1_idx` (`Courses_id` ASC) ,
  INDEX `fk_Departments_Faculties1_idx` (`Faculties_Id` ASC) ,
  CONSTRAINT `fk_Departments_Courses1`
    FOREIGN KEY (`Courses_id` )
    REFERENCES `educationsystem`.`Courses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departments_Faculties1`
    FOREIGN KEY (`Faculties_Id` )
    REFERENCES `educationsystem`.`Faculties` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`Professor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Professor` (
  `Id` INT NOT NULL AUTO_INCREMENT ,
  `Professorcol` VARCHAR(45) NOT NULL ,
  `DepartmentId` INT NOT NULL ,
  `Departments_Id` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  INDEX `fk_Professor_Departments1_idx` (`Departments_Id` ASC) ,
  CONSTRAINT `fk_Professor_Departments1`
    FOREIGN KEY (`Departments_Id` )
    REFERENCES `educationsystem`.`Departments` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`Courses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Courses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `CourseName` VARCHAR(45) NOT NULL ,
  `DepartmentId` INT NOT NULL ,
  `ProfessorId` INT NOT NULL ,
  `Professor_Id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Courses_Professor1_idx` (`Professor_Id` ASC) ,
  CONSTRAINT `fk_Courses_Professor1`
    FOREIGN KEY (`Professor_Id` )
    REFERENCES `educationsystem`.`Professor` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`Student`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Student` (
  `Id` INT NOT NULL AUTO_INCREMENT ,
  `Name` VARCHAR(45) NOT NULL ,
  `CourseId` INT NOT NULL ,
  `Courses_id` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  INDEX `fk_Student_Courses_idx` (`Courses_id` ASC) ,
  CONSTRAINT `fk_Student_Courses`
    FOREIGN KEY (`Courses_id` )
    REFERENCES `educationsystem`.`Courses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`ProfessorTitle`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`ProfessorTitle` (
  `ProfessorId` INT NOT NULL AUTO_INCREMENT ,
  `TitleName` VARCHAR(45) NOT NULL ,
  `Professor_Id` INT NOT NULL ,
  PRIMARY KEY (`ProfessorId`) ,
  UNIQUE INDEX `ProfessorId_UNIQUE` (`ProfessorId` ASC) ,
  INDEX `fk_ProfessorTitle_Professor1_idx` (`Professor_Id` ASC) ,
  CONSTRAINT `fk_ProfessorTitle_Professor1`
    FOREIGN KEY (`Professor_Id` )
    REFERENCES `educationsystem`.`Professor` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `educationsystem`.`Universities`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `educationsystem`.`Universities` (
  `Id` INT NOT NULL AUTO_INCREMENT ,
  `Name` VARCHAR(45) NOT NULL ,
  `Faculties_Id` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  INDEX `fk_Universities_Faculties1_idx` (`Faculties_Id` ASC) ,
  CONSTRAINT `fk_Universities_Faculties1`
    FOREIGN KEY (`Faculties_Id` )
    REFERENCES `educationsystem`.`Faculties` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `educationsystem` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
