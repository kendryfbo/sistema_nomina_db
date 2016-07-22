-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.13-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.3.0.5075
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para nomina
CREATE DATABASE IF NOT EXISTS `nomina` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `nomina`;

-- Volcando estructura para tabla nomina.area
CREATE TABLE IF NOT EXISTS `area` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(50) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.area: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT IGNORE INTO `area` (`codigo`, `descripcion`, `activo`, `fechacreac`) VALUES
	('ADMINI', 'ADMINISTRATIVO', 1, '2016-04-24'),
	('DOCENT', 'DOCENTE', 1, '2016-04-24'),
	('OBRERO', 'OBRERO', 1, '2016-04-24'),
	('SUPLTE', 'SUPLENTE', 1, '2016-04-24');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.asignacioncargada
CREATE TABLE IF NOT EXISTS `asignacioncargada` (
  `numero` int(10) NOT NULL,
  `cod_asign` char(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero`,`cod_asign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.asignacioncargada: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacioncargada` DISABLE KEYS */;
INSERT IGNORE INTO `asignacioncargada` (`numero`, `cod_asign`, `ced_emp`, `descripcion`, `cantidad`, `valor`) VALUES
	(11, 'COD', '19017070', 'TEST', 1, 0.00),
	(12, 'COD', '19017070', 'TEST', 2, 99.00),
	(13, 'COD', '19017070', 'TEST', 1, 99.00),
	(14, 'COD', '19017070', 'TEST', 1, 99.00),
	(15, 'COD', '19017070', 'TEST', 1, 99.00),
	(16, 'VALOR', '19017070', 'VALOR', 1, 2500.00),
	(17, 'ANT1', '19017070', 'ANTIGUEDAD', 1, 800.00),
	(17, 'EJER', '19017070', 'EJERCICIO DOCENTE', 1, 250.00),
	(17, 'TRANS', '19017070', 'TRANSPORTE', 1, 250.00);
/*!40000 ALTER TABLE `asignacioncargada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.asignacionconcepto
CREATE TABLE IF NOT EXISTS `asignacionconcepto` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `forma` char(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '1.00',
  `formula` char(50) DEFAULT NULL,
  `prima` tinyint(1) NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.asignacionconcepto: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacionconcepto` DISABLE KEYS */;
INSERT IGNORE INTO `asignacionconcepto` (`codigo`, `descripcion`, `forma`, `valor`, `formula`, `prima`, `activo`, `fechacreac`) VALUES
	('ANT1', 'ANTIGUEDAD', 'VALOR', 800.00, '1.00', 0, 1, '2016-05-12'),
	('ASD', 'ASD', 'DIA', 100.00, '1.00', 0, 1, '2016-04-28'),
	('COD', 'TEST', 'HORA', 100.00, '1.00', 0, 1, '2016-04-26'),
	('EJER', 'EJERCICIO DOCENTE', 'VALOR', 250.00, '1.00', 0, 1, '2016-05-12'),
	('PRIMA1', 'PRIMA 1', 'VALOR', 1500.00, NULL, 1, 1, '2016-05-19'),
	('PRTRAS', 'PRIMA DE TRANSPORTE', 'VALOR', 1300.00, NULL, 0, 1, '2016-05-20'),
	('TRANS', 'TRANSPORTE', 'VALOR', 250.00, '1.00', 0, 1, '2016-05-12'),
	('VALOR', 'VALOR', 'VALOR', 2500.00, '1.00', 0, 1, '2016-04-28');
/*!40000 ALTER TABLE `asignacionconcepto` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.asignacionemp
CREATE TABLE IF NOT EXISTS `asignacionemp` (
  `ced_emp` char(50) NOT NULL,
  `cod_asignacion` char(10) NOT NULL,
  `tipo` char(50) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cod_asignacion`,`ced_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.asignacionemp: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacionemp` DISABLE KEYS */;
INSERT IGNORE INTO `asignacionemp` (`ced_emp`, `cod_asignacion`, `tipo`, `cantidad`) VALUES
	('19017070', 'ANT1', 'FIJA', 1),
	('19017070', 'EJER', 'FIJA', 1),
	('5907711', 'PRTRAS', 'FIJA', 1),
	('19017070', 'TRANS', 'FIJA', 1);
/*!40000 ALTER TABLE `asignacionemp` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.asignacionformula
CREATE TABLE IF NOT EXISTS `asignacionformula` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` char(50) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.asignacionformula: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacionformula` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacionformula` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.asignacionprocesada
CREATE TABLE IF NOT EXISTS `asignacionprocesada` (
  `numero` int(10) NOT NULL,
  `cod_asign` char(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero`,`cod_asign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.asignacionprocesada: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `asignacionprocesada` DISABLE KEYS */;
INSERT IGNORE INTO `asignacionprocesada` (`numero`, `cod_asign`, `ced_emp`, `descripcion`, `cantidad`, `valor`) VALUES
	(17, 'ANT1', '19017070', 'ANTIGUEDAD', 1, 800.00),
	(17, 'EJER', '19017070', 'EJERCICIO DOCENTE', 1, 250.00),
	(17, 'TRANS', '19017070', 'TRANSPORTE', 1, 250.00);
/*!40000 ALTER TABLE `asignacionprocesada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.clasificacion
CREATE TABLE IF NOT EXISTS `clasificacion` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `cod_area` char(10) NOT NULL,
  `formapago` char(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.clasificacion: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `clasificacion` DISABLE KEYS */;
INSERT IGNORE INTO `clasificacion` (`codigo`, `descripcion`, `cod_area`, `formapago`, `valor`, `activo`, `fechacreac`) VALUES
	('DHORA', 'DOCENTE POR HORA CAT 1', 'DOCENT', 'HORA', 119.75, 1, '2016-04-30'),
	('TECHC1', 'TECNICO SUPERIOR EN EDUCACION CAT 1', 'ADMINI', 'SEMANA', 47.40, 1, '2016-04-24');
/*!40000 ALTER TABLE `clasificacion` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.conceptoanticipo
CREATE TABLE IF NOT EXISTS `conceptoanticipo` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `tipo` char(50) NOT NULL,
  `forma` char(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `Docente` tinyint(1) DEFAULT '0',
  `suplente` tinyint(1) DEFAULT '0',
  `obrero` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.conceptoanticipo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `conceptoanticipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `conceptoanticipo` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.deduccioncargada
CREATE TABLE IF NOT EXISTS `deduccioncargada` (
  `numero` int(10) NOT NULL,
  `cod_deduc` char(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero`,`cod_deduc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.deduccioncargada: ~20 rows (aproximadamente)
/*!40000 ALTER TABLE `deduccioncargada` DISABLE KEYS */;
INSERT IGNORE INTO `deduccioncargada` (`numero`, `cod_deduc`, `ced_emp`, `descripcion`, `cantidad`, `valor`) VALUES
	(11, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 3, 0.00),
	(12, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 3, 99.00),
	(13, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 3, 99.00),
	(14, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 3, 99.00),
	(15, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 3, 99.00),
	(16, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 4, 119.75),
	(16, 'DEDUC2', '20833024', 'DIA DE TRABAJO', 1, 684.29),
	(17, 'CLUB', '19017070', 'CLUB NAZAREHT', 1, 200.00),
	(17, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 4, 119.75),
	(17, 'DEDUC2', '20833024', 'DIA DE TRABAJO', 1, 684.29),
	(17, 'LRPVH', '19017070', 'LEY DE REGIMEN PRESTACION DE VIVIENDA Y HABITAT', 1, 214.18),
	(17, 'S.S.O', '19017070', 'SEGURO SOCIAL OBLIGATORIO', 1, 0.00),
	(17, 'SSOT', '19017070', 'S.S.O Y PARO F', 1, 963.81);
/*!40000 ALTER TABLE `deduccioncargada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.deduccionconcepto
CREATE TABLE IF NOT EXISTS `deduccionconcepto` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `forma` char(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '1.00',
  `formula` char(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.deduccionconcepto: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `deduccionconcepto` DISABLE KEYS */;
INSERT IGNORE INTO `deduccionconcepto` (`codigo`, `descripcion`, `forma`, `valor`, `formula`, `activo`, `fechacreac`) VALUES
	('APORT', 'APORTE ESP. CLUB', 'VALOR', 100.00, 'S.S.O', 1, '2016-05-12'),
	('CLUB', 'CLUB NAZAREHT', 'VALOR', 200.00, 'S.S.O', 1, '2016-05-12'),
	('DEDUC1', 'HORA INASISTENCIA', 'HORA', 100.00, NULL, 1, '2016-04-24'),
	('DEDUC2', 'DIA DE TRABAJO', 'DIA', 100.00, NULL, 1, '2016-04-24'),
	('LRPVH', 'LEY DE REGIMEN PRESTACION DE VIVIENDA Y HABITAT', 'FORMULA', 100.00, 'L.P.H', 1, '2016-05-12'),
	('PF', 'PARO FORZOSO', 'FORMULA', 100.00, 'P.F', 1, '2016-05-20'),
	('PORT', 'PROCENTAJE SALARIO', 'VALOR', 8047.20, 'S.S.O', 1, '2016-05-12'),
	('S.S.O', 'SEGURO SOCIAL OBLIGATORIO', 'FORMULA', 100.00, 'S.S.O', 1, '2016-04-27'),
	('SSOT', 'S.S.O Y PARO F', 'VALOR', 963.81, 'S.S.O', 1, '2016-05-12');
/*!40000 ALTER TABLE `deduccionconcepto` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.deduccionemp
CREATE TABLE IF NOT EXISTS `deduccionemp` (
  `ced_emp` char(50) NOT NULL,
  `cod_deduccion` char(10) NOT NULL,
  `tipo` char(50) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cod_deduccion`,`ced_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.deduccionemp: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `deduccionemp` DISABLE KEYS */;
INSERT IGNORE INTO `deduccionemp` (`ced_emp`, `cod_deduccion`, `tipo`, `cantidad`) VALUES
	('19017070', 'APORT', 'FIJA', 1),
	('20833032', 'APORT', 'FIJA', 1),
	('19017070', 'CLUB', 'FIJA', 1),
	('20833032', 'CLUB', 'FIJA', 1),
	('19017070', 'DEDUC1', 'FIJA', 4),
	('20833032', 'DEDUC1', 'FIJA', 4),
	('20833024', 'DEDUC2', 'FIJA', 1),
	('19017070', 'LRPVH', 'FIJA', 1),
	('20833032', 'LRPVH', 'FIJA', 1),
	('20833032', 'PF', 'FIJA', 1),
	('19017070', 'S.S.O', 'FIJA', 1),
	('20833032', 'S.S.O', 'FIJA', 1),
	('19017070', 'SSOT', 'FIJA', 1);
/*!40000 ALTER TABLE `deduccionemp` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.deduccionformula
CREATE TABLE IF NOT EXISTS `deduccionformula` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` char(50) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.deduccionformula: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `deduccionformula` DISABLE KEYS */;
INSERT IGNORE INTO `deduccionformula` (`codigo`, `descripcion`, `activo`, `fechacreac`) VALUES
	(1, 'S.S.O', 1, '2016-05-12'),
	(2, 'P.F', 1, '2016-05-20'),
	(3, 'L.P.H', 1, '2016-05-20');
/*!40000 ALTER TABLE `deduccionformula` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.deduccionprocesada
CREATE TABLE IF NOT EXISTS `deduccionprocesada` (
  `numero` int(10) NOT NULL,
  `cod_deduc` char(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `cantidad` int(10) NOT NULL DEFAULT '1',
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero`,`cod_deduc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.deduccionprocesada: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `deduccionprocesada` DISABLE KEYS */;
INSERT IGNORE INTO `deduccionprocesada` (`numero`, `cod_deduc`, `ced_emp`, `descripcion`, `cantidad`, `valor`) VALUES
	(17, 'APORT', '19017070', 'APORTE ESP. CLUB', 1, 100.00),
	(17, 'CLUB', '19017070', 'CLUB NAZARET', 1, 200.00),
	(17, 'DEDUC1', '19017070', 'HORA INASISTENCIA', 4, 119.75),
	(17, 'DEDUC2', '20833024', 'DIA DE TRABAJO', 1, 684.29),
	(17, 'LRPVH', '19017070', 'LEY DE REGIMEN PRESTACION DE VIVIENDA Y HABITAT', 1, 214.18),
	(17, 'PORT', '19017070', 'PROCENTAJE SALARIO', 1, 8047.20),
	(17, 'SSOT', '19017070', 'S.S.O Y PARO F', 1, 963.81);
/*!40000 ALTER TABLE `deduccionprocesada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `cedula` char(10) NOT NULL,
  `nombres` char(50) NOT NULL,
  `apellidos` char(50) NOT NULL,
  `rif` char(50) DEFAULT NULL,
  `fechanac` date NOT NULL,
  `lugarnac` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `edocivil` char(50) NOT NULL,
  `numhijos` int(10) DEFAULT NULL,
  `direccion` char(50) DEFAULT NULL,
  `tlf1` char(50) DEFAULT NULL,
  `tlf2` char(50) DEFAULT NULL,
  `nivelacad` char(50) DEFAULT NULL,
  `espec` char(50) DEFAULT NULL,
  `nivelsup` tinyint(1) DEFAULT '0',
  `titulo` char(50) DEFAULT NULL,
  `cod_area` char(10) NOT NULL,
  `cod_clasif` char(10) NOT NULL,
  `nivel` char(50) DEFAULT NULL,
  `horas` int(10) NOT NULL,
  `salariohora` decimal(10,2) NOT NULL DEFAULT '1.00',
  `salariodia` decimal(10,2) NOT NULL DEFAULT '1.00',
  `salariasem` decimal(10,2) NOT NULL DEFAULT '1.00',
  `salariomes` decimal(10,2) NOT NULL DEFAULT '1.00',
  `contrato` char(50) NOT NULL,
  `fecha_ingeduc` date DEFAULT NULL,
  `fecha_ingeducpriv` date DEFAULT NULL,
  `fecha_ing` date DEFAULT NULL,
  `status` char(50) NOT NULL,
  `antiguedad` int(10) DEFAULT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.empleado: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT IGNORE INTO `empleado` (`cedula`, `nombres`, `apellidos`, `rif`, `fechanac`, `lugarnac`, `email`, `edocivil`, `numhijos`, `direccion`, `tlf1`, `tlf2`, `nivelacad`, `espec`, `nivelsup`, `titulo`, `cod_area`, `cod_clasif`, `nivel`, `horas`, `salariohora`, `salariodia`, `salariasem`, `salariomes`, `contrato`, `fecha_ingeduc`, `fecha_ingeducpriv`, `fecha_ing`, `status`, `antiguedad`) VALUES
	('19017070', 'KENDRY OSLEY', 'FINOL BOSCAN', '123123', '2016-04-30', 'ASD', 'ASD', 'SOLTERO/A', 0, 'ASD', 'ASD', 'ASD', 'AASD', 'ASD', 0, 'ASD', 'DOCENT', 'DHORA', 'AASD', 42, 42.00, 718.50, 5029.50, 20118.00, 'DETERMINADO', '2016-10-10', '2016-10-10', '2016-04-30', 'ACTIVO', 0),
	('20833024', 'PEDRO ANTONIO', 'PEREZ GONZALEZ', '', '1987-05-12', 'MARACAIBO', 'ASD', 'SOLTERO/A', 4, 'ASD', 'ASD', 'ASD', 'ASD', 'ASD', 0, 'ASD', 'DOCENT', 'DHORA', 'ASD', 40, 40.00, 684.29, 4790.03, 19160.12, 'DETERMINADO', '2016-10-10', '2016-10-10', '2016-05-12', 'ACTIVO', 0),
	('20833032', 'MARIA ALEJANDRA', 'FIGUEROA', '3646445', '2016-05-02', 'ASDASD', 'ASDASD', 'ASDASD', 0, 'ASD', 'ASD', 'ASD', 'ASD', 'ASDF', 0, 'ASD', 'DOCENT', 'DHORA', 'AASD', 40, 40.00, 684.29, 4790.03, 19160.12, 'DETERMINADO', '2016-05-02', '2016-05-02', '2016-05-02', 'ACTIVO', 0),
	('5907711', 'TERESA DEL CARMEN', 'AELLOS BOADA', '', '2012-05-20', 'ORDAZ', 'ASD@GMAIL.COM', 'SOLTERO/A', 0, 'ASD', 'ASD', 'ASD', 'UNIVERSITARIO', 'MATEMATICA', 0, 'DOCENTE', 'DOCENT', 'DHORA', 'UNIVERSITARIO', 42, 42.00, 718.50, 5029.50, 20118.00, 'DETERMINADO', '2016-10-10', '2016-10-10', '2016-05-20', 'ACTIVO', 0);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.empresa
CREATE TABLE IF NOT EXISTS `empresa` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `rif` char(10) NOT NULL,
  `direccion` char(50) DEFAULT NULL,
  `tlf1` char(20) DEFAULT NULL,
  `tlf2` char(20) DEFAULT NULL,
  `direcctor` char(50) NOT NULL,
  `cedula` char(20) DEFAULT NULL,
  `logo` char(50) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.empresa: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.forma
CREATE TABLE IF NOT EXISTS `forma` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(50) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.forma: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `forma` DISABLE KEYS */;
INSERT IGNORE INTO `forma` (`codigo`, `descripcion`, `activo`, `fechacreac`) VALUES
	('DIA', 'DIA', 1, '2016-04-24'),
	('FORMULA', 'FORMULA', 1, '2016-04-24'),
	('HORA', 'HORA', 1, '2016-04-24'),
	('MES', 'MES', 1, '2016-04-24'),
	('SALARIO', 'PORCENTAJE SALARIO', 1, '2016-04-24'),
	('SEMANA', 'SEMANA', 1, '2016-04-24'),
	('VALOR', 'VALOR', 1, '2016-04-24');
/*!40000 ALTER TABLE `forma` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.nominacargada
CREATE TABLE IF NOT EXISTS `nominacargada` (
  `numero` int(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `fecha_pago` date NOT NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `porc_salario` decimal(10,2) NOT NULL,
  `porc_deduccion` decimal(10,2) NOT NULL,
  `porc_asignacion` decimal(10,2) NOT NULL,
  `dias` int(10) NOT NULL DEFAULT '1',
  `cod_usuario` char(10) NOT NULL,
  `fecha_creac` date NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.nominacargada: ~14 rows (aproximadamente)
/*!40000 ALTER TABLE `nominacargada` DISABLE KEYS */;
INSERT IGNORE INTO `nominacargada` (`numero`, `descripcion`, `fecha_pago`, `fecha_desde`, `fecha_hasta`, `porc_salario`, `porc_deduccion`, `porc_asignacion`, `dias`, `cod_usuario`, `fecha_creac`) VALUES
	(3, 'TEST 1', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(4, 'ASDASD', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(5, 'ASD', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(6, 'ASD', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(7, 'ASD', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(11, 'TEST 4', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTU', '2016-05-01'),
	(12, 'TEST 2', '2000-01-01', '2000-01-01', '2000-01-01', 60.00, 100.00, 100.00, 30, 'TESTU', '2016-05-01'),
	(13, '', '2016-05-15', '2016-05-15', '2016-05-15', 60.00, 100.00, 100.00, 30, 'TESTU', '2016-05-01'),
	(14, 'ASD', '2016-05-01', '2016-05-01', '2016-05-01', 60.00, 100.00, 100.00, 30, 'TESTU', '2016-05-01'),
	(15, 'TEST CON DOS EMPELADOS', '2016-05-02', '2016-05-02', '2016-05-02', 60.00, 100.00, 100.00, 30, 'TESTU', '2016-05-02'),
	(16, 'NOMINA 60% MES DE ABRIL', '2016-05-29', '2016-05-29', '2016-05-29', 60.00, 100.00, 100.00, 28, 'TESTC', '2016-05-12'),
	(17, 'NOMINA 60% MES DE MAYO', '2016-05-19', '2016-05-19', '2016-05-19', 60.00, 100.00, 100.00, 28, 'TESTC', '2016-05-19');
/*!40000 ALTER TABLE `nominacargada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.nominacargadadetalle
CREATE TABLE IF NOT EXISTS `nominacargadadetalle` (
  `numero` int(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `salario` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`numero`,`ced_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.nominacargadadetalle: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `nominacargadadetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `nominacargadadetalle` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.nominamodel
CREATE TABLE IF NOT EXISTS `nominamodel` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `dias` int(10) NOT NULL,
  `sueldo_porc` int(10) NOT NULL DEFAULT '100',
  `deducc_porc` int(10) NOT NULL DEFAULT '100',
  `deducciones` tinyint(1) NOT NULL DEFAULT '0',
  `asignac_porc` int(10) NOT NULL DEFAULT '100',
  `asignaciones` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.nominamodel: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `nominamodel` DISABLE KEYS */;
INSERT IGNORE INTO `nominamodel` (`codigo`, `descripcion`, `dias`, `sueldo_porc`, `deducc_porc`, `deducciones`, `asignac_porc`, `asignaciones`) VALUES
	('NOM01', 'NOMINA PERSONAL DOCENTE 40% PRIMERA QUINCENA', 30, 40, 0, 0, 0, 0),
	('NOM02', 'NOMINA PERSONAL DOCENTE 60% SEGUNDA QUINCENA CON DEDUCCIONES', 30, 60, 100, 0, 100, 0),
	('NOM3', 'NOMINA PERSONAL DOCENTE 60% SEGUNDA QUINCENA 2', 28, 60, 100, 0, 100, 0);
/*!40000 ALTER TABLE `nominamodel` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.nominaprocesada
CREATE TABLE IF NOT EXISTS `nominaprocesada` (
  `numero` int(10) NOT NULL,
  `descripcion` char(100) NOT NULL,
  `fecha_pago` date NOT NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `porc_salario` decimal(10,2) NOT NULL,
  `porc_deduccion` decimal(10,2) NOT NULL,
  `porc_asignacion` decimal(10,2) NOT NULL,
  `dias` int(10) NOT NULL DEFAULT '1',
  `cod_usuario` char(10) NOT NULL,
  `fecha_creac` date NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.nominaprocesada: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `nominaprocesada` DISABLE KEYS */;
INSERT IGNORE INTO `nominaprocesada` (`numero`, `descripcion`, `fecha_pago`, `fecha_desde`, `fecha_hasta`, `porc_salario`, `porc_deduccion`, `porc_asignacion`, `dias`, `cod_usuario`, `fecha_creac`) VALUES
	(2, 'TEST 1', '2000-01-01', '2000-01-01', '2000-01-01', 40.00, 0.00, 0.00, 30, 'TESTP', '2016-05-03'),
	(17, 'NOMINA 60% CON DEDUCCIONES Y ASIGNACIONES MES DE ABRIL 2016', '2016-05-12', '2016-05-12', '2016-05-12', 60.00, 100.00, 100.00, 28, 'TESTP', '2016-05-12');
/*!40000 ALTER TABLE `nominaprocesada` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.nominaprocesadaemp
CREATE TABLE IF NOT EXISTS `nominaprocesadaemp` (
  `numero` int(10) NOT NULL,
  `ced_emp` char(10) NOT NULL,
  `salario` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`numero`,`ced_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.nominaprocesadaemp: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `nominaprocesadaemp` DISABLE KEYS */;
INSERT IGNORE INTO `nominaprocesadaemp` (`numero`, `ced_emp`, `salario`) VALUES
	(2, '19017070', 4242.00),
	(17, '19017070', 20118.00),
	(17, '20833024', 19160.00),
	(17, '20833032', 19160.00);
/*!40000 ALTER TABLE `nominaprocesadaemp` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.status
CREATE TABLE IF NOT EXISTS `status` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(50) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.status: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.tiposalario
CREATE TABLE IF NOT EXISTS `tiposalario` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` char(50) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.tiposalario: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tiposalario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiposalario` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `user` char(50) NOT NULL,
  `password` char(50) NOT NULL,
  `cedula` char(50) NOT NULL,
  `nombres` char(50) NOT NULL,
  `apellidos` char(50) NOT NULL,
  `cod_perfil` char(10) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.usuario: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT IGNORE INTO `usuario` (`user`, `password`, `cedula`, `nombres`, `apellidos`, `cod_perfil`, `activo`, `fechacreac`) VALUES
	('KEN', '3821e26134a447df7d3af67e93af70fcda209c81', 'KEN', 'KEN', 'KEN', 'KEN', 1, '2016-05-19');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para tabla nomina.usuarioperfil
CREATE TABLE IF NOT EXISTS `usuarioperfil` (
  `codigo` char(10) NOT NULL,
  `descripcion` char(50) NOT NULL,
  `empleados` tinyint(1) NOT NULL,
  `deduccion` tinyint(1) NOT NULL,
  `asignacion` tinyint(1) NOT NULL,
  `nomina` tinyint(1) NOT NULL,
  `reportes` tinyint(1) NOT NULL,
  `consultas` tinyint(1) NOT NULL,
  `usuarios` tinyint(1) NOT NULL,
  `perfiles` tinyint(1) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `fechacreac` date NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla nomina.usuarioperfil: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarioperfil` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarioperfil` ENABLE KEYS */;

-- Volcando estructura para vista nomina.asignacionprocesadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `asignacionprocesadaresumview` (
	`numero` INT(10) NOT NULL,
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`codigo` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`cantidad` INT(10) NOT NULL,
	`valor` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(20,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.asigncargadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `asigncargadaresumview` (
	`numero` INT(10) NOT NULL,
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`codigo` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`cantidad` INT(10) NOT NULL,
	`valor` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(20,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.datosempleado
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `datosempleado` (
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`nombres` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`apellidos` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`rif` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`fechanac` DATE NOT NULL,
	`lugarnac` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`email` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`edocivil` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`numhijos` INT(10) NULL,
	`direccion` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`tlf1` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`tlf2` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`nivelacad` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`espec` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`nivelsup` TINYINT(1) NULL,
	`titulo` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`cod_area` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`cod_clasif` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`nivel` CHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`horas` INT(10) NOT NULL,
	`salariohora` DECIMAL(10,2) NOT NULL,
	`salariodia` DECIMAL(10,2) NOT NULL,
	`salariasem` DECIMAL(10,2) NOT NULL,
	`salariomes` DECIMAL(10,2) NOT NULL,
	`contrato` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`fecha_ingeduc` DATE NULL,
	`fecha_ingeducpriv` DATE NULL,
	`fecha_ing` DATE NULL,
	`status` CHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`antiguedad` INT(10) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.deduccargadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `deduccargadaresumview` (
	`numero` INT(10) NOT NULL,
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`codigo` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`cantidad` INT(10) NOT NULL,
	`valor` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(20,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.deduccionprocesadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `deduccionprocesadaresumview` (
	`numero` INT(10) NOT NULL,
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`codigo` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`cantidad` INT(10) NOT NULL,
	`valor` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(20,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.nominacargadadetalleresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `nominacargadadetalleresumview` (
	`numero` INT(10) NOT NULL,
	`cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`nombres` VARCHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`apellidos` VARCHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`salario` DECIMAL(10,2) NOT NULL,
	`asignacion` DECIMAL(42,2) NULL,
	`total_salario` DECIMAL(43,2) NULL,
	`deduccion` DECIMAL(42,2) NULL,
	`pago` DECIMAL(44,2) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.nominacargadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `nominacargadaresumview` (
	`numero` INT(10) NOT NULL,
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Fecha Pago` DATE NOT NULL,
	`desde` DATE NOT NULL,
	`hasta` DATE NOT NULL,
	`dias` INT(10) NOT NULL,
	`salario` DECIMAL(32,2) NOT NULL,
	`Deducciones` DECIMAL(42,2) NOT NULL,
	`Asignaciones` DECIMAL(42,2) NOT NULL,
	`Total` DECIMAL(44,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.nominaprocesadadetalleresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `nominaprocesadadetalleresumview` (
	`numero` INT(10) NOT NULL,
	`Cedula` CHAR(10) NOT NULL COLLATE 'latin1_swedish_ci',
	`Nombres` VARCHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`Apellidos` VARCHAR(50) NULL COLLATE 'latin1_swedish_ci',
	`salario` DECIMAL(10,2) NOT NULL,
	`asignacion` DECIMAL(42,2) NULL,
	`total_salario` DECIMAL(43,2) NULL,
	`deduccion` DECIMAL(42,2) NULL,
	`pago` DECIMAL(44,2) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista nomina.nominaprocesadaresumview
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `nominaprocesadaresumview` (
	`numero` INT(10) NOT NULL,
	`descripcion` CHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Fecha Pago` DATE NOT NULL,
	`Desde` DATE NOT NULL,
	`Hasta` DATE NOT NULL,
	`dias` INT(10) NOT NULL,
	`salario` VARCHAR(78) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Deducciones` VARCHAR(91) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Asignaciones` VARCHAR(91) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Total` VARCHAR(94) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para procedimiento nomina.antiguedad
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `antiguedad`(IN fecha DATE, OUT anti INT)
BEGIN

SET anti = FLOOR((DATEDIFF(CURDATE(),fecha)/365));

END//
DELIMITER ;

-- Volcando estructura para procedimiento nomina.calc_salario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `calc_salario`(IN pago VARCHAR(50), IN valor DECIMAL(10,2), IN horas INT,OUT shora DECIMAL(10,2), OUT sdia DECIMAL(10,2), OUT ssemana DECIMAL(10,2), OUT smes DECIMAL(10,2))
BEGIN

IF (pago = 'HORA') THEN
SET shora = horas;
SET sdia = (valor*horas)/7;
SET ssemana = sdia * 7;
SET smes = ssemana * 4;

ELSEIF (pago = 'DIA') THEN

SET sdia = valor;
SET ssemana = sdia * 7;
SET smes = ssemana * 4;

ELSEIF (pago = 'SEMANA') THEN

SET sdia = valor / 7;
SET ssemana = sdia * 7;
SET smes = sdia * 30;

ELSEIF (pago = 'MES') THEN

SET sdia = valor / 30;
SET ssemana = sdia * 7;
SET smes = sdia * 30;

END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento nomina.faov
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `faov`(
	IN porcentaje 	DECIMAL(10,2),
	IN lunes 		INT, 
	IN sueldo 		INT, 
	OUT faov DECIMAL(10,2)
)
BEGIN

SET faov = (((sueldo * 12)/52)*(porcentaje/100)) * lunes;

END//
DELIMITER ;

-- Volcando estructura para procedimiento nomina.workdays
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `workdays`(IN E DATE, IN S DATE, OUT days INT)
BEGIN

SET days = 5 * (DATEDIFF(E, S) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(S) + WEEKDAY(E) + 1, 1);

END//
DELIMITER ;

-- Volcando estructura para disparador nomina.empleado_Before_Insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `empleado_Before_Insert` BEFORE INSERT ON `empleado` FOR EACH ROW BEGIN

DECLARE forma CHAR(50);
DECLARE value DECIMAL(10,2);

SELECT formapago AS forma FROM clasificacion WHERE codigo=NEW.cod_clasif into forma;
SELECT valor FROM clasificacion WHERE codigo=NEW.cod_clasif INTO value;

SET NEW.cedula = UPPER(TRIM(NEW.cedula));
SET NEW.nombres = UPPER(TRIM(NEW.nombres));
SET NEW.apellidos = UPPER(TRIM(NEW.apellidos));
SET NEW.rif = UPPER(TRIM(NEW.rif));
SET NEW.fechanac = UPPER(TRIM(NEW.fechanac));
SET NEW.lugarnac = UPPER(TRIM(NEW.lugarnac));
SET NEW.email = TRIM(NEW.email);
SET NEW.edocivil = UPPER(TRIM(NEW.edocivil));
SET NEW.numhijos = UPPER(TRIM(NEW.numhijos));
SET NEW.direccion = UPPER(TRIM(NEW.direccion));
SET NEW.tlf1 = UPPER(TRIM(NEW.tlf1));
SET NEW.tlf2 = UPPER(TRIM(NEW.tlf2));
SET NEW.nivelacad = UPPER(TRIM(NEW.nivelacad));
SET NEW.espec = UPPER(TRIM(NEW.espec));
SET NEW.nivelsup = UPPER(TRIM(NEW.nivelsup));
SET NEW.titulo = UPPER(TRIM(NEW.titulo));
SET NEW.cod_area = UPPER(TRIM(NEW.cod_area));
SET NEW.cod_clasif = UPPER(TRIM(NEW.cod_clasif));
SET NEW.nivel = UPPER(TRIM(NEW.nivel));
SET NEW.nivel = UPPER(TRIM(NEW.nivel));
SET NEW.horas = UPPER(TRIM(NEW.horas));

SET NEW.contrato = UPPER(TRIM(NEW.contrato));
SET NEW.fecha_ingeduc = UPPER(TRIM(NEW.fecha_ingeduc));
SET NEW.fecha_ingeducpriv = UPPER(TRIM(NEW.fecha_ingeducpriv));
SET NEW.fecha_ing = UPPER(TRIM(NEW.fecha_ing));
SET NEW.status = UPPER(TRIM(NEW.status));

CALL antiguedad(NEW.fecha_ing,@anti);
SET NEW.antiguedad = (SELECT @anti);

CALL calc_salario(forma,value,NEW.horas,@hora,@dia,@semana,@mes);
SET NEW.salariohora = (SELECT @hora);
SET NEW.salariodia = (SELECT @dia);
SET NEW.salariasem = (SELECT @semana);
SET NEW.salariomes = (SELECT @mes);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador nomina.empleado_Before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `empleado_Before_update` BEFORE UPDATE ON `empleado` FOR EACH ROW BEGIN

DECLARE forma CHAR(50);
DECLARE value DECIMAL(10,2);

SELECT formapago AS forma FROM clasificacion WHERE codigo=NEW.cod_clasif into forma;
SELECT valor FROM clasificacion WHERE codigo=NEW.cod_clasif INTO value;

SET NEW.cedula = UPPER(TRIM(NEW.cedula));
SET NEW.nombres = UPPER(TRIM(NEW.nombres));
SET NEW.apellidos = UPPER(TRIM(NEW.apellidos));
SET NEW.rif = UPPER(TRIM(NEW.rif));
SET NEW.fechanac = UPPER(TRIM(NEW.fechanac));
SET NEW.lugarnac = UPPER(TRIM(NEW.lugarnac));
SET NEW.email = TRIM(NEW.email);
SET NEW.edocivil = UPPER(TRIM(NEW.edocivil));
SET NEW.numhijos = UPPER(TRIM(NEW.numhijos));
SET NEW.direccion = UPPER(TRIM(NEW.direccion));
SET NEW.tlf1 = UPPER(TRIM(NEW.tlf1));
SET NEW.tlf2 = UPPER(TRIM(NEW.tlf2));
SET NEW.nivelacad = UPPER(TRIM(NEW.nivelacad));
SET NEW.espec = UPPER(TRIM(NEW.espec));
SET NEW.nivelsup = UPPER(TRIM(NEW.nivelsup));
SET NEW.titulo = UPPER(TRIM(NEW.titulo));
SET NEW.cod_area = UPPER(TRIM(NEW.cod_area));
SET NEW.cod_clasif = UPPER(TRIM(NEW.cod_clasif));
SET NEW.nivel = UPPER(TRIM(NEW.nivel));
SET NEW.nivel = UPPER(TRIM(NEW.nivel));
SET NEW.horas = UPPER(TRIM(NEW.horas));

SET NEW.contrato = UPPER(TRIM(NEW.contrato));
SET NEW.fecha_ingeduc = UPPER(TRIM(NEW.fecha_ingeduc));
SET NEW.fecha_ingeducpriv = UPPER(TRIM(NEW.fecha_ingeducpriv));
SET NEW.fecha_ing = UPPER(TRIM(NEW.fecha_ing));
SET NEW.status = UPPER(TRIM(NEW.status));

CALL antiguedad(NEW.fecha_ing,@anti);
SET NEW.antiguedad = (SELECT @anti);

CALL calc_salario(forma,value,NEW.horas,@hora,@dia,@semana,@mes);
SET NEW.salariohora = (SELECT @hora);
SET NEW.salariodia = (SELECT @dia);
SET NEW.salariasem = (SELECT @semana);
SET NEW.salariomes = (SELECT @mes);

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador nomina.nominacargada_before_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nominacargada_before_delete` BEFORE DELETE ON `nominacargada` FOR EACH ROW BEGIN

DELETE FROM nominacargadadetalle WHERE numero = OLD.numero;
DELETE FROM deduccioncargada WHERE numero=OLD.numero;
DELETE FROM asignacioncargada WHERE numero=OLD.numero;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador nomina.nominacargada_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nominacargada_before_insert` BEFORE INSERT ON `nominacargada` FOR EACH ROW BEGIN

SET NEW.descripcion = UPPER(TRIM(NEW.descripcion));
SET NEW.cod_usuario = UPPER(TRIM(NEW.cod_usuario));
SET NEW.fecha_pago = UPPER(TRIM(NEW.fecha_pago));
SET NEW.fecha_desde = UPPER(TRIM(NEW.fecha_desde));
SET NEW.fecha_hasta = UPPER(TRIM(NEW.fecha_hasta));
SET NEW.fecha_creac = UPPER(TRIM(NEW.fecha_creac));

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador nomina.nominaprocesada_before_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nominaprocesada_before_delete` BEFORE DELETE ON `nominaprocesada` FOR EACH ROW BEGIN

DELETE FROM nominaprocesadaemp WHERE numero = OLD.numero;
DELETE FROM deduccionprocesada WHERE numero=OLD.numero;
DELETE FROM asignacionprocesada WHERE numero=OLD.numero;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para vista nomina.asignacionprocesadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `asignacionprocesadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `asignacionprocesadaresumview` AS SELECT numero,ced_emp as cedula,cod_asign as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM asignacionprocesada ;

-- Volcando estructura para vista nomina.asigncargadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `asigncargadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `asigncargadaresumview` AS SELECT numero,ced_emp as cedula,cod_asign as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM asignacioncargada ;

-- Volcando estructura para vista nomina.datosempleado
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `datosempleado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `datosempleado` AS SELECT * FROM empleado ;

-- Volcando estructura para vista nomina.deduccargadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `deduccargadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `deduccargadaresumview` AS SELECT  numero,ced_emp as cedula,cod_deduc as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM deduccioncargada ;

-- Volcando estructura para vista nomina.deduccionprocesadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `deduccionprocesadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `deduccionprocesadaresumview` AS SELECT  numero,ced_emp as cedula,cod_deduc as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM deduccionprocesada ;

-- Volcando estructura para vista nomina.nominacargadadetalleresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `nominacargadadetalleresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `nominacargadadetalleresumview` AS SELECT numero,ced_emp as cedula,
(SELECT nombres FROM empleado WHERE empleado.cedula=nominacargadadetalle.ced_emp) as nombres,
(SELECT apellidos FROM empleado WHERE empleado.cedula=nominacargadadetalle.ced_emp) as apellidos,
salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp) as asignacion,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp AND asignacioncargada.cod_asign=(SELECT codigo FROM asignacionconcepto WHERE asignacionconcepto.codigo = asignacioncargada.cod_asign AND prima=0))+salario as total_salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargadadetalle.numero AND deduccioncargada.ced_emp=nominacargadadetalle.ced_emp ) as deduccion,
(salario+(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp)-(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargadadetalle.numero AND deduccioncargada.ced_emp=nominacargadadetalle.ced_emp)) as pago
FROM nominacargadadetalle ;

-- Volcando estructura para vista nomina.nominacargadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `nominacargadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `nominacargadaresumview` AS select numero,descripcion,fecha_pago as 'Fecha Pago',fecha_desde as desde,fecha_hasta hasta,dias,
(SELECT IFNULL((SELECT SUM(salario) FROM nominacargadadetalle WHERE nominacargadadetalle.numero=nominacargada.numero),0)) as salario,
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargada.numero),0)) as Deducciones, 
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargada.numero),0)) as Asignaciones,
((SELECT IFNULL((SELECT SUM(salario) FROM nominacargadadetalle WHERE nominacargadadetalle.numero=nominacargada.numero),0))+
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargada.numero),0))-
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargada.numero),0))) as Total
FROM nominacargada ;

-- Volcando estructura para vista nomina.nominaprocesadadetalleresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `nominaprocesadadetalleresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `nominaprocesadadetalleresumview` AS SELECT numero,ced_emp as Cedula,
(SELECT nombres FROM empleado WHERE empleado.cedula=nominaprocesadaemp.ced_emp) as Nombres,
(SELECT apellidos FROM empleado WHERE empleado.cedula=nominaprocesadaemp.ced_emp)as Apellidos,
salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp ) as asignacion,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp AND asignacionprocesada.cod_asign=(SELECT codigo FROM asignacionconcepto WHERE asignacionconcepto.codigo = asignacionprocesada.cod_asign AND prima=0))+salario as total_salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesadaemp.numero AND deduccionprocesada.ced_emp=nominaprocesadaemp.ced_emp ) as deduccion,
(salario+(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp)-(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesadaemp.numero AND deduccionprocesada.ced_emp=nominaprocesadaemp.ced_emp)) as pago
FROM nominaprocesadaemp ;

-- Volcando estructura para vista nomina.nominaprocesadaresumview
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `nominaprocesadaresumview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `nominaprocesadaresumview` AS select numero,descripcion,fecha_pago as 'Fecha Pago',fecha_desde as Desde,fecha_hasta Hasta,dias,
FORMAT((SELECT IFNULL((SELECT SUM(salario) FROM nominaprocesadaemp WHERE nominaprocesadaemp.numero=nominaprocesada.numero),0)),2) as salario,
FORMAT((SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesada.numero),0)),2) as Deducciones, 
FORMAT((SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesada.numero),0)),2) as Asignaciones,
FORMAT(((SELECT IFNULL((SELECT SUM(salario) FROM nominaprocesadaemp WHERE nominaprocesadaemp.numero=nominaprocesada.numero),0))+
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesada.numero),0))-
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominaprocesada.numero),0))),2) as Total
FROM nominaprocesada ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
