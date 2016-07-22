
USE `nomina`;

DELIMITER //

################################################# 
#												#
#			SISTEMA DE NOMINA 					#
#												#
#  	  Funciones y Procedimientos	     		#
#												#
#################################################
//
#######################
# 1.1 CREATE PROCEDURE calculo de FAOV
#######################
//
CREATE PROCEDURE IF NOT EXISTS faov 
(
	IN porcentaje 	DECIMAL(10,2),
	IN lunes 		INT, 
	IN sueldo 		INT, 
	OUT faov DECIMAL(10,2)
)

BEGIN

SET faov = (((sueldo * 12)/52)*(porcentaje/100)) * lunes;

END //

#######################
# 1.2 CREATE PROCEDURE Dias de trabajo entre dos fechas
#######################
//
CREATE PROCEDURE IF NOT EXISTS workdays (IN E DATE, IN S DATE, OUT days INT)

BEGIN

SET days = 5 * (DATEDIFF(E, S) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(S) + WEEKDAY(E) + 1, 1);

END //

#######################
# 1.3 CREATE PROCEDURE años de antiguedad
#######################
//
CREATE PROCEDURE IF NOT EXISTS antiguedad (IN fecha DATE, OUT anti INT)

BEGIN

SET anti = FLOOR((DATEDIFF(CURDATE(),fecha)/365));

IF (anti < 0) THEN
SET anti = 0;
END IF;

END //

#######################
# 1.4 CREATE PROCEDURE años de antiguedad
#######################
//
CREATE PROCEDURE IF NOT EXISTS calc_salario (IN pago VARCHAR(50), IN valor DECIMAL(10,2), IN horas INT,OUT shora DECIMAL(10,2), OUT sdia DECIMAL(10,2), OUT ssemana DECIMAL(10,2), OUT smes DECIMAL(10,2))

BEGIN

IF (pago = 'HORA') THEN
SET shora = valor;
SET ssemana = valor * horas;
SET smes = ssemana * 4;
SET sdia = smes/30;
ELSEIF (pago = 'DIA') THEN

SET sdia = valor;
SET ssemana = sdia * 7;
SET smes = sdia * 30;

ELSEIF (pago = 'SEMANA') THEN

SET sdia = valor / 7;
SET ssemana = sdia * 7;
SET smes = sdia * 30;

ELSEIF (pago = 'MES') THEN

SET sdia = valor / 30;
SET ssemana = sdia * 7;
SET smes = sdia * 30;

END IF;

END //

################################################# 
#												#
#			SISTEMA DE NOMINA 					#
#												#
#  	2) -  Disparadores o triggers	     		#
#												#
#################################################
//
#######################
# 2.1 CREATE TRIGGER Before Insert Empleado
#######################
//
CREATE TRIGGER IF NOT EXISTS empleado_Before_Insert BEFORE INSERT ON `empleado` FOR EACH ROW 

BEGIN

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

END //
#######################
# 2.2 CREATE TRIGGER Before Update Empleado
#######################
//
CREATE TRIGGER IF NOT EXISTS empleado_Before_update BEFORE UPDATE ON `empleado` FOR EACH ROW 

BEGIN

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

END //

#######################
# 2.3 CREATE TRIGGER Before Insert Nomina Cargada
#######################
//
CREATE TRIGGER IF NOT EXISTS `nominacargada_before_insert` BEFORE INSERT ON `nominacargada` FOR EACH ROW 

BEGIN

SET NEW.descripcion = UPPER(TRIM(NEW.descripcion));
SET NEW.cod_usuario = UPPER(TRIM(NEW.cod_usuario));
SET NEW.fecha_pago = UPPER(TRIM(NEW.fecha_pago));
SET NEW.fecha_desde = UPPER(TRIM(NEW.fecha_desde));
SET NEW.fecha_hasta = UPPER(TRIM(NEW.fecha_hasta));
SET NEW.fecha_creac = UPPER(TRIM(NEW.fecha_creac));

END //
/*************************  REDEFINIDA POR UNA VISTA QUE CALCULA LAS DEDUCCIONES Y ASIGNACIONES *****************************
#######################
# 2.4 CREATE TRIGGER Before Insert Nomina Cargada detalle
#######################
//
CREATE TRIGGER IF NOT EXISTS `nominacargadadetalle_before_insert` BEFORE INSERT ON `nominacargadadetalle` FOR EACH ROW 

BEGIN

SET NEW.total_deduc = (SELECT IFNULL(SUM(cantidad*valor),0) FROM deduccioncargada WHERE ced_emp=NEW.ced_emp AND numero=NEW.numero);
SET NEW.total_asign = (SELECT IFNULL(SUM(cantidad*valor),0) FROM asignacioncargada WHERE ced_emp=NEW.ced_emp AND numero=NEW.numero);
SET NEW.total_pago = NEW.salario - NEW.total_deduc + NEW.total_asign;

END //
*/
#######################
# 2.4 CREATE TRIGGER Before delete Nomina Cargada
#######################
//
CREATE TRIGGER `nominacargada_before_delete` BEFORE DELETE ON `nominacargada` FOR EACH ROW 

