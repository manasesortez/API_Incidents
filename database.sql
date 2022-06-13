-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2022 a las 05:58:46
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_proandroid`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_incidentes`
--

CREATE TABLE `tbl_incidentes` (
  `id_incidente` int(11) NOT NULL,
  `id_tipo_incidente` int(11) NOT NULL,
  `descripcion_incidente` varchar(255) NOT NULL,
  `fecha_incidente` datetime NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `imagen_incidente` varchar(255) NOT NULL,
  `id_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipos`
--

CREATE TABLE `tbl_tipos` (
  `id_tipo` int(11) NOT NULL,
  `tipo_usuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipos`
--

INSERT INTO `tbl_tipos` (`id_tipo`, `tipo_usuario`) VALUES
(1, 'Administrador'),
(2, 'Empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_estado`
--

CREATE TABLE `tbl_tipo_estado` (
  `id_estado` int(11) NOT NULL,
  `tipo_estado` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_estado`
--

INSERT INTO `tbl_tipo_estado` (`id_estado`, `tipo_estado`) VALUES
(1, 'Incidente Activo'),
(2, 'Incidente Resuelto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_incidente`
--

CREATE TABLE `tbl_tipo_incidente` (
  `id_tipo_incidente` int(11) NOT NULL,
  `tipo_incidente` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_incidente`
--

INSERT INTO `tbl_tipo_incidente` (`id_tipo_incidente`, `tipo_incidente`) VALUES
(1, 'Ataques cibernéticos'),
(2, 'Código malicioso'),
(3, 'Denegación de Servicio'),
(4, 'Denegación de Servicio Distribuida'),
(5, 'Acceso no autorizado'),
(6, 'Pérdida de datos'),
(7, 'Daños físicos'),
(8, 'Abuso de privilegios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `correo_usuario` varchar(255) NOT NULL,
  `pass_usuario` varchar(255) NOT NULL,
  `id_tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id_usuario`, `nombre_usuario`, `correo_usuario`, `pass_usuario`, `id_tipo`) VALUES
(1, 'Ezequiel', 'correoprueba1@prueba.com', '123456', 1),
(2, 'Alberto', 'correoprueba1@prueba.com', '123456', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_incidentes`
--
ALTER TABLE `tbl_incidentes`
  ADD PRIMARY KEY (`id_incidente`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_tipo_incidente` (`id_tipo_incidente`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_tipos`
--
ALTER TABLE `tbl_tipos`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `tbl_tipo_estado`
--
ALTER TABLE `tbl_tipo_estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `tbl_tipo_incidente`
--
ALTER TABLE `tbl_tipo_incidente`
  ADD PRIMARY KEY (`id_tipo_incidente`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `tbl_usuarios_ibfk_1` (`id_tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_incidentes`
--
ALTER TABLE `tbl_incidentes`
  MODIFY `id_incidente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_tipos`
--
ALTER TABLE `tbl_tipos`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_estado`
--
ALTER TABLE `tbl_tipo_estado`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_incidente`
--
ALTER TABLE `tbl_tipo_incidente`
  MODIFY `id_tipo_incidente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_incidentes`
--
ALTER TABLE `tbl_incidentes`
  ADD CONSTRAINT `tbl_incidentes_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `tbl_tipo_estado` (`id_estado`),
  ADD CONSTRAINT `tbl_incidentes_ibfk_2` FOREIGN KEY (`id_tipo_incidente`) REFERENCES `tbl_tipo_incidente` (`id_tipo_incidente`),
  ADD CONSTRAINT `tbl_incidentes_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuarios` (`id_usuario`);

--
-- Filtros para la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD CONSTRAINT `tbl_usuarios_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tbl_tipos` (`id_tipo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
