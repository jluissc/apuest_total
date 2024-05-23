-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-05-2024 a las 20:10:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdapt`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientPayData` (IN `client_id` INT)   BEGIN
     IF client_id = 0 THEN
        SELECT cp.id, c.id as id_client, cp.amount, 
        c.player_id, c.name, c.last_pat, c.last_mat, 
        cp.day, cp.hour, ca.channel, e.names, b.bank, pm.id as modify, cp.created_at
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id
        LEFT JOIN bank b ON b.id = cp.bank_id
        LEFT JOIN pay_modify pm ON pm.client_pay_id = cp.id;
    ELSE
        SELECT cp.id, c.id as id_client, cp.amount, c.player_id, c.name, c.last_pat, c.last_mat, cp.day, cp.hour, ca.channel, e.names, b.bank, pm.id as modify, cp.created_at
        FROM client_pay cp
        LEFT JOIN client c ON c.id = cp.client_id
        LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        LEFT JOIN employed e ON e.id = cp.employed_id
        LEFT JOIN bank b ON b.id = cp.bank_id
        LEFT JOIN pay_modify pm ON pm.client_pay_id = cp.id
        WHERE c.id = client_id;
    END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bank_x_pay` ()   BEGIN
    SELECT 
        b.bank, count(*) as quant_pays
    FROM 
        client_pay cp
    LEFT JOIN 
        bank b ON b.id = cp.bank_id
        
    GROUP BY b.bank;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_channel_x_pay` ()   BEGIN
    SELECT 
        ca.channel, count(*) as quant_pays
    FROM 
        client_pay cp
    LEFT JOIN 
        channel_attention ca ON ca.id = cp.channel_attention_id
        
    GROUP BY ca.channel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_pay_modify` ()   BEGIN
    SELECT b.bank, ca.channel, c.name,
c.last_pat, c.last_mat, cp.amount, cp.day, cp.hour, pm.created_at FROM 
        pay_modify pm    
    LEFT JOIN  client_pay cp ON cp.id = pm.client_pay_id
   	LEFT JOIN client c ON c.id = cp.client_id
    LEFT JOIN bank b ON b.id = cp.bank_id
    LEFT JOIN channel_attention ca ON ca.id = cp.channel_attention_id
        ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `bank` varchar(45) NOT NULL,
  `flag` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bank`
--