BEGIN

DELETE FROM nominacargadadetalle WHERE numero = OLD.numero;
DELETE FROM deduccioncargada WHERE numero=OLD.numero;
DELETE FROM asignacioncargada WHERE numero=OLD.numero;

END //

#######################
# 2.5 CREATE TRIGGER Before delete Nomina Procesada
#######################
//

CREATE TRIGGER `nominaprocesada_before_delete` BEFORE DELETE ON `nominaprocesada` FOR EACH ROW 

BEGIN

DELETE FROM nominaprocesadaemp WHERE numero = OLD.numero;
DELETE FROM deduccionprocesada WHERE numero=OLD.numero;
DELETE FROM asignacionprocesada WHERE numero=OLD.numero;

END //

#######################
# 2.6 CREATE TRIGGER after update Clasificacion
# !se utiliza para actualizar que al modificar la clasificacion se actualize automaticamente los sueldos!
#######################
//

CREATE TRIGGER `clasificacion_before_update` AFTER UPDATE ON `clasificacion` FOR EACH ROW 

BEGIN

UPDATE empleado SET empleado.cedula=empleado.cedula WHERE empleado.cod_clasif=NEW.codigo;

END //

#######################
# 2.7 CREATE TRIGGER Before insert usuario
#######################
//

CREATE TRIGGER `usuario_before_insert` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
SET NEW.password = (SELECT SHA(NEW.password));
END //

DELIMITER ;

################################################# 
#												#
#			SISTEMA DE NOMINA 					#
#												#
# 3)-	 Creacion de Vistas -VIEW		   		#
#												#
#################################################

#######################
# 3.1 CREATE VIEW Resumen de Nomina  Cargadas en detalle por empelado
#######################
CREATE VIEW IF NOT EXISTS `nominacargadadetalleresumview` AS 
SELECT numero,ced_emp as cedula,
(SELECT nombres FROM empleado WHERE empleado.cedula=nominacargadadetalle.ced_emp) as nombres,
(SELECT apellidos FROM empleado WHERE empleado.cedula=nominacargadadetalle.ced_emp) as apellidos,
salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp) as asignacion,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp AND asignacioncargada.cod_asign=(SELECT codigo FROM asignacionconcepto WHERE asignacionconcepto.codigo = asignacioncargada.cod_asign AND prima=0))+salariogeneral as total_salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargadadetalle.numero AND deduccioncargada.ced_emp=nominacargadadetalle.ced_emp ) as deduccion,
(salario+(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargadadetalle.numero AND asignacioncargada.ced_emp=nominacargadadetalle.ced_emp)-(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargadadetalle.numero AND deduccioncargada.ced_emp=nominacargadadetalle.ced_emp)) as pago
FROM nominacargadadetalle;

#######################
# 3.2 CREATE VIEW Resumen de Nominas  Cargadas totales 
#######################
CREATE VIEW IF NOT EXISTS `nominacargadaresumview` AS 
select numero,descripcion,fecha_pago as 'Fecha Pago',fecha_desde as desde,fecha_hasta hasta,dias,
(SELECT IFNULL((SELECT SUM(salario) FROM nominacargadadetalle WHERE nominacargadadetalle.numero=nominacargada.numero),0)) as salario,
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargada.numero),0)) as Deducciones, 
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargada.numero),0)) as Asignaciones,
((SELECT IFNULL((SELECT SUM(salario) FROM nominacargadadetalle WHERE nominacargadadetalle.numero=nominacargada.numero),0))+
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacioncargada WHERE asignacioncargada.numero=nominacargada.numero),0))-
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominacargada.numero),0))) as Total,
fecha_creac as Generada FROM nominacargada;

#######################
# 3.3 CREATE VIEW Resumen de Asignaciones Cargadas a Empleados
#######################
CREATE VIEW IF NOT EXISTS `asigncargadaresumview` AS 
SELECT numero,ced_emp as cedula,cod_asign as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM asignacioncargada;

