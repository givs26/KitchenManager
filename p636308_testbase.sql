-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: p636308.mysql.ihc.ru
-- Generation Time: Jan 17, 2024 at 12:36 PM
-- Server version: 5.7.42-45-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `p636308_cherk`
--


DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `deleteOrder`$$
CREATE DEFINER=`p636308_cherk`@`%` PROCEDURE `deleteOrder` (IN `id_order` INT)   BEGIN
DELETE FROM orders_inside WHERE orders_inside.id_orders = id_order;
DELETE from Orders WHERE Orders.id_order = id_order;
END$$


DROP PROCEDURE IF EXISTS `Update_Order_Inside`$$
CREATE DEFINER=`p636308_cherk`@`%` PROCEDURE `Update_Order_Inside` (IN `id_orders_inside_par` INT, IN `qty_orders_inside_par` INT, IN `id_orders_par` INT, IN `products_orders_inside_par` INT)   BEGIN
IF qty_orders_inside_par = 0 THEN
  BEGIN
   DELETE FROM `orders_inside` WHERE `orders_inside`.`id_orders_inside` = id_orders_inside_par;
  END;
ELSE
BEGIN
    IF (SELECT count(*) FROM `orders_inside` WHERE( `orders_inside`.`products_orders_inside` = products_orders_inside_par) AND (`orders_inside`.`id_orders_inside` =id_orders_inside_par))>0 THEN
      BEGIN
       UPDATE `orders_inside` SET `orders_inside`.`qty_orders_inside` = qty_orders_inside_par WHERE (`orders_inside`.`id_orders` = id_orders_par) AND (`orders_inside`.`id_orders_inside` = id_orders_inside_par);
      END;
    ELSE 
      BEGIN
       INSERT INTO `orders_inside` (`orders_inside`.`id_orders`, `orders_inside`.`products_orders_inside`, `orders_inside`.`qty_orders_inside`) VALUES (id_orders_par, products_orders_inside_par, qty_orders_inside_par);
      END;
    END IF;
END;
END IF;
END$$

DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
