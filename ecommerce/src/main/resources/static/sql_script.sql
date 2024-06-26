-- MySQL Script generated by MySQL Workbench
-- Thu May 30 13:59:39 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nest_ecom
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nest_ecom` ;

-- -----------------------------------------------------
-- Schema nest_ecom
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nest_ecom` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `nest_ecom` ;


-- -----------------------------------------------------
-- Table `attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `attribute` (
  `uuid_attribute` VARCHAR(40) NOT NULL,
  `key` VARCHAR(40) NULL DEFAULT NULL,
  `created_date` TIMESTAMP NULL DEFAULT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_attribute`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user` (
  `uuid_user` VARCHAR(40) NOT NULL,
  `uuid_cart` VARCHAR(40) NOT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `avatar` VARCHAR(200) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `password` VARCHAR(32) NOT NULL,
  `register_date` TIMESTAMP NOT NULL,
  `last_login` TIMESTAMP NULL DEFAULT NULL,
  `activate` SMALLINT NULL DEFAULT '0',
  PRIMARY KEY (`uuid_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_cart` ON `user` (`uuid_cart` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brand` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `brand` (
  `uuid_brand` VARCHAR(40) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `created_date` TIMESTAMP NULL DEFAULT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  `uuid_user` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`uuid_brand`),
  CONSTRAINT `user_brand_uuid_user_fk`
    FOREIGN KEY (`uuid_user`)
    REFERENCES `user` (`uuid_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;




SHOW WARNINGS;
-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `product` (
  `uuid_product` VARCHAR(40) NOT NULL,
  `title` VARCHAR(75) NOT NULL,
  `meta_title` VARCHAR(100) NULL DEFAULT NULL,
  `summary` TEXT NULL DEFAULT NULL,
  `type` SMALLINT NOT NULL DEFAULT '0',
  `price` DOUBLE NOT NULL DEFAULT '0',
  `quantity` SMALLINT NOT NULL DEFAULT '0',
  `created_date` TIMESTAMP NOT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  `published_date` TIMESTAMP NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `uuid_brand` VARCHAR(40) NOT NULL,
	PRIMARY KEY(`uuid_product`),
	CONSTRAINT `product_brand_uuid_brand_fk`
    FOREIGN KEY (`uuid_brand`)
    REFERENCES `brand` (`uuid_brand`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `cart_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cart_item` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cart_item` (
  `uuid_cart` VARCHAR(40) NOT NULL,
  `uuid_product` VARCHAR(40) NOT NULL,
  `price` DOUBLE NOT NULL DEFAULT '0',
  `discount` DOUBLE NOT NULL DEFAULT '0',
  `quantity` SMALLINT NOT NULL DEFAULT '0',
  `active` SMALLINT NOT NULL DEFAULT '0',
  `content` TEXT NULL DEFAULT NULL,
  `created_date` TIMESTAMP NOT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_cart`, `uuid_product`),
  CONSTRAINT `cart_item_fk_user_cart`
    FOREIGN KEY (`uuid_cart`)
    REFERENCES `user` (`uuid_cart`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_product_UNIQUE` ON `cart_item` (`uuid_product` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_cart_UNIQUE` ON `cart_item` (`uuid_cart` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `category` (
  `uuid_category` VARCHAR(40) NOT NULL,
  `title` VARCHAR(75) NOT NULL,
  `meta_title` VARCHAR(100) NULL DEFAULT NULL,
  `slug` VARCHAR(100) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_category`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `order` (
  `uuid_order` VARCHAR(40) NOT NULL,
  `user_id` VARCHAR(40) NULL DEFAULT NULL,
  `session_id` VARCHAR(100) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  `status` SMALLINT NOT NULL DEFAULT '0',
  `subtotal` DOUBLE NOT NULL DEFAULT '0',
  `item_discount` DOUBLE NOT NULL DEFAULT '0',
  `tax` DOUBLE NOT NULL DEFAULT '0',
  `shipping` DOUBLE NOT NULL DEFAULT '0',
  `total` DOUBLE NOT NULL DEFAULT '0',
  `promo` VARCHAR(50) NULL DEFAULT NULL,
  `discount` DOUBLE NOT NULL DEFAULT '0',
  `grand_total` DOUBLE NOT NULL DEFAULT '0',
  `created_date` TIMESTAMP NOT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  `payment_methods` VARCHAR(10) NULL DEFAULT NULL,
  `note` TEXT NULL DEFAULT NULL,
  `address_ship` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_order`),
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`uuid_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `user_id` ON `order` (`user_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_item` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `order_item` (
  `uuid_order_item` VARCHAR(40) NOT NULL,
  `uuid_product` VARCHAR(40) NOT NULL,
  `uuid_order` VARCHAR(40) NOT NULL,
  `price` DOUBLE NOT NULL DEFAULT '0',
  `discount` DOUBLE NOT NULL DEFAULT '0',
  `quantity` SMALLINT NOT NULL DEFAULT '0',
  `created_date` TIMESTAMP NOT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_order_item`),
  CONSTRAINT `order_item_ibfk_1`
    FOREIGN KEY (`uuid_product`)
    REFERENCES `product` (`uuid_product`),
  CONSTRAINT `order_item_ibfk_2`
    FOREIGN KEY (`uuid_order`)
    REFERENCES `order` (`uuid_order`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `uuid_product` ON `order_item` (`uuid_product` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `uuid_order` ON `order_item` (`uuid_order` ASC) VISIBLE;

SHOW WARNINGS;



SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `product_attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_attribute` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `product_attribute` (
  `uuid_attribute` VARCHAR(40) NOT NULL,
  `uuid_product` VARCHAR(40) NOT NULL,
  `value` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_product`, `uuid_attribute`),
  CONSTRAINT `fk_product_attribute_product1`
    FOREIGN KEY (`uuid_product`)
    REFERENCES `product` (`uuid_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_attribute_attribute1`
    FOREIGN KEY (`uuid_attribute`)
    REFERENCES `attribute` (`uuid_attribute`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_attribute` ON `product_attribute` (`uuid_attribute` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_product` ON `product_attribute` (`uuid_product` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `product_category` (
  `uuid_product` VARCHAR(40) NOT NULL,
  `uuid_category` VARCHAR(40) NOT NULL,
  CONSTRAINT `fk_pc_category`
    FOREIGN KEY (`uuid_category`)
    REFERENCES `category` (`uuid_category`),
  CONSTRAINT `fk_pc_product`
    FOREIGN KEY (`uuid_product`)
    REFERENCES `product` (`uuid_product`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_product` ON `product_category` (`uuid_product` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uuid_category` ON `product_category` (`uuid_category` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `product_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_review` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `product_review` (
  `uuid_product_review` VARCHAR(40) NOT NULL,
  `uuid_product` VARCHAR(40) NOT NULL,
  `uuid_user` VARCHAR(40) NOT NULL,
  `uuid_parent_product_review` VARCHAR(40) NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `title` VARCHAR(100) NOT NULL,
  `rating` SMALLINT NOT NULL DEFAULT '0',
  `published` SMALLINT NOT NULL DEFAULT '0',
  `created_date` TIMESTAMP NOT NULL,
  `updated_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_product_review`),
  CONSTRAINT `product_review_ibfk_1`
    FOREIGN KEY (`uuid_product`)
    REFERENCES `product` (`uuid_product`),
  CONSTRAINT `product_review_ibfk_2`
    FOREIGN KEY (`uuid_parent_product_review`)
    REFERENCES `product_review` (`uuid_product_review`),
  CONSTRAINT `fk_product_review_user1`
    FOREIGN KEY (`uuid_user`)
    REFERENCES `user` (`uuid_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `uuid_parent_product_review` ON `product_review` (`uuid_parent_product_review` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_product_review_user1_idx` ON `product_review` (`uuid_user` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `role` (
  `uuid_role` VARCHAR(40) NOT NULL,
  `name` INT NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_role`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;



SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_address` (
  `uuid_address` VARCHAR(40) NOT NULL,
  `uuid_user` VARCHAR(40) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `street` VARCHAR(255) NULL DEFAULT NULL,
  `district` VARCHAR(255) NULL DEFAULT NULL,
  `postal_code` INT NULL DEFAULT NULL,
  PRIMARY KEY (`uuid_address`),
  CONSTRAINT `user_address_ibfk_1`
    FOREIGN KEY (`uuid_user`)
    REFERENCES `user` (`uuid_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `uuid_user` ON `user_address` (`uuid_user` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_role` (
  `uuid_user` VARCHAR(40) NOT NULL,
  `uuid_role` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`uuid_role`, `uuid_user`),
  CONSTRAINT `fk_user_role_user1`
    FOREIGN KEY (`uuid_user`)
    REFERENCES `user` (`uuid_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role_role1`
    FOREIGN KEY (`uuid_role`)
    REFERENCES `role` (`uuid_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `user_role_pk` ON `user_role` (`uuid_user` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `user_role_pk_2` ON `user_role` (`uuid_role` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