#######################
# 3.4 CREATE VIEW Resumen de Deducciones Cargadas a Empleados
#######################
CREATE VIEW IF NOT EXISTS `deduccargadaresumview` AS 
SELECT  numero,ced_emp as cedula,cod_deduc as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM deduccioncargada;

#######################
# 3.5 CREATE VIEW Resumen de Asignaciones Cargadas a Empleados
#######################
CREATE VIEW IF NOT EXISTS `datosempleado` AS SELECT * FROM empleado ;

#######################
# 3.6 CREATE VIEW Resumen Nominas procesadas Totales
#######################
CREATE VIEW IF NOT EXISTS `nominaprocesadaresumview` AS
select numero,descripcion,fecha_pago as 'Fecha Pago',fecha_desde as Desde,fecha_hasta Hasta,dias,
FORMAT((SELECT IFNULL((SELECT SUM(salario) FROM nominaprocesadaemp WHERE nominaprocesadaemp.numero=nominaprocesada.numero),0)),2) as salario,
FORMAT((SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesada.numero),0)),2) as Deducciones, 
FORMAT((SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesada.numero),0)),2) as Asignaciones,
FORMAT(((SELECT IFNULL((SELECT SUM(salario) FROM nominaprocesadaemp WHERE nominaprocesadaemp.numero=nominaprocesada.numero),0))+
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesada.numero),0))-
(SELECT IFNULL((SELECT SUM(valor*cantidad) FROM deduccioncargada WHERE deduccioncargada.numero=nominaprocesada.numero),0))),2) as Total,
fecha_creac as Generada FROM nominaprocesada;

######################
# 3.7 CREATE VIEW Resumen Nominas procesadas Empleado detalle resumen
#######################
CREATE VIEW IF NOT EXISTS `nominaprocesadadetalleresumview` AS
SELECT numero,ced_emp as Cedula,
(SELECT nombres FROM empleado WHERE empleado.cedula=nominaprocesadaemp.ced_emp) as Nombres,
(SELECT apellidos FROM empleado WHERE empleado.cedula=nominaprocesadaemp.ced_emp)as Apellidos,
salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp ) as asignacion,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp AND asignacionprocesada.cod_asign=(SELECT codigo FROM asignacionconcepto WHERE asignacionconcepto.codigo = asignacionprocesada.cod_asign AND prima=0))+salariogeneral as total_salario,
(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesadaemp.numero AND deduccionprocesada.ced_emp=nominaprocesadaemp.ced_emp ) as deduccion,
(salario+(SELECT IFNULL(SUM(valor*cantidad),0) FROM asignacionprocesada WHERE asignacionprocesada.numero=nominaprocesadaemp.numero AND asignacionprocesada.ced_emp=nominaprocesadaemp.ced_emp)-(SELECT IFNULL(SUM(valor*cantidad),0) FROM deduccionprocesada WHERE deduccionprocesada.numero=nominaprocesadaemp.numero AND deduccionprocesada.ced_emp=nominaprocesadaemp.ced_emp)) as pago
FROM nominaprocesadaemp;

######################
# 3.8 CREATE VIEW Resumen asignaciones procesadas
#######################
CREATE VIEW IF NOT EXISTS `asignacionprocesadaresumview` AS
SELECT numero,ced_emp as cedula,cod_asign as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM asignacionprocesada;

######################
# 3.9 CREATE VIEW Resumen deducciones procesadas
#######################
CREATE VIEW IF NOT EXISTS `deduccionprocesadaresumview` AS
SELECT  numero,ced_emp as cedula,cod_deduc as codigo,descripcion,cantidad,valor,(cantidad*valor) as total FROM deduccionprocesada;

######################
# 3.10 CREATE VIEW Resumen anticipos Temporales
#######################
CREATE VIEW IF NOT EXISTS `anticipotempview` AS
SELECT cedula,(SELECT CONCAT_WS(', ',nombres,apellidos) FROM empleado WHERE empleado.cedula=anticipotemp.cedula) as datos,FORMAT(monto,2) as monto FROM anticipotemp;

######################
# 3.11 CREATE VIEW Resumen anticipos Temporales
#######################
CREATE VIEW IF NOT EXISTS `anticipoview` AS
SELECT * FROM anticipo ORDER BY fecha DESC;

######################
# 3.12 CREATE VIEW Resumen detalle de anticipos 
#######################
CREATE VIEW IF NOT EXISTS `anticipodetalleview` AS
SELECT *,(SELECT descripcion FROM anticipo WHERE anticipo.id=anticipodetalle.id) AS descripcion FROM anticipodetalle;