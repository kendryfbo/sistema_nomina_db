CREATE DATABASE IF NOT EXISTS `nomina`;
USE `nomina`;

#######################
# 1.1 CREATE TABLE Empleado
#######################

CREATE TABLE IF NOT EXISTS `empleado`
(
	cedula						CHAR(10) 			NOT NULL,
	nombres			  		CHAR(50)			NOT NULL,
	apellidos					CHAR(50)			NOT NULL,
	rif				    		CHAR(50)			NULL,
	fechanac					DATE 					NOT NULL,
	lugarnac					CHAR(50)			NOT NULL,
	email				  		CHAR(50)			NOT NULL,
	edocivil					CHAR(50)			NOT NULL,
	numhijos					INT(10)				NULL,
	direccion					CHAR(50)			NULL,
	tlf1				  		CHAR(50)			NULL,
	tlf2				  		CHAR(50)			NULL,
	nivelacad					CHAR(50)			NULL,
	espec 						CHAR(50)			NULL,	# especialidad
	nivelsup 					TINYINT(1) 		NULL DEFAULT 0,	# estudios nivel superior
	titulo 						CHAR(50)			NULL,	# titulo obtenido
	cod_area					CHAR(10) 			NOT NULL,   # LLAVE FORANEA area.codigo
	cod_clasif	  		CHAR(10) 			NOT NULL,	# LLAVE FORANEA clasif.codigo
	nivel 						CHAR(50) 			NULL,	# pre-escolar, basico(1-6),basico(7-9),diversificado
	horas 						INT(10) 			NULL,	# horas semanales
	salariohora				DECIMAL(10,2) NULL DEFAULT 1,
	salariodia				DECIMAL(10,2)	NOT NULL DEFAULT 1,
	salariasem				DECIMAL(10,2)	NOT NULL DEFAULT 1,
	salariomes				DECIMAL(10,2)	NOT NULL DEFAULT 1,
	contrato 					CHAR(50) 			NOT NULL,	# determinado o indeterminado
	fecha_ingeduc 		DATE 	 				NULL,
	fecha_ingeducpriv	DATE 	 				NULL,
	fecha_ing 				DATE 	 				NULL,
	status						CHAR(50)			NOT NULL, 	# Activo, inactivo, vacaciones, jubilado, reposo
	antiguedad				INT(10)				NULL,
	PRIMARY KEY (cedula)
);

#######################
# 1.2 CREATE TABLE area de trabajo
#######################
CREATE TABLE IF NOT EXISTS `area`
(
	codigo 			CHAR(10) 		NOT NULL,
	descripcion CHAR(50)		NOT NULL,
	activo 			TINYINT(1)  NOT NULL DEFAULT 0,
	fechacreac 	DATE 				NOT NULL,
	PRIMARY KEY (codigo)
);
#######################
# 1.3 CREATE TABLE Clasificacion con respecto al area
#######################
CREATE TABLE IF NOT EXISTS `clasificacion`
(
	codigo 			CHAR(10) 			NOT NULL,
	descripcion	CHAR(100)			NOT NULL,
	cod_area		CHAR(10)			NOT NULL,		#LLAVE FORANEA campo.codigo
	formapago		CHAR(50)			NOT NULL,		# x hora, x dia, x semana, x mes
	valor				DECIMAL(10,2)	NOT NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 	DATE 					NOT NULL,
	PRIMARY KEY (codigo)
);

#######################
# 1.4 CREATE TABLE Conceptos deducciones
#######################
CREATE TABLE IF NOT EXISTS `deduccionconcepto`
(
	codigo			CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	forma			CHAR(50)		NOT NULL,				# % del sueldo, valor fijo
	valor			DECIMAL(10,2)	NOT NULL DEFAULT 1,		# valor en porcentaje o fijo
	formula 		CHAR(50)		NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 		DATE 			NOT NULL,
	PRiMARY KEY(codigo)
);

#######################
# 1.5 CREATE TABLE Conceptos asignaciones
#######################
CREATE TABLE IF NOT EXISTS `asignacionconcepto`
(
	codigo			CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	forma			CHAR(50)		NOT NULL,		# % del sueldo, valor fijo
	valor			DECIMAL(10,2)	NOT NULL DEFAULT 1,		# valor en porcentaje o fijo
	formula 		CHAR(50)		NULL,
	prima 			TINYINT(1)		NOT NULL DEFAULT 0,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 		DATE 			NOT NULL,
	PRiMARY KEY(codigo)
);

