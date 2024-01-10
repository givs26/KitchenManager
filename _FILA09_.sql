-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: p636308.mysql.ihc.ru
-- Generation Time: Jan 09, 2024 at 12:31 PM
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
-- Database: `p636308_testbase`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`p636308_testbase`@`%` PROCEDURE `SelectOrder` (IN `id_order` INT)   BEGIN
SELECT * FROM Orders WHERE Orders.id_order = id_order;
END$$

CREATE DEFINER=`p636308_testbase`@`%` PROCEDURE `SetStatusOrder` (IN `id_order` INT UNSIGNED, IN `id_status` INT UNSIGNED)   UPDATE Orders SET Orders.id_status = id_status WHERE Orders.id_order = id_order$$

CREATE DEFINER=`p636308_testbase`@`%` PROCEDURE `SetStatusSendSMS` (IN `id_sendsms` INT, IN `status_sendsms` INT)   BEGIN
UPDATE SendSMS SET SendSMS.status_sendsms = status_sendsms WHERE SendSMS.id_sendsms = id_sendsms;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Banners`
--

CREATE TABLE `Banners` (
  `id_banners` int(11) NOT NULL,
  `pic_banners` text NOT NULL,
  `desc_banners` text NOT NULL,
  `title_banners` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Group_meal`
--

