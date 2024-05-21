CREATE DATABASE IF NOT EXISTS GestorCarreras;
USE GestorCarreras;

-- Crear la tabla 'carrera' para almacenar las carreras
CREATE TABLE `carrera` (
  `id_carrera` int(11) NOT NULL AUTO_INCREMENT, -- Identificador único de la carrera
  `id_ronda` int(11) NOT NULL, -- Identificador de la ronda asociada
  `num_vueltas` int(11) DEFAULT NULL, -- Número de vueltas de la carrera
  PRIMARY KEY (`id_carrera`), -- Llave primaria de la tabla
  KEY `fk_carrera_ronda1_idx` (`id_ronda`) -- Índice para la llave foránea 'id_ronda'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'carrera'
INSERT INTO `carrera` VALUES
(1,1,1),
(2,2,3),
(3,3,2),
(4,4,2),
(5,5,2),
(6,6,2);

-- Crear la tabla 'estadistica_carrera' para almacenar estadísticas de las carreras
CREATE TABLE `estadistica_carrera` (
  `no_vuelta` int(11) NOT NULL, -- Número de vuelta
  `id_carrera` int(11) NOT NULL, -- Identificador de la carrera asociada
  `no_registro` int(11) NOT NULL, -- Número de registro del participante
  `posicion` int(11) DEFAULT NULL, -- Posición del participante en la vuelta
  `tiempo` time DEFAULT NULL, -- Tiempo de la vuelta
  PRIMARY KEY (`no_vuelta`,`id_carrera`,`no_registro`), -- Llave primaria compuesta
  KEY `fk_estadistica_carrera_carrera1_idx` (`id_carrera`) -- Índice para la llave foránea 'id_carrera'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'estadistica_carrera'
INSERT INTO `estadistica_carrera` VALUES
(1,1,1003,1,'05:15:00'),
(1,1,1004,2,'05:35:00'),
(1,2,2001,1,'01:01:00'),
(1,2,2002,2,'01:05:00'),
(1,2,2003,3,'01:07:00'),
(1,2,2005,4,'01:10:00'),
(1,3,2001,2,'01:23:00'),
(1,3,2002,3,'01:25:00'),
(1,3,2003,1,'01:20:00'),
(1,3,2005,4,'01:27:00'),
(1,5,3001,1,'03:30:00'),
(1,5,3002,2,'03:32:00'),
(1,6,3001,1,'03:03:00'),
(1,6,3002,2,'03:08:00'),
(2,2,2001,4,'01:24:00'),
(2,2,2002,3,'01:23:00'),
(2,2,2003,2,'01:18:00'),
(2,2,2005,1,'01:15:00'),
(2,3,2001,4,'01:10:00'),
(2,3,2002,3,'01:08:00'),
(2,3,2003,2,'01:03:00'),
(2,3,2005,1,'00:59:00'),
(2,5,3001,2,'03:21:00'),
(2,5,3002,1,'03:18:00'),
(2,6,3001,2,'03:15:00'),
(2,6,3002,1,'03:01:00');

-- Crear la tabla 'participante' para almacenar información de los participantes
CREATE TABLE `participante` (
  `id_participante` int(11) NOT NULL AUTO_INCREMENT, -- Identificador único del participante
  `nombre` varchar(80) NOT NULL, -- Nombre del participante
  `apellido` varchar(80) NOT NULL, -- Apellido del participante
  `id_tipo_participante` int(11) NOT NULL, -- Identificador del tipo de participante
  `id_manager` int(11) DEFAULT NULL, -- Identificador del manager asociado
  PRIMARY KEY (`id_participante`), -- Llave primaria de la tabla
  KEY `fk_participante_tipo_participante_idx` (`id_tipo_participante`), -- Índice para la llave foránea 'id_tipo_participante'
  KEY `fk_participante_participante1_idx` (`id_manager`) -- Índice para la llave foránea 'id_manager'
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'participante'
INSERT INTO `participante` VALUES
(28,'Emmet','McBean',2,NULL),
(38,'Karl','Doe',1,28),
(39,'Mike','Geller',1,45),
(40,'Ron','Zimmerman',1,28),
(41,'Zach','Merker',1,45),
(42,'Ellie','Worth',1,46),
(43,'Joe','Wegner',1,46),
(44,'Dan','McDonald',1,45),
(45,'Melanie','Parties',2,NULL),
(46,'Alan','Oze',2,NULL);

-- Crear la tabla 'registro' para almacenar registros de participación en torneos
CREATE TABLE `registro` (
  `no_registro` int(11) NOT NULL, -- Número de registro
  `id_participante` int(11) NOT NULL, -- Identificador del participante asociado
  `id_torneo` int(11) NOT NULL, -- Identificador del torneo asociado
  `estatus_registro` varchar(60) DEFAULT NULL, -- Estado del registro
  PRIMARY KEY (`no_registro`,`id_participante`,`id_torneo`), -- Llave primaria compuesta
  KEY `fk_registro_participante1_idx` (`id_participante`), -- Índice para la llave foránea 'id_participante'
  KEY `fk_registro_torneo1_idx` (`id_torneo`) -- Índice para la llave foránea 'id_torneo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'registro'
INSERT INTO `registro` VALUES
(1001,38,1,'Retiro - Falla de auto'),
(1002,39,1,'No se presentó'),
(1003,40,1,'Corrió - Ganó'),
(1004,41,1,'Corrió - Perdió'),
(2001,38,2,'Corrió - Perdió'),
(2002,39,2,'Corrió - Perdió'),
(2003,40,2,'Corrió - Perdió'),
(2004,41,2,'Retiro - Accidente'),
(2005,42,2,'Corrió - Ganó'),
(3000,39,3,'Retiro - Accidente'),
(3000,40,3,'Retiro - Accidente'),
(3001,38,3,'Corrió - Perdió'),
(3001,41,3,'Corrió - Perdió'),
(3002,42,3,'Corrió - Ganó'),
(3002,43,3,'Corrió - Ganó');

-- Crear la tabla 'ronda' para almacenar las rondas de los torneos
CREATE TABLE `ronda` (
  `id_ronda` int(11) NOT NULL AUTO_INCREMENT, -- Identificador único de la ronda
  `num_ronda` int(11) NOT NULL, -- Número de ronda
  `id_torneo` int(11) NOT NULL, -- Identificador del torneo asociado
  PRIMARY KEY (`id_ronda`), -- Llave primaria de la tabla
  KEY `fk_ronda_torneo1_idx` (`id_torneo`) -- Índice para la llave foránea 'id_torneo'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'ronda'
INSERT INTO `ronda` VALUES
(1,1,1),
(2,1,2),
(3,2,2),
(4,1,3),
(5,2,3),
(6,3,3);

-- Crear la tabla 'tipo_participante' para definir los tipos de participantes
CREATE TABLE `tipo_participante` (
  `id_tipo_participante` int(11) NOT NULL AUTO_INCREMENT, -- Identificador único del tipo de participante
  `desc_tipo_participante` varchar(45) NOT NULL, -- Descripción del tipo de participante
  PRIMARY KEY (`id_tipo_participante`) -- Llave primaria de la tabla
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'tipo_participante'
INSERT INTO `tipo_participante` VALUES
(1,'Corredor'),
(2,'Manager');

-- Crear la tabla 'torneo' para almacenar información de los torneos
CREATE TABLE `torneo` (
  `id_torneo` int(11) NOT NULL AUTO_INCREMENT, -- Identificador único del torneo
  `desc_torneo` varchar(45) NOT NULL, -- Descripción del torneo
  PRIMARY KEY (`id_torneo`) -- Llave primaria de la tabla
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Insertar datos en la tabla 'torneo'
INSERT INTO `torneo` VALUES
(1,'Torneo Primavera 2023'),
(2,'Torneo Verano 2023'),
(3,'Torneo Otoño 2023');

-- Número de carreras perdidas de Karl Doe
SELECT COUNT(*) AS carreras_perdidas
FROM registro
WHERE id_participante = (
  SELECT id_participante
  FROM participante
  WHERE nombre = 'Karl' AND apellido = 'Doe'
) AND estatus_registro LIKE 'Corrió - Perdió';

-- Ganador de la tercera ronda del torneo Copa Dorada y su manager.
-- Primero obtenemos el ID de la carrera de la tercera ronda del torneo Copa Dorada
SELECT id_carrera
FROM carrera
WHERE id_ronda = (
  SELECT id_ronda
  FROM ronda
  WHERE id_torneo = (
    SELECT id_torneo
    FROM torneo
    WHERE desc_torneo = 'Copa Dorada'
  ) AND num_ronda = 3
);

-- Ahora obtenemos el nombre del ganador y su manager
SELECT p.nombre, p.apellido, m.nombre AS nombre_manager, m.apellido AS apellido_manager
FROM estadistica_carrera ec
JOIN registro r ON ec.no_registro = r.no_registro
JOIN participante p ON r.id_participante = p.id_participante
LEFT JOIN participante m ON p.id_manager = m.id_participante
WHERE ec.id_carrera = (
  SELECT id_carrera
  FROM carrera
  WHERE id_ronda = (
    SELECT id_ronda
    FROM ronda
    WHERE id_torneo = (
      SELECT id_torneo
      FROM torneo
      WHERE desc_torneo = 'Copa Dorada'
    ) AND num_ronda = 3
  )
) AND ec.posicion = 1;

-- Los nombres de los torneos en los que ha participado Mike Geller.
SELECT t.desc_torneo
FROM registro r
JOIN torneo t ON r.id_torneo = t.id_torneo
WHERE r.id_participante = (
  SELECT id_participante
  FROM participante
  WHERE nombre = 'Mike' AND apellido = 'Geller'
);

-- La cantidad de vueltas de la primera carrera de la primera ronda del torneo Speed Track.
SELECT c.num_vueltas
FROM carrera c
JOIN ronda r ON c.id_ronda = r.id_ronda
WHERE r.id_torneo = (
  SELECT id_torneo
  FROM torneo
  WHERE desc_torneo = 'Speed Track'
) AND r.num_ronda = 1
ORDER BY c.id_carrera
LIMIT 1;

-- Los números de registro de los participantes inscritos en el torneo Copa Dorada.
SELECT no_registro
FROM registro
WHERE id_torneo = (
  SELECT id_torneo
  FROM torneo
  WHERE desc_torneo = 'Copa Dorada'
);
