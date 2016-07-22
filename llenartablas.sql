
USE `nomina`;

################################################# 
#												#
#	SISTEMA DE NOMINA 							#
#												#
#  	Llenado de tablas Base de Datos     		#
#												#
#################################################

#######################
# TABLA Empleado  						SOLO PARA PRUEBA 
#######################
INSERT IGNORE INTO `empleado` (`cedula`, `nombres`, `apellidos`, `rif`, `fechanac`, `lugarnac`, `email`, `edocivil`, `numhijos`, `direccion`, `tlf1`, `tlf2`, `nivelacad`, `espec`, `nivelsup`, `titulo`, `cod_area`, `cod_clasif`, `nivel`, `horas`, `salariohora`, `salariodia`, `salariasem`, `salariomes`, `contrato`, `fecha_ingeduc`, `fecha_ingeducpriv`, `fecha_ing`, `status`, `antiguedad`) VALUES
	('19017070', 'KENDRY', 'FINOL', 'RIF', '2016-10-10', 'LUGARNAC', 'email', 'EDOCIVIL', 0, 'DIRECCION', 'TLF1', 'TLF2', 'NIVELACAD', 'ESPEC', 0, 'TITULO', 'AREA', 'TECHC1', 'DEFAULT', 42, 119.75, 718.50, 5029.50, 20118.00, 'DEFAULT', '2016-10-10', '2016-10-10', '2016-10-10', 'STATUS', 0);

#######################
# TABLA usuario
#######################

INSERT IGNORE INTO `usuario` (`user`, `password`, `nombres`, `apellidos`, `cod_perfil`,`activo`,`fechacreac`) VALUES
	('nazaret', 'nazaret', 'COLEGIO', 'NAZARET', 'PPL', '1', CURDATE());

#######################
# TABLA Empresa
#######################

INSERT IGNORE INTO `empresa` (`codigo`,`descripcion`,`rif`,`direccion`,`tlf1`,`tlf2`,`director`,`cedula`,`logo`) VALUES
('001','A.C U.E. COLEGIO NAZARET PTO. ORDAZ','J-31100340-1','CR. EE.UU. C/C. ARGENTINA URB. CAMPO B DE FERROMINERA','0286-9240940','0286-9225307','ROSA YUDELSY PONCE DE FAJARDO','V-4295912','logo');

#######################
# TABLA Area 
#######################

INSERT IGNORE INTO `area` (`codigo`,`descripcion`,`activo`,`fechacreac`) VALUES
('DOCENT','DIR. DOCENTE',1,CURDATE()),
('ADMINI','ADMINISTRATIVO',1,CURDATE()),
('SUPLTE','SUPLENTE',1,CURDATE()),
('OBRERO','OBRERO',1,CURDATE());


#######################
# TABLA Clasificacion
#######################

INSERT IGNORE INTO `clasificacion` (`codigo`,`descripcion`,`cod_area`,`formapago`,`valor`,`activo`,`fechacreac`) VALUES

('TECHC1','TECNICO SUPERIOR EN EDUCACION CAT 1','DOCENT','HORA',47.40,1,CURDATE()),
('TECMC1','ADMINISTRADORA','DOCENT','MES',13641.60,1,CURDATE());

#######################
# TABLA Formas
#######################

INSERT IGNORE INTO `forma` (`codigo`,`descripcion`,`activo`,`fechacreac`) VALUES

('HORA','HORA',1,CURDATE()),
('DIA','DIA',1,CURDATE()),
('SEMANA','SEMANA',1,CURDATE()),
('MES','MES',1,CURDATE()),
('VALOR','VALOR',1,CURDATE()),
('SALARIO', 'PORCENTAJE SALARIO', 1,CURDATE()),
('FORMULA','FORMULA',1,CURDATE());

#######################
# TABLA Formulas de Deduccion
#######################

INSERT IGNORE INTO `deduccionformula` (`codigo`, `descripcion`, `activo`, `fechacreac`) VALUES
	(1, 'S.S.O', 1, '2016-05-12'),
	(2, 'P.F', 1, '2016-05-20'),
	(3, 'L.P.H', 1, '2016-05-20');

#######################
# TABLA Formulas de Asignacion
#######################

INSERT IGNORE INTO `asignacionformula` (`codigo`, `descripcion`, `activo`, `fechacreac`) VALUES
	(1, 'ANTIGUEDAD', 1, '2016-05-12');

#######################
# TABLA Conceptos de Deduccion
#######################

INSERT IGNORE INTO `deduccionconcepto` (`codigo`, `descripcion`, `forma`, `valor`, `formula`, `activo`, `fechacreac`) VALUES
	('LRPVH', 'LEY DE REGIMEN PRESTACION DE VIVIENDA Y HABITAT', 'FORMULA', 100.00, 'L.P.H', 1, '2016-05-12'),
	('PF', 'PARO FORZOSO', 'FORMULA', 100.00, 'P.F', 1, '2016-05-20'),
	('S.S.O', 'SEGURO SOCIAL OBLIGATORIO', 'FORMULA', 100.00, 'S.S.O', 1, '2016-04-27'),
	('INASXHORA', 'INASISTENCIA POR HORA', 'HORA', 100.00,NULL, 1, '2016-04-27'),
	('INASXDIA', 'INASISTENCIA POR DIA', 'DIA', 100.00,NULL, 1, '2016-04-27'),
	('INASXSEM', 'INASISTENCIA POR SEMANA', 'SEMANA', 100.00,NULL, 1, '2016-04-27'),
	('INASXMES', 'INASISTENCIA POR MES', 'MES', 100.00,NULL, 1, '2016-04-27'),
	('INASXSSO', 'DESCUENTO POR REPOSO', 'DIA', 66.00,NULL, 1, '2016-04-27'),
	('CLUBNAZ', 'CLUB NAZARET', 'VALOR',200,NULL, 1, '2016-04-27'),
	('APORTCUM', 'APORTE ESPECIAL DE CUMPLEAÑEROS', 'VALOR',100,NULL, 1, '2016-04-27'),
	('MENSUALD', 'MENSUALIDAD','VALOR',2400,NULL, 1, '2016-04-27');



#######################
# TABLA Conceptos de Asignacion
#######################

INSERT IGNORE INTO `asignacionconcepto` (`codigo`, `descripcion`,`forma`, `valor`, `formula`, `prima`,`activo`, `fechacreac`) VALUES
	('ANTIGUEDAD', 'PRIMA DE ANTIGUEDAD','FORMULA',40,'ANTIGUEDAD',0,1,'2016-05-12'),
	('PRIMATRANS', 'PRIMA DE TRANSPORTE','VALOR',250,NULL,0,1,'2016-05-12'),
	('PRIMAPOSTG', 'PRIMA DE POST GRADO 20% DE SALARIO MENSUAL','PORCENTAJE SALARIO',20,NULL,0,1,'2016-05-12');