#######################
# 1.6 CREATE TABLE deducciones a empleados
#######################
CREATE TABLE IF NOT EXISTS `deduccionemp`
(
	ced_emp		    CHAR(50)		NOT NULL,
	cod_deduccion 	CHAR(10)		NOT NULL,
	tipo 			CHAR(50)		NOT NULL,				# fija o unica
	cantidad		INT(10)			NOT NULL DEFAULT 1,

	PRiMARY KEY(cod_deduccion,ced_emp)
);

#######################
# 1.7 CREATE TABLE asignaciones a empleados
#######################
CREATE TABLE IF NOT EXISTS `asignacionemp`
(

	ced_emp		    CHAR(50)		NOT NULL,
	cod_asignacion 	CHAR(10)		NOT NULL,
	tipo 			CHAR(50)		NOT NULL,
	cantidad		INT(10)			NOT NULL DEFAULT 1,
	PRiMARY KEY(cod_asignacion,ced_emp)
);

#######################
# 1.8 CREATE TABLE Modelos de Nomina
#######################
CREATE TABLE IF NOT EXISTS `nominamodel`
(
	codigo 		    CHAR(10)		NOT NULL,
	descripcion 	CHAR(100)		NOT NULL,
#	tipo 		CHAR(50)		NOT NULL,					# Mensual, quincenal, semanal, diaria , etc...
	dias 		    INT(10)			NOT NULL,
	sueldo_porc	    INT (10)		NOT NULL DEFAULT 100,		# porcentaje de sueldo a cancelar
	deducc_porc	    INT (10)		NOT NULL DEFAULT 100,		# porcentaje de deducciones a cancelar
	deducciones 	TINYINT(1)		NOT NULL DEFAULT 0,
	asignac_porc	INT (10)		NOT NULL DEFAULT 100,		# porcentaje de asignaciones a cancelar
	asignaciones 	TINYINT(1) 		NOT NULL DEFAULT 0,
	PRIMARY KEY (codigo)

);

#######################
# 1.9 CREATE TABLE Nomina cargada
#######################
CREATE TABLE IF NOT EXISTS `nominacargada`
(
	numero			INT(100)		NOT NULL AUTO_INCREMENT,		# Numero de la nomina
	descripcion 	CHAR(100) 		NOT NULL,
	fecha_pago		DATE 			NOT NULL,
	fecha_desde		DATE 			NOT NULL,
	fecha_hasta		DATE 			NOT NULL,
	porc_salario 	DECIMAL(10,2) 	NOT NULL,
	porc_deduccion	DECIMAL(10,2) 	NOT NULL,
	porc_asignacion DECIMAL(10,2) 	NOT NULL,
	dias 			INT(10)			NOT NULL DEFAULT 1,
	cod_usuario		CHAR(10) 		NOT NULL,
	fecha_creac		DATE 			NOT NULL,
	PRIMARY KEY (numero)
);

#######################
# 1.10 CREATE TABLE Nomina cargada Detalle Empleado
#######################
CREATE TABLE IF NOT EXISTS `nominacargadadetalle`
(
	numero			INT(10)			NOT NULL,			# Numero de la nomina
	ced_emp 		CHAR(10)		NOT NULL, 			# id Empleado
	salariogeneral	DECIMAL(10,2) 	NOT NULL DEFAULT 0,
	salario			DECIMAL(10,2) 	NOT NULL DEFAULT 0,

	PRIMARY KEY (numero,ced_emp)
);

#######################
# 1.11 CREATE TABLE deducciones nomina cargada
#######################
CREATE TABLE IF NOT EXISTS `deduccioncargada`
(
	numero			INT(10)			NOT NULL,
	cod_deduc 		CHAR(10)		NOT NULL,
	ced_emp		    CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	cantidad		INT(10)			NOT NULL DEFAULT 1,
	valor			DECIMAL(10,2)		NOT NULL,
	PRIMARY KEY(numero,cod_deduc,ced_emp)
);

#######################
# 1.12 CREATE TABLE asignaciones nomina cargada
#######################
CREATE TABLE IF NOT EXISTS `asignacioncargada`
(
	numero			INT(10)			NOT NULL,
	cod_asign 		CHAR(10)		NOT NULL,
	ced_emp		    CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	prima 			TINYINT(1)		NOT NULL DEFAULT 0,
	cantidad		INT(10)			NOT NULL DEFAULT 1,
	valor			DECIMAL(10,2)	NOT NULL,
	PRIMARY KEY(numero,cod_asign,ced_emp)
);

