-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-05-2024 a las 01:40:06
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_apuesta_total`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientPayData` (IN `client_id` INT)   BEGIN
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `bank` varchar(100) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `bank_id` int(11) NOT NULL,
  `day` date NOT NULL,
  `hour` time NOT NULL,
  `url_img` varchar(100) NOT NULL,
  `flag` tinyint(4) NOT NULL,
  `employed_id` int(11) NOT NULL,
  `channel_attention_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `client_pay`
--

INSERT INTO `client_pay` (`id`, `client_id`, `amount`, `bank_id`, `day`, `hour`, `url_img`, `flag`, `employed_id`, `channel_attention_id`) VALUES
(1, 2, 100.00, 0, '2023-05-10', '10:30:00', 'EVEDENCIA_2_2024-05-22 00:08:20.jpg', 1, 1, 1),
(2, 1, 250.00, 0, '2024-12-15', '14:00:00', 'EVEDENCIA_1_2024-05-22 00:11:07.jpg', 1, 1, 3),
(3, 1, 1500.00, 0, '2024-04-10', '14:23:00', 'EVEDENCIA_1_1716354960.jpg', 1, 1, 2),
(4, 2, 1500.00, 0, '2024-01-01', '15:40:00', 'EVEDENCIA_2_1716356488.jpg', 1, 1, 3);

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
  `type_log` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD KEY `channel_attention_id` (`channel_attention_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `client_pay_log`
--
ALTER TABLE `client_pay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `employed`
--
ALTER TABLE `employed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `client_pay_ibfk_3` FOREIGN KEY (`channel_attention_id`) REFERENCES `channel_attention` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `employed`
--
ALTER TABLE `employed`
  ADD CONSTRAINT `employed_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
