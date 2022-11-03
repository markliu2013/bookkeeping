-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Oct 28, 2022 at 01:27 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookkeeping`
--

--
-- Dumping data for table `t_account`
--

INSERT INTO `t_account` (`type`, `id`, `enable`, `name`, `notes`, `balance`, `currency_code`, `expenseable`, `include`, `incomeable`, `initial_balance`, `no`, `transfer_from_able`, `transfer_to_able`, `bill_day`, `credit_limit`, `as_of_date`, `apr`, `group_id`) VALUES
(1, 1, b'1', '现金', NULL, '990.00', 'CNY', b'1', b'1', b'1', '1000.00', NULL, b'1', b'1', NULL, NULL, NULL, NULL, 1);

--
-- Dumping data for table `t_balance_flow`
--

INSERT INTO `t_balance_flow` (`type`, `id`, `amount`, `converted_amount`, `create_time`, `description`, `notes`, `status`, `book_id`, `account_id`, `creator_id`, `group_id`, `payee_id`, `to_id`) VALUES
(1, 1, '10.00', '10.00', 1666920219045, NULL, NULL, 1, 1, 1, 1, 1, NULL, NULL);

--
-- Dumping data for table `t_book`
--

INSERT INTO `t_book` (`id`, `enable`, `name`, `notes`, `description_enable`, `image_enable`, `time_enable`, `default_expense_account_id`, `default_expense_category_id`, `default_income_account_id`, `default_income_category_id`, `default_transfer_from_account_id`, `default_transfer_to_account_id`, `group_id`) VALUES
(1, b'1', '默认账本', NULL, b'1', b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, 1);

--
-- Dumping data for table `t_category`
--

INSERT INTO `t_category` (`type`, `id`, `enable`, `name`, `notes`, `level`, `book_id`, `parent_id`) VALUES
(1, 1, b'1', '支出分类1', NULL, 0, 1, NULL),
(1, 2, b'1', '支出分类2', NULL, 0, 1, NULL),
(2, 3, b'1', '收入分类1', NULL, 0, 1, NULL),
(2, 4, b'1', '收入分类2', NULL, 0, 1, NULL);

--
-- Dumping data for table `t_category_relation`
--

INSERT INTO `t_category_relation` (`id`, `amount`, `converted_amount`, `category_id`, `deal_id`) VALUES
(1, '10.00', '10.00', 1, 1);

--
-- Dumping data for table `t_currency`
--

INSERT INTO `t_currency` (`id`, `code`, `description`, `rate`) VALUES
(1, 'AED', 'United Arab Emirates Dirham', '3.67'),
(2, 'AFN', 'Afghan Afghani', '89.63'),
(3, 'ALL', 'Albanian Lek', '114.56'),
(4, 'AMD', 'Armenian Dram', '431.03'),
(5, 'ANG', 'Netherlands Antillean Guilder', '1.82'),
(6, 'AOA', 'Angolan Kwanza', '435.61'),
(7, 'ARS', 'Argentine Peso', '122.70'),
(8, 'AUD', 'Australian Dollar', '1.42'),
(9, 'AWG', 'Aruban Florin', '1.80'),
(10, 'AZN', 'Azerbaijani Manat', '1.70'),
(11, 'BAM', 'Bosnia-Herzegovina Convertible Mark', '1.87'),
(12, 'BBD', 'Barbadian Dollar', '2.00'),
(13, 'BDT', 'Bangladeshi Taka', '93.90'),
(14, 'BGN', 'Bulgarian Lev', '1.86'),
(15, 'BHD', 'Bahraini Dinar', '0.38'),
(16, 'BIF', 'Burundian Franc', '2076.58'),
(17, 'BMD', 'Bermudan Dollar', '1.00'),
(18, 'BND', 'Brunei Dollar', '1.39'),
(19, 'BOB', 'Bolivian Boliviano', '6.95'),
(20, 'BRL', 'Brazilian Real', '4.98'),
(21, 'BSD', 'Bahamian Dollar', '1.00'),
(22, 'BTC', 'Bitcoin', '0.00'),
(23, 'BTN', 'Bhutanese Ngultrum', '78.56'),
(24, 'BWP', 'Botswanan Pula', '12.19'),
(25, 'BYN', 'Belarusian Ruble', '3.41'),
(26, 'BZD', 'Belize Dollar', '2.04'),
(27, 'CAD', 'Canadian Dollar', '1.28'),
(28, 'CDF', 'Congolese Franc', '2019.70'),
(29, 'CHF', 'Swiss Franc', '0.99'),
(30, 'CLF', 'Chilean Unit of Account (UF)', '0.03'),
(31, 'CLP', 'Chilean Peso', '844.22'),
(32, 'CNH', 'Chinese Yuan (Offshore)', '6.75'),
(33, 'CNY', 'Chinese Yuan', '6.73'),
(34, 'COP', 'Colombian Peso', '3887.61'),
(35, 'CRC', 'Costa Rican Colón', '693.32'),
(36, 'CUC', 'Cuban Convertible Peso', '1.00'),
(37, 'CUP', 'Cuban Peso', '25.74'),
(38, 'CVE', 'Cape Verdean Escudo', '105.22'),
(39, 'CZK', 'Czech Republic Koruna', '23.53'),
(40, 'DJF', 'Djiboutian Franc', '179.77'),
(41, 'DKK', 'Danish Krone', '7.09'),
(42, 'DOP', 'Dominican Peso', '55.54'),
(43, 'DZD', 'Algerian Dinar', '146.45'),
(44, 'EGP', 'Egyptian Pound', '18.88'),
(45, 'ERN', 'Eritrean Nakfa', '14.99'),
(46, 'ETB', 'Ethiopian Birr', '52.53'),
(47, 'EUR', 'Euro', '0.95'),
(48, 'FJD', 'Fijian Dollar', '2.18'),
(49, 'FKP', 'Falkland Islands Pound', '0.81'),
(50, 'GBP', 'British Pound Sterling', '0.81'),
(51, 'GEL', 'Georgian Lari', '2.91'),
(52, 'GGP', 'Guernsey Pound', '0.81'),
(53, 'GHS', 'Ghanaian Cedi', '8.00'),
(54, 'GIP', 'Gibraltar Pound', '0.81'),
(55, 'GMD', 'Gambian Dalasi', '54.02'),
(56, 'GNF', 'Guinean Franc', '8938.62'),
(57, 'GTQ', 'Guatemalan Quetzal', '7.80'),
(58, 'GYD', 'Guyanaese Dollar', '211.39'),
(59, 'HKD', 'Hong Kong Dollar', '7.85'),
(60, 'HNL', 'Honduran Lempira', '24.81'),
(61, 'HRK', 'Croatian Kuna', '7.17'),
(62, 'HTG', 'Haitian Gourde', '115.62'),
(63, 'HUF', 'Hungarian Forint', '379.32'),
(64, 'IDR', 'Indonesian Rupiah', '14668.43'),
(65, 'ILS', 'Israeli New Sheqel', '3.41'),
(66, 'IMP', 'Manx pound', '0.81'),
(67, 'INR', 'Indian Rupee', '78.19'),
(68, 'IQD', 'Iraqi Dinar', '1473.89'),
(69, 'IRR', 'Iranian Rial', '42329.25'),
(70, 'ISK', 'Icelandic Króna', '132.16'),
(71, 'JEP', 'Jersey Pound', '0.81'),
(72, 'JMD', 'Jamaican Dollar', '154.87'),
(73, 'JOD', 'Jordanian Dinar', '0.71'),
(74, 'JPY', 'Japanese Yen', '134.95'),
(75, 'KES', 'Kenyan Shilling', '118.20'),
(76, 'KGS', 'Kyrgystani Som', '79.47'),
(77, 'KHR', 'Cambodian Riel', '4101.51'),
(78, 'KMF', 'Comorian Franc', '468.02'),
(79, 'KPW', 'North Korean Won', '899.56'),
(80, 'KRW', 'South Korean Won', '1284.43'),
(81, 'KWD', 'Kuwaiti Dinar', '0.31'),
(82, 'KYD', 'Cayman Islands Dollar', '0.84'),
(83, 'KZT', 'Kazakhstani Tenge', '440.52'),
(84, 'LAK', 'Laotian Kip', '14536.13'),
(85, 'LBP', 'Lebanese Pound', '1526.93'),
(86, 'LKR', 'Sri Lankan Rupee', '362.01'),
(87, 'LRD', 'Liberian Dollar', '151.93'),
(88, 'LSL', 'Lesotho Loti', '15.75'),
(89, 'LYD', 'Libyan Dinar', '4.83'),
(90, 'MAD', 'Moroccan Dirham', '10.01'),
(91, 'MDL', 'Moldovan Leu', '19.24'),
(92, 'MGA', 'Malagasy Ariary', '4093.55'),
(93, 'MKD', 'Macedonian Denar', '58.74'),
(94, 'MMK', 'Myanma Kyat', '1869.58'),
(95, 'MNT', 'Mongolian Tugrik', '3101.86'),
(96, 'MOP', 'Macanese Pataca', '8.16'),
(97, 'MRO', 'Mauritanian Ouguiya (pre-2018)', '6.80'),
(98, 'MRU', 'Mauritanian Ouguiya', '36.78'),
(99, 'MUR', 'Mauritian Rupee', '44.23'),
(100, 'MVR', 'Maldivian Rufiyaa', '15.85'),
(101, 'MWK', 'Malawian Kwacha', '1031.56'),
(102, 'MXN', 'Mexican Peso', '20.10'),
(103, 'MYR', 'Malaysian Ringgit', '4.41'),
(104, 'MZN', 'Mozambican Metical', '63.87'),
(105, 'NAD', 'Namibian Dollar', '15.85'),
(106, 'NGN', 'Nigerian Naira', '414.93'),
(107, 'NIO', 'Nicaraguan Córdoba', '36.20'),
(108, 'NOK', 'Norwegian Krone', '9.77'),
(109, 'NPR', 'Nepalese Rupee', '125.69'),
(110, 'NZD', 'New Zealand Dollar', '1.58'),
(111, 'OMR', 'Omani Rial', '0.39'),
(112, 'PAB', 'Panamanian Balboa', '1.00'),
(113, 'PEN', 'Peruvian Nuevo Sol', '3.80'),
(114, 'PGK', 'Papua New Guinean Kina', '3.60'),
(115, 'PHP', 'Philippine Peso', '53.22'),
(116, 'PKR', 'Pakistani Rupee', '204.23'),
(117, 'PLN', 'Polish Zloty', '4.40'),
(118, 'PYG', 'Paraguayan Guarani', '6927.60'),
(119, 'QAR', 'Qatari Rial', '3.69'),
(120, 'RON', 'Romanian Leu', '4.70'),
(121, 'RSD', 'Serbian Dinar', '111.51'),
(122, 'RUB', 'Russian Ruble', '57.07'),
(123, 'RWF', 'Rwandan Franc', '1038.64'),
(124, 'SAR', 'Saudi Riyal', '3.75'),
(125, 'SBD', 'Solomon Islands Dollar', '8.11'),
(126, 'SCR', 'Seychellois Rupee', '14.24'),
(127, 'SDG', 'Sudanese Pound', '456.28'),
(128, 'SEK', 'Swedish Krona', '10.06'),
(129, 'SGD', 'Singapore Dollar', '1.39'),
(130, 'SHP', 'Saint Helena Pound', '0.81'),
(131, 'SLL', 'Sierra Leonean Leone', '13123.57'),
(132, 'SOS', 'Somali Shilling', '584.12'),
(133, 'SRD', 'Surinamese Dollar', '21.76'),
(134, 'SSP', 'South Sudanese Pound', '130.20'),
(135, 'STD', 'São Tomé and Príncipe Dobra (pre-2018)', '23251.60'),
(136, 'STN', 'São Tomé and Príncipe Dobra', '23.49'),
(137, 'SVC', 'Salvadoran Colón', '8.84'),
(138, 'SYP', 'Syrian Pound', '2511.30'),
(139, 'SZL', 'Swazi Lilangeni', '15.75'),
(140, 'THB', 'Thai Baht', '34.78'),
(141, 'TJS', 'Tajikistani Somoni', '11.11'),
(142, 'TMT', 'Turkmenistani Manat', '3.50'),
(143, 'TND', 'Tunisian Dinar', '3.07'),
(144, 'TOP', 'Tongan Pa\'anga', '2.32'),
(145, 'TRY', 'Turkish Lira', '17.22'),
(146, 'TTD', 'Trinidad and Tobago Dollar', '6.86'),
(147, 'TWD', 'New Taiwan Dollar', '29.73'),
(148, 'TZS', 'Tanzanian Shilling', '2352.70'),
(149, 'UAH', 'Ukrainian Hryvnia', '29.84'),
(150, 'UGX', 'Ugandan Shilling', '3726.33'),
(151, 'USD', 'United States Dollar', '1.00'),
(152, 'UYU', 'Uruguayan Peso', '39.89'),
(153, 'UZS', 'Uzbekistan Som', '11113.27'),
(154, 'VEF', 'Venezuelan Bolívar Fuerte (Old)', '6.80'),
(155, 'VES', 'Venezuelan Bolívar Soberano', '5.24'),
(156, 'VND', 'Vietnamese Dong', '23198.56'),
(157, 'VUV', 'Vanuatu Vatu', '115.00'),
(158, 'WST', 'Samoan Tala', '2.62'),
(159, 'XAF', 'CFA Franc BEAC', '624.89'),
(160, 'XAG', 'Silver Ounce', '0.05'),
(161, 'XAU', 'Gold Ounce', '0.00'),
(162, 'XCD', 'East Caribbean Dollar', '2.70'),
(163, 'XDR', 'Special Drawing Rights', '0.73'),
(164, 'XOF', 'CFA Franc BCEAO', '624.89'),
(165, 'XPD', 'Palladium Ounce', '0.00'),
(166, 'XPF', 'CFP Franc', '113.68'),
(167, 'XPT', 'Platinum Ounce', '0.00'),
(168, 'YER', 'Yemeni Rial', '250.13'),
(169, 'ZAR', 'South African Rand', '15.97'),
(170, 'ZMW', 'Zambian Kwacha', '17.09'),
(171, 'ZWL', 'Zimbabwean Dollar', '321.84');

--
-- Dumping data for table `t_group`
--

INSERT INTO `t_group` (`id`, `enable`, `name`, `notes`, `avatar`, `default_currency_code`, `default_book_id`) VALUES
(1, b'1', '默认组', NULL, NULL, 'CNY', 1);

--
-- Dumping data for table `t_user`
--

INSERT INTO `t_user` (`id`, `avatar`, `email`, `enable`, `ip`, `nick_name`, `password`, `telephone`, `user_name`, `vip_time`, `default_book_id`, `default_group_id`) VALUES
(1, NULL, NULL, b'1', '172.27.0.6', '111', '96E79218965EB72C92A549DD5A330112', NULL, '111', 1666920131036, 1, 1);

--
-- Dumping data for table `t_user_group_relation`
--

INSERT INTO `t_user_group_relation` (`id`, `role`, `group_id`, `user_id`) VALUES
(1, 1, 1, 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