#######################
# 1.13 CREATE TABLE Nominas Procesadas
#######################
CREATE TABLE IF NOT EXISTS `nominaprocesada`
(
	numero			INT(100)		NOT NULL,		# Numero de la nomina
	descripcion 	CHAR(100) 		NOT NULL,
	fecha_pago		DATE 			NOT NULL,
	fecha_desde		DATE 			NOT NULL,
	fecha_hasta		DATE 			NOT NULL,
	porc_salario 	DECIMAL(10,2) 	NOT NULL,
	porc_deduccion	DECIMAL(10,2) 	NOT NULL,
	porc_asignacion DECIMAL(10,2) 	NOT NULL,
	dias 			INT(10)			NOT NULL DEFAULT 1,
	cod_usuario		CHAR(10) 		NOT NULL,
	fecha_creac		DATE 			NOT NULL,
	PRIMARY KEY (numero)
);
#######################
# 1.14 CREATE TABLE Nominas Procesadas empleado
#######################
CREATE TABLE IF NOT EXISTS `nominaprocesadaemp`
(
	numero			INT(10)			NOT NULL,			# Numero de la nomina
	ced_emp 		CHAR(10)		NOT NULL, 			# id Empleado
	salariogeneral	DECIMAL(10,2) 	NOT NULL DEFAULT 0,
	salario			DECIMAL(10,2) 	NOT NULL DEFAULT 0,

	PRIMARY KEY (numero,ced_emp)
);

#######################
# 1.15 CREATE TABLE deducciones nomina Procesada
#######################
CREATE TABLE IF NOT EXISTS `deduccionprocesada`
(
	numero			INT(10)			NOT NULL,
	cod_deduc 		CHAR(10)		NOT NULL,
	ced_emp		    CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	cantidad		INT(10)			NOT NULL DEFAULT 1,
	valor			DECIMAL(10,2)	NOT NULL,
	PRIMARY KEY(numero,cod_deduc,ced_emp)
);

#######################
# 1.16 CREATE TABLE asignaciones nomina Procesada
#######################
CREATE TABLE IF NOT EXISTS `asignacionprocesada`
(
	numero			INT(10)			NOT NULL,
	cod_asign 		CHAR(10)		NOT NULL,
	ced_emp		    CHAR(10)		NOT NULL,
	descripcion		CHAR(100)		NOT NULL,
	prima 			TINYINT(1)		NOT NULL DEFAULT 0,
	cantidad		INT(10)			NOT NULL DEFAULT 1,
	valor			DECIMAL(10,2)		NOT NULL,
	PRIMARY KEY(numero,cod_asign,ced_emp)
);

#######################
# 1.17 CREATE TABLE status de Empleado
#######################
CREATE TABLE IF NOT EXISTS `status`
(
	codigo 		    CHAR(10)	NOT NULL,
	descripcion 	CHAR(50)	NOT NULL,
	PRIMARY KEY (codigo)
);
#######################
# 1.18 CREATE TABLE usuario
#######################
CREATE TABLE IF NOT EXISTS `usuario`
(
	user 		CHAR(50)	NOT NULL,
	password	CHAR(50)	NOT NULL,
	cedula		CHAR(50)	NOT NULL,
	nombres	    CHAR(50)	NOT NULL,
	apellidos	CHAR(50)	NOT NULL,
	cod_perfil	CHAR(10)	NOT NULL,		# LLAVE FORANEA usuarioperfil.codigo
	activo 		TINYINT(1)	NOT NULL,
	fechacreac 	DATE 		NOT NULL,
	PRIMARY KEY (user)
);

#######################
# 1.19 CREATE TABLE Perfil de usuario
#######################
CREATE TABLE IF NOT EXISTS `usuarioperfil`
(
	codigo  		CHAR(10) 	NOT NULL,
	descripcion     CHAR(50)	NOT NULL,
	empleados		TINYINT(1)	NOT NULL,
	deduccion 		TINYINT(1)	NOT NULL,
	asignacion 		TINYINT(1)	NOT NULL,
	nomina 		    TINYINT(1)	NOT NULL,
	reportes		TINYINT(1)	NOT NULL,
	consultas		TINYINT(1)	NOT NULL,
	usuarios 		TINYINT(1)	NOT NULL,
	perfiles		TINYINT(1)	NOT NULL,
	activo 			TINYINT(1)	NOT NULL,
	fechacreac 		DATE 		NOT NULL,
	PRIMARY KEY (codigo)
);