INSERT INTO `bank` (`id`, `bank`, `flag`) VALUES
(1, 'INTERBANK', '1'),
(2, 'BCP', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `channel_attention`
--

CREATE TABLE `channel_attention` (
  `id` int(11) NOT NULL,
  `channel` varchar(45) NOT NULL,
  `flag` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `channel_attention`
--

INSERT INTO `channel_attention` (`id`, `channel`, `flag`) VALUES
(1, 'WHATSAPP', 1),
(2, 'INSTAGRAM', 1),
(3, 'TELEGRAM', 1),
(4, 'MESSENGER', 1),
(5, 'TIKTOK', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `player_id` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `last_pat` varchar(45) NOT NULL,
  `last_mat` varchar(45) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `type_doc` int(11) DEFAULT NULL,
  `num_doc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `client`
--

INSERT INTO `client` (`id`, `player_id`, `name`, `last_pat`, `last_mat`, `created_at`, `updated_at`, `status`, `type_doc`, `num_doc`) VALUES
(1, '000001', 'JOSE LUIS', 'SOTO', 'CHAHAU', '2024-05-22 05:11:16', '2024-05-22 05:11:16', 1, 1, 60691536),
(2, '000002', 'TINO', 'NOLASCO', 'PONCE', '2024-05-22 05:11:16', '2024-05-22 05:11:16', 1, 1, 78564889);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client_pay`
--

CREATE TABLE `client_pay` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `amount` decimal(11,2) NOT NULL,
  `day` date NOT NULL,
  `hour` time NOT NULL,
  `url_img` varchar(100) NOT NULL,
  `flag` tinyint(4) NOT NULL,
  `employed_id` int(11) NOT NULL,
  `channel_attention_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `client_pay`
--

INSERT INTO `client_pay` (`id`, `client_id`, `amount`, `day`, `hour`, `url_img`, `flag`, `employed_id`, `channel_attention_id`, `bank_id`, `created_at`, `updated_at`) VALUES
(5, 1, 150.00, '2023-10-10', '10:00:00', 'EVEDENCIA_1_1716474844.jpg', 1, 1, 2, 1, NULL, NULL),
(6, 2, 20.00, '2024-03-15', '15:00:00', 'EVEDENCIA_2_1716476065.jpg', 1, 1, 3, 2, '2024-05-23 14:54:25', '2024-05-23 15:43:50'),
(7, 1, 190.00, '2023-11-11', '11:00:00', 'EVEDENCIA_1_1716478290.jpg', 1, 1, 3, 2, '2024-05-23 15:31:30', '2024-05-23 15:34:35'),
(8, 2, 25.00, '2023-05-11', '17:00:00', 'EVEDENCIA_2_1716483189.jpg', 1, 1, 3, 1, '2024-05-23 16:53:10', '2024-05-23 16:53:10'),
(9, 1, 150.00, '2024-04-21', '11:00:00', 'EVEDENCIA_1_1716484112.jpg', 1, 1, 2, 1, '2024-05-23 17:08:32', '2024-05-23 17:08:32'),
(10, 2, 14.00, '2023-11-11', '11:00:00', 'EVEDENCIA_2_1716486410.png', 1, 1, 5, 2, '2024-05-23 17:46:50', '2024-05-23 17:46:50'),
(11, 1, 111.00, '2023-11-11', '11:08:00', 'EVEDENCIA_1_1716486497.jpg', 1, 1, 1, 1, '2024-05-23 17:48:17', '2024-05-23 17:49:06'),
(12, 2, 150.00, '2024-05-12', '12:40:00', 'EVEDENCIA_2_1716486600.jpg', 1, 1, 4, 2, '2024-05-23 17:50:00', '2024-05-23 17:50:00'),
(13, 1, 200.00, '2024-03-12', '12:50:00', 'EVEDENCIA_1_1716486885.jpg', 1, 1, 4, 1, '2024-05-23 17:54:45', '2024-05-23 17:54:45'),
(14, 2, 111.00, '2023-01-11', '11:11:00', 'EVEDENCIA_2_1716487047.jpg', 1, 1, 1, 2, '2024-05-23 17:57:27', '2024-05-23 17:57:27'),
(15, 2, 150.00, '2024-11-16', '11:11:00', 'EVEDENCIA_2_1716487206.jpg', 1, 1, 2, 1, '2024-05-23 18:00:06', '2024-05-23 18:00:06'),
(16, 2, 150.00, '2024-11-16', '11:11:00', 'EVEDENCIA_2_1716487216.jpg', 1, 1, 2, 1, '2024-05-23 18:00:16', '2024-05-23 18:00:16'),
(17, 2, 150.00, '2024-11-16', '11:11:00', 'EVEDENCIA_2_1716487239.jpg', 1, 1, 2, 1, '2024-05-23 18:00:40', '2024-05-23 18:00:40'),
(18, 1, 90.00, '2023-07-15', '11:01:00', 'EVEDENCIA_1_1716487291.jpg', 1, 1, 3, 1, '2024-05-23 18:01:31', '2024-05-23 18:05:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client_pay_log`
--

CREATE TABLE `client_pay_log` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT NULL,
  `day` date DEFAULT NULL,
  `hour` time DEFAULT NULL,
  `url_img` varchar(100) DEFAULT NULL,
  `employed_id` int(11) DEFAULT NULL,
  `channel_attention_id` int(11) DEFAULT NULL,
  `flag` tinyint(4) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `type_log` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `client_pay_log`
--

INSERT INTO `client_pay_log` (`id`, `client_id`, `amount`, `day`, `hour`, `url_img`, `employed_id`, `channel_attention_id`, `flag`, `bank_id`, `type_log`) VALUES
(1, 2, 150.00, '2024-11-16', '11:11:00', 'EVEDENCIA_2_1716487239.jpg', 1, 2, 1, 1, NULL),
(2, 1, 100.00, '2023-07-15', '11:01:00', 'EVEDENCIA_1_1716487291.jpg', 1, 3, 1, 1, 'CREATE'),
(3, 1, 100.00, '2023-07-15', '11:01:00', 'EVEDENCIA_1_1716487291.jpg', 1, 3, 1, 1, 'UPDATE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employed`
--

CREATE TABLE `employed` (
  `id` int(11) NOT NULL,
  `names` varchar(45) NOT NULL,
  `last_pat` varchar(45) NOT NULL,
  `last_mat` varchar(45) NOT NULL,
  `type_doc` int(11) NOT NULL,
  `num_doc` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `profile_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `employed`
--

INSERT INTO `employed` (`id`, `names`, `last_pat`, `last_mat`, `type_doc`, `num_doc`, `status`, `profile_id`) VALUES
(1, 'ANGEL', 'VALERIO', 'GARCIA', 1, 45895612, 1, 1),
(2, 'ALEXANDRA', 'RAMIREZ', 'CAJALEON', 1, 78561245, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modification_type`
--

CREATE TABLE `modification_type` (
  `id` int(11) NOT NULL,
  `modification_type` varchar(45) NOT NULL,
  `flag` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modification_type`
--

INSERT INTO `modification_type` (`id`, `modification_type`, `flag`) VALUES
(1, 'ERROR HUMANO', 1),
(3, 'ERROR DE SISTEMA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pay_modify`
--

CREATE TABLE `pay_modify` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `client_pay_id` int(11) NOT NULL,
  `modification_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pay_modify`
--

INSERT INTO `pay_modify` (`id`, `created_at`, `updated_at`, `client_pay_id`, `modification_type_id`) VALUES
(1, '2024-05-23 10:34:09', '2024-05-23 10:34:09', 7, 1),
(4, '2024-05-23 10:43:50', '2024-05-23 10:43:50', 6, 3),
(5, '2024-05-23 12:28:21', '2024-05-23 12:28:21', 9, 1),
(6, '2024-05-23 12:44:43', '2024-05-23 12:44:43', 5, 3),
(7, '2024-05-23 12:45:25', '2024-05-23 12:45:25', 8, 3),
(8, '2024-05-23 12:47:14', '2024-05-23 12:47:14', 10, 1),
(9, '2024-05-23 12:49:06', '2024-05-23 12:49:06', 11, 1),
(10, '2024-05-23 13:05:20', '2024-05-23 13:05:20', 18, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profile`
--

CREATE TABLE `profile` (
  `id` int(11) NOT NULL,
  `profile` varchar(45) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profile`
--

INSERT INTO `profile` (`id`, `profile`, `status`) VALUES
(1, 'VENTAS', 1),
(2, 'ADMINISTRADOR', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `channel_attention`
--
ALTER TABLE `channel_attention`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `client_pay`
--
ALTER TABLE `client_pay`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `employed_id` (`employed_id`),
  ADD KEY `channel_attention_id` (`channel_attention_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indices de la tabla `client_pay_log`
--
ALTER TABLE `client_pay_log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `employed`
--
ALTER TABLE `employed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id` (`profile_id`);

--
-- Indices de la tabla `modification_type`
--
ALTER TABLE `modification_type`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pay_modify`
--
ALTER TABLE `pay_modify`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_pay_id` (`client_pay_id`),
  ADD KEY `modification_type_id` (`modification_type_id`);

--
-- Indices de la tabla `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `channel_attention`
--
ALTER TABLE `channel_attention`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `client_pay`
--
ALTER TABLE `client_pay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `client_pay_log`
--
ALTER TABLE `client_pay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `employed`
--
ALTER TABLE `employed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `modification_type`
--
ALTER TABLE `modification_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pay_modify`
--
ALTER TABLE `pay_modify`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `profile`
--
ALTER TABLE `profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `client_pay`
--
ALTER TABLE `client_pay`
  ADD CONSTRAINT `client_pay_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `client_pay_ibfk_2` FOREIGN KEY (`employed_id`) REFERENCES `employed` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `client_pay_ibfk_3` FOREIGN KEY (`channel_attention_id`) REFERENCES `channel_attention` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `client_pay_ibfk_4` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `employed`
--
ALTER TABLE `employed`
  ADD CONSTRAINT `employed_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pay_modify`
--
ALTER TABLE `pay_modify`
  ADD CONSTRAINT `pay_modify_ibfk_1` FOREIGN KEY (`client_pay_id`) REFERENCES `client_pay` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pay_modify_ibfk_2` FOREIGN KEY (`modification_type_id`) REFERENCES `modification_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