CREATE TABLE `Group_meal` (
  `id_group` int(11) NOT NULL,
  `name_group` varchar(200) DEFAULT NULL,
  `disc_group` text,
  `pic_group` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Group_meal`
--

INSERT INTO `Group_meal` (`id_group`, `name_group`, `disc_group`, `pic_group`) VALUES
(12, 'Сеты', 'Сеты', 'pic/set.png'),
(13, 'Пицца', 'Пицца', 'pic/Pizza.png'),
(14, 'Роллы', 'Роллы', 'pic/Rolls_group.png'),
(15, 'Запеченные роллы', 'Запеченные роллы', 'pic/Zap_group.png'),
(16, 'Жаренные роллы', 'Жаренные роллы', 'pic/gar_groups.png'),
(25, 'Горячее и закуски', 'Горячее и закуски', 'pic/gor_i_zak_group.png'),
(26, 'Напитки', 'Напитки', 'pic/group-beverage.png');

-- --------------------------------------------------------

--
-- Table structure for table `Meal`
--

CREATE TABLE `Meal` (
  `id_meal` int(11) NOT NULL,
  `id_group` int(11) NOT NULL,
  `name_meal` varchar(200) NOT NULL,
  `disc_meal` text NOT NULL,
  `price_meal` float NOT NULL,
  `pic_meal` text,
  `weight_meal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Meal`
--

INSERT INTO `Meal` (`id_meal`, `id_group`, `name_meal`, `disc_meal`, `price_meal`, `pic_meal`, `weight_meal`) VALUES
(21, 13, 'Пицца четыре сыра', 'Белый фирменный соус, сыр Моцарелла, сыр пармезан, Гарганзола, сыр Гауда', 499, 'pic/IMG_4488.png', 0),
(22, 13, 'Пицца Маргарита', 'Красный соус, розовые помидоры, сыр моцарелла, сыр Гауда', 399, 'pic/IMG_4461.png', 0),
(23, 13, 'Пицца Мясная', 'Красный соус, сыр моцарелла, сыр, Гауда, колбаса пепперони, индейка, куриное феле', 555, 'pic/IMG_4481.png', 0),
(24, 13, 'Пицца Цезарь', 'Белый фирменный соус, сыр Гауда, сыр моцарелла, лист салата, черри, сыр пармезан, куриное филе', 490, 'pic/IMG_4514.png', 0),
(25, 13, 'Пицца Пепперони', 'Красный соус, колбаса пепперони, сыр моцарелла, сыр Гауда, халапенью (по желанию)', 484, 'pic/pepperoni.png', 0),
(26, 13, 'Пицца курица грибы', 'Белый соус, куриное филе, шампиньоны, сыр моцарелла, Гауда, прованские травы', 475, 'pic/IMG_4472.png', 0),
(28, 15, 'Филадельфия запеченная', 'Рис, сыр, креметта, лосось, огурец, соус спайси', 480, 'pic/DSC_0010.jpeg', 0),
(29, 16, 'НОТ ролл', 'Рис, нори, сыр креметта, окунь, авокадо, соус краги, кунжут', 399, 'pic/DSC_0183.jpeg', 0),
(30, 16, 'Жаренный лосось', 'Рис, нори, сыр креметта, лосось, огурец', 374, 'pic/DSC_0264.jpeg', 0),
(32, 16, 'Сакура', 'Рис, нори, сыр креметта, креветки, лосось, паназиатский соус', 378, 'pic/DSC_0321.jpeg', 0),
(36, 26, 'Добрый Cola', 'Напиток Добрый Cola 1 л', 130, 'pic/Cola.png', 0),
(37, 25, 'Сливочный Том-ям', 'Бульон Том-ям, мидии, креветки, куриная грудка, кинза, черри, кунжут', 520, 'pic/DSC_0159.jpeg', 0),
(44, 16, 'Темпура краб', 'Рис, нори, сыр креметта, снежный краб, авакадо', 350, 'pic/DSC_0205.jpeg', 0),
(45, 16, 'Цезарь ролл', 'Рис, нори, сыр креметта, лист салата, курица, соус цезарь, пармезан', 410, 'pic/DSC_0224.jpeg', 0),
(46, 16, 'Okun сяке', 'Рис, сыр креметта, лосось, окунь, соус black чилли, кунжут', 350, 'pic/DSC_0294.jpeg', 0),
(47, 16, 'Эби темпура маки', 'Рис, сыр креметта, креветки, огурец, икра летучей рыбы', 390, 'pic/DSC_0281.jpeg', 0),
(48, 16, 'Унаги темпура', 'Рис, нори, сыр креметта, угорь, авокадо, унаги соус, кунжут', 420, 'pic/DSC_0247.jpeg', 0),
(49, 15, 'Ронин', 'Рис, нори, сыр креметта, пекинская капуста, креветки, соус йоси, соус унаги', 499, 'pic/DSC_0476.jpeg', 0),
(50, 15, 'Канада запеченная', 'Рис, сыр креметта, угорь, авокадо, кунжут, такуат, соус спайси, соус black чилли', 460, 'pic/DSC_0526.jpeg', 0),
(51, 15, 'Запеченный с креветкой', 'Рис, нори, сыр креметта, огурец, спайси креветка, соус унаги', 389, 'pic/DSC_0545.jpeg', 0),
(52, 15, 'Запеченный с мидиями', 'Рис, нори, сыр креметта, огурец, мидии, соус спайси', 389, 'pic/DSC_0549.jpeg', 0),
(53, 15, 'Горячий самурай', 'Рис, нори, сыр креметта, креветка, лосось, кунжут, сырная шапка', 150, 'pic/DSC_0034.jpeg', 0),
(54, 15, 'Дыхание дракона', 'Рис, сыр креметта, угорь, авокадо, кунжут, сыр моцарелла, соус спайси', 440, 'pic/DSC_0053.jpeg', 0),
(55, 15, 'Запеченный с лососем', 'Рис, нори, сыр креметта, огурец, спайси лосось', 380, 'pic/DSC_0076.jpeg', 0),
(56, 15, 'Запеченный с угрем', 'Рис, нори, сыр креметта, спайси шапка угорь', 390, 'pic/DSC_0103.jpeg', 0),
(57, 14, 'Канада', 'Рис, нори, сыр креметта, авокадо, угорь, такуан, унаги соус, кунжут', 440, 'pic/DSC_0322.jpeg', 0),
(58, 14, 'Авакадо маки', 'Рис, сыр креметта, креветка, авокадо, огурец, соус унаги, кунжут', 420, 'pic/DSC_0426.jpeg', 0),
(59, 14, 'Сливочный лосось', 'Рис, сыр креметта, лосось, авокадо, соус унаги, кунжут', 429, 'pic/DSC_0460.jpeg', 0),
(60, 14, 'Эби токио', 'Рис, нори, сыр креметта, авокадо, креветки, соус лемонграсс', 499, 'pic/DSC_0437.jpeg', 0),
(61, 14, 'Тамаго ролл', 'Рис, нори, сыр креметта, огурец, жаренный окунь, икра лосося', 389, 'pic/DSC_0389.jpeg', 0),
(62, 14, 'Филадельфия классик', 'Рис, нори, сыр креметта, огурец, лосось', 460, 'pic/DSC_0355.jpeg', 0),
(63, 14, 'Филадельфия лайт', 'Рис, сыр креметта, лосось, авокадо, икра лосося', 480, 'pic/DSC_0269.jpeg', 0),
(64, 14, 'Калифорния снежный краб', 'Рис, огурец, авокадо, снежный краб, икра летучей рыбы', 360, 'pic/DSC_0379.jpeg', 0),
(65, 14, 'Калифорний с лососем', 'Рис, нори, сыр креметта, огурец, авокадо, лосось, икра летучей рыбы', 390, 'pic/DSC_0278.jpeg', 0),
(66, 14, 'Калифорния с креветкой', 'Рис, нори, сыр креметта, огурец, авокадо, креветка, икра летучей рыбы', 399, 'pic/DSC_0301.jpeg', 0),
(67, 13, 'Пицца Том-ям', 'Фирменный соус Том-ям, лосось, креветки, мидии, сыр Моцарелла, сыр Гауда, хлопья чили', 690, 'pic/IMG_4443.png', 0),
(68, 25, 'Креветки темпура', 'с паназиатским соусом', 390, 'pic/DSC_0113.jpeg', 0),
(69, 26, 'Добрый Cola', 'Добрый Cola 0.5 л', 80, 'pic/Cola.png', 0),
(70, 26, 'Сок апельсиновый Я', 'Сок апельсиновый 0,97л', 170, 'pic/SOK_ya_orange.png', 0),
(71, 12, 'Сет FILA', 'Филадельфия Лайт, Запеченная Филадельфия, Дыхание дракона, Авокадо маки, Унаги темпура                                                 40 шт', 1890, 'pic/', 0),
(72, 12, 'Сет Любимый', 'Жаренный лосось, Темпура краб, Эби темпура маки, Ронин, Okun сяке                                                        40 шт', 1649, 'pic/', 0),
(73, 12, 'Запеченный сет', 'Запеченный с креветкой, Запеченный с мидиями, Дыхание дракона, Запеченный с угрем, Филадельфия запеченная                                                    40 шт', 1750, 'pic/', 0),
(74, 12, 'Биг сет', 'Филадельфия классик, эби Токио, Горячий самурай, Запеченный с лососем, Сакура, Цезарь ролл + Пицца Курица-грибы                                                                    48шт + пицца', 2420, 'pic/', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Notification`
--

CREATE TABLE `Notification` (
  `id_notification` int(11) NOT NULL,
  `text_notification` text NOT NULL,
  `date_notification` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `id_order` int(11) NOT NULL,
  `delivery_order` text NOT NULL,
  `tel_order` text NOT NULL,
  `adress_order` text NOT NULL,
  `price_order` text NOT NULL,
  `products_order` text NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`id_order`, `delivery_order`, `tel_order`, `adress_order`, `price_order`, `products_order`, `id_status`) VALUES
(141, 'Доставка', '+79624470374', 'Тестовый 2', '860', 'Канада кол-во: 1 Сумма: 440Авакадо маки кол-во: 1 Сумма: 420', 0);

-- --------------------------------------------------------

--
-- Table structure for table `SendSMS`
--

CREATE TABLE `SendSMS` (
  `id_sendsms` int(11) NOT NULL,
  `tel_semdsms` text NOT NULL,
  `text_sendsms` text NOT NULL,
  `status_sendsms` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `SendSMS`
--

INSERT INTO `SendSMS` (`id_sendsms`, `tel_semdsms`, `text_sendsms`, `status_sendsms`) VALUES
(1, '+79624470374', 'Testovoe SMS', 1),
(2, '+79624424287', 'Test Sms', 1),
(3, '+79624470374', '45y45', 1),
(4, '+7965786245', '3225', 1),
(5, '+79624424287', '3767', 1),
(6, '5623', '7389', 1),
(7, '432', '6465', 1),
(8, '432', '1852', 1),
(9, '432', '6978', 1),
(10, '44', '9806', 1),
(11, '555', '2261', 1),
(12, 'undefined', '2090', 1),
(13, 'undefined', '1706', 1),
(14, 'undefined', '4520', 1),
(15, '5456', '7402', 1),
(16, '412', '3008', 1),
(17, 'undefined', '2077', 1),
(18, 'undefined', '2646', 1),
(19, '545', '3272', 1),
(20, '5645', '8408', 1),
(21, 'undefined', '2005', 1),
(22, '432432', '9972', 1),
(23, '89624470374', '4477', 1),
(24, '89624470374', '6341', 1),
(25, '214', '9511', 1),
(26, '8962444444', '965', 1),
(27, '43124134', '8451', 1),
(28, '8313353', '2408', 1),
(29, '432432', '4614', 1),
(30, '546', '4457', 1),
(31, '525', '8102', 1),
(32, '896245525525rrrr', '780', 1),
(33, 'dq5w555', '8427', 1),
(34, '8', '28', 1),
(35, '89656528585', '5419', 1),
(36, '89659658585', '8514', 1),
(37, '89659658585', '7135', 1),
(38, '89659658585', '1645', 1),
(39, '89658595858', '7837', 1),
(40, '89658595858', '9945', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Settings`
--

CREATE TABLE `Settings` (
  `id_settings` int(11) NOT NULL,
  `adress_settings` text NOT NULL,
  `tel_settings` text NOT NULL,
  `price_delivery_settings` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Settings`
--

INSERT INTO `Settings` (`id_settings`, `adress_settings`, `tel_settings`, `price_delivery_settings`) VALUES
(1, ' г. Черкесск, Проспект Ленина, 59а', '79990288999', 150);

-- --------------------------------------------------------

--
-- Table structure for table `Status_order`
--

CREATE TABLE `Status_order` (
  `id_status` int(11) NOT NULL,
  `name_status` text NOT NULL,
  `color_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Status_order`
--

INSERT INTO `Status_order` (`id_status`, `name_status`, `color_status`) VALUES
(0, 'Получен', 'red'),
(2, 'На оформлении', 'green'),
(3, 'В работе', 'blue');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Pass` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `Username`, `Pass`) VALUES
(1, 'root', 'StrongPass');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Banners`
--
ALTER TABLE `Banners`
  ADD PRIMARY KEY (`id_banners`);

--
-- Indexes for table `Group_meal`
--
ALTER TABLE `Group_meal`
  ADD PRIMARY KEY (`id_group`);

--
-- Indexes for table `Meal`
--
ALTER TABLE `Meal`
  ADD PRIMARY KEY (`id_meal`);

--
-- Indexes for table `Notification`
--
ALTER TABLE `Notification`
  ADD PRIMARY KEY (`id_notification`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`id_order`);

--
-- Indexes for table `SendSMS`
--
ALTER TABLE `SendSMS`
  ADD PRIMARY KEY (`id_sendsms`);

--
-- Indexes for table `Settings`
--
ALTER TABLE `Settings`
  ADD PRIMARY KEY (`id_settings`);

--
-- Indexes for table `Status_order`
--
ALTER TABLE `Status_order`
  ADD PRIMARY KEY (`id_status`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Banners`
--
ALTER TABLE `Banners`
  MODIFY `id_banners` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Group_meal`
--
ALTER TABLE `Group_meal`
  MODIFY `id_group` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `Meal`
--
ALTER TABLE `Meal`
  MODIFY `id_meal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `Notification`
--
ALTER TABLE `Notification`
  MODIFY `id_notification` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `SendSMS`
--
ALTER TABLE `SendSMS`
  MODIFY `id_sendsms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Settings`
--
ALTER TABLE `Settings`
  MODIFY `id_settings` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Status_order`
--
ALTER TABLE `Status_order`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