#######################
# 1.20 CREATE TABLE Datos Empresa
#######################
CREATE TABLE IF NOT EXISTS `empresa`
(
	codigo 			CHAR(10)	NOT NULL,
	descripcion  	CHAR(100) 	NOT NULL,
	rif			    CHAR(10)	NOT NULL,
	direccion		CHAR(200)	NULL,
	tlf1			CHAR(20)	NULL,
	tlf2			CHAR(20)	NULL,
	director		CHAR(50) 	NOT NULL,
	cedula 			CHAR(20)	NULL,
	logo			CHAR(50) 	NOT NULL,
	mensaje		    CHAR(200)	NULL,
	PRIMARY KEY (codigo)
);

#######################
# 1.21 CREATE TABLE Formas de deducciones
#######################
CREATE TABLE IF NOT EXISTS `forma`
(
	codigo			CHAR(10)		NOT NULL,
	descripcion		CHAR(50)		NOT NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 		DATE 			NOT NULL,
	PRiMARY KEY(codigo)
);

#######################
# 1.22 CREATE TABLE Formulas de deducciones
#######################
CREATE TABLE IF NOT EXISTS `deduccionformula`
(
	codigo			INT(10)			NOT NULL AUTO_INCREMENT,
	descripcion		CHAR(50)		NOT NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 		DATE 			NOT NULL,
	PRiMARY KEY(codigo)
);
#######################
# 1.23 CREATE TABLE Formulas de asignaciones
#######################
CREATE TABLE IF NOT EXISTS `asignacionformula`
(
	codigo			INT(10)			NOT NULL AUTO_INCREMENT,
	descripcion		CHAR(50)		NOT NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	fechacreac 		DATE 			NOT NULL,
	PRiMARY KEY(codigo)
);
#######################
# 1.24 CREATE TABLE Tipo de Salario
#######################
CREATE TABLE IF NOT EXISTS `tiposalario`
(
	codigo			INT(10)			NOT NULL AUTO_INCREMENT,
	descripcion		CHAR(50)		NOT NULL,
	activo 			TINYINT(1)		NOT NULL DEFAULT 0,
	PRiMARY KEY(codigo)
);
#######################
# 1.25 CREATE TABLE anticipo
#######################
CREATE TABLE IF NOT EXISTS `anticipo`
(
	id 		    INT(10) 		NOT NULL AUTO_INCREMENT,
	descripcion CHAR(150)		NOT NULL,
	area 		CHAR(100)		NOT NULL,
	dias 		INT(10) 		NULL,
	porcentaje 	DECIMAL(10,2)	NULL,
	fecha 		DATE 			NOT NULL,
	PRIMARY KEY(id)
);
#######################
# 1.26 CREATE TABLE detalleanticipo
#######################
CREATE TABLE IF NOT EXISTS `anticipodetalle`
(
	id 			    INT(10)		    NOT NULL,
	cedula 			CHAR(10)		NOT NULL,
	monto 			DECIMAL(10,2)	NOT NULL,
	procesado 		TINYINT(1) 		NOT NULL DEFAULT 0;
	PRiMARY KEY(id,cedula)
);
#######################
# 1.26 CREATE TABLE detalleanticipo
#######################
CREATE TABLE IF NOT EXISTS `anticipotemp`
(
	cedula 			CHAR(10)		NOT NULL,
	monto 			DECIMAL(10,2)	NOT NULL,
	PRiMARY KEY(cedula)
);
#######################
# 1.27 CREATE TABLE vacacioncargada
#######################
CREATE TABLE IF NOT EXISTS `vacacioncargada`
(
	numero 		    INT(10)		    NOT NULL AUTO_INCREMENT,
	descripcion 	CHAR(250)	    NOT NULL,
	area 			CHAR(10)	    NOT NULL,
	fecha_pago 		DATE  			NOT NULL,
	fecha_creac     DATE 			NOT NULL,
	PRiMARY KEY(numero)
);
#######################
# 1.28 CREATE TABLE vacaciondeducctemp
#######################
CREATE TABLE IF NOT EXISTS `vacaciondeducctemp`
(
	cod_deduccion 	CHAR(10)    NOT NULL,
	cantidad    	CHAR(250)	NOT NULL,
	PRiMARY KEY(cod_deduccion)
);
#######################
# 1.29 CREATE TABLE vacacioncargadadetalle
#######################
CREATE TABLE IF NOT EXISTS `vacacioncargadadetalle`
(
	numero 		    INT(10)		  NOT NULL,
	ced_empleado 	CHAR(10)	  NOT NULL,
	dias_bonovac	INT(10)	      NOT NULL,
    dias_ajuste     INT(10)       NOT NULL,
	monto_bono      DECIMAL(10,2) NOT NULL,
	monto_ajuste    DECIMAL(10,2) NOT NULL,
	PRiMARY KEY(numero)
);
#######################
# 1.30 CREATE TABLE vacacioncargadadeduccion
#######################
CREATE TABLE IF NOT EXISTS `vacacioncargadadeduccion`
(
    numero 		    INT(10)		  NOT NULL,
    ced_empleado    CHAR(10)      NOT NULL,
	cod_deduccion 	CHAR(10)	  NOT NULL,
    descripcion     CHAR(250)     NOT NULL,
	cantidad    	CHAR(250)	  NOT NULL,
    monto           DECIMAL(10,2) NOT NULL,
	PRiMARY KEY(numero,ced_empleado,cod_deduccion)
);

#######################
# 1.31 CREATE TABLE vacacionprocesada
#######################
CREATE TABLE IF NOT EXISTS `vacacionprocesada`
(
	numero 		    INT(10)		    NOT NULL AUTO_INCREMENT,
	descripcion 	CHAR(250)	    NOT NULL,
	area 			CHAR(10)	    NOT NULL,
	fecha_pago 		DATE  			NOT NULL,
	fecha_creac     DATE 			NOT NULL,
	PRiMARY KEY(numero)
);
#######################
# 1.32 CREATE TABLE vacacionprocesadadetalle
#######################
CREATE TABLE IF NOT EXISTS `vacacionprocesadadetalle`
(
	numero 		    INT(10)		  NOT NULL,
	ced_empleado 	CHAR(10)	  NOT NULL,
	dias_bonovac	INT(10)	      NOT NULL,
    dias_ajuste     INT(10)       NOT NULL,
	monto_bono      DECIMAL(10,2) NOT NULL,
	monto_ajuste    DECIMAL(10,2) NOT NULL,
	PRiMARY KEY(numero)
);
#######################
# 1.33 CREATE TABLE vacacionprocesadadeduccion
#######################
CREATE TABLE IF NOT EXISTS `vacacionprocesadadeduccion`
(
    numero 		    	INT(10)		  	NOT NULL AUTO_INCREMENT,
    ced_empleado    CHAR(10)      NOT NULL,
		cod_deduccion 	CHAR(10)	  	NOT NULL,
    descripcion     CHAR(250)     NOT NULL,
		cantidad    		CHAR(250)	  	NOT NULL,
    monto           DECIMAL(10,2) NOT NULL,
	PRiMARY KEY(numero,ced_empleado,cod_deduccion)
);

#######################
# 1.34 CREATE TABLE aportefaov
#######################
CREATE TABLE IF NOT EXISTS `aportefaov`
(
    numero 		    	INT(10)		  	NOT NULL AUTO_INCREMENT,
    ced_empleado    CHAR(10)      NOT NULL,
		descripcion	 		CHAR(250)	  	NOT NULL,
    aporte_emp      DECIMAL(10,2) NOT NULL,
		aporte_patron   DECIMAL(10,2)	NOT NULL,
	  fecha_creac    	DATE				  NULL,
	PRiMARY KEY(numero,ced_empleado)
);

/*

#########################################################################################
# 2.0						Definicion de FOREIGN KEY - Llaves Foraneas						#
#########################################################################################
#######################
# 2.1 FOREIGN KEY TABLE empleado
#######################
ALTER TABLE `empleado` ADD CONSTRAINT `fk_empleado_area` FOREIGN KEY (cod_area) REFERENCES `area`(codigo);
ALTER TABLE `empleado` ADD CONSTRAINT `fk_empleado_clasificacion` FOREIGN KEY (cod_clasif) REFERENCES `clasificacion`(codigo);

#######################
# 2.2 FOREIGN KEY TABLE clasificacion
#######################

ALTER TABLE `clasificacion` ADD CONSTRAINT `fk_clasificacion_area` FOREIGN KEY (cod_area) REFERENCES `area`(codigo);
ALTER TABLE `clasificacion` ADD CONSTRAINT `fk_clasificacion_forma` FOREIGN KEY (cod_area) REFERENCES `forma`(codigo);

*/
