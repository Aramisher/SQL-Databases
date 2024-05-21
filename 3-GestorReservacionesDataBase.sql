-- Crear el esquema 'gestor_reservaciones'
CREATE SCHEMA IF NOT EXISTS gestor_reservaciones;
USE gestor_reservaciones;

-- Parte 1: Creación de Tablas

-- Crear la tabla 'Bancos'
CREATE TABLE Bancos (
    IdBanco INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

-- Crear la tabla 'Clientes'
CREATE TABLE Clientes (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255),
    Telefono BIGINT,
    Direccion VARCHAR(255),
    Ciudad VARCHAR(255)
);

-- Crear la tabla 'Tarjetas_de_Credito'
CREATE TABLE Tarjetas_de_Credito (
    NumeroTarjeta BIGINT PRIMARY KEY,
    Tipo VARCHAR(50),
    IdBanco INT,
    CodigoVerificacion INT,
    FechaVencimiento DATE,
    IdCliente INT,
    FOREIGN KEY (IdBanco) REFERENCES Bancos(IdBanco),
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Crear la tabla 'Ciudades'
CREATE TABLE Ciudades (
    Clave INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Estado VARCHAR(255),
    Pais VARCHAR(255)
);

-- Crear la tabla 'Vuelos'
CREATE TABLE Vuelos (
    NumeroVuelo INT AUTO_INCREMENT PRIMARY KEY,
    FechaVuelo DATE NOT NULL,
    HoraSalida TIME,
    HoraLlegada TIME,
    MaximoNumeroPasajeros INT,
    EstadoVuelo VARCHAR(255),
    CiudadOrigen INT,
    CiudadDestino INT,
    FOREIGN KEY (CiudadOrigen) REFERENCES Ciudades(Clave),
    FOREIGN KEY (CiudadDestino) REFERENCES Ciudades(Clave)
);

-- Parte 2: Inserción de Datos

-- Insertar datos en la tabla 'Bancos'
INSERT INTO Bancos (Nombre) VALUES
('Santander'),
('Scotiabank'),
('Bancomer'),
('HSBC'),
('Banamex'),
('Banorte'),
('Banco del Bajío');

-- Insertar datos en la tabla 'Clientes'
INSERT INTO Clientes (Nombre, Apellido, Telefono, Direccion, Ciudad) VALUES
('Carlos', 'Rodríguez', 8115553007, 'CALLE IV #405', 'Monterrey'),
('Francisco', 'Solorzano', 8181010123, 'SENDERO ENCANTADO 2343 COL. HACIENDA', 'Monterrey'),
('Eulalia', 'De La Fuente', 9024568009, 'CONCHOS 23 COL. OBRERA', 'Cancún'),
('Martín', 'Castañeda', 5515016007, 'AVE. CONSTITUCIÓN 2934 DEPT. 52 DEL. JUÁREZ', 'DF'),
('Martha', 'Carrizalez', 6045581009, '2564 AB LINCOLN DR.', 'Houston'),
('María', 'Julianes', 5157132008, 'PERIFÉRICO NORTE 293-F', 'Toluca'),
('Rodrigo', 'Fernández', 4040218007, 'MARÍA CURIE SN ESQ. ALBERT EINSTEIN', 'Guadalajara');

-- Insertar datos en la tabla 'Tarjetas_de_Credito'
INSERT INTO Tarjetas_de_Credito (NumeroTarjeta, Tipo, IdBanco, CodigoVerificacion, FechaVencimiento, IdCliente) VALUES
(5579100000000000, 'MC', 1, 456, '2017-11-01', 1),
(5579100000000001, 'MC', 1, 901, '2020-02-01', 2),
(4555652000000000, 'MC', 2, 442, '2018-04-01', 3),
(5426145000000000, 'VISA', 3, 234, '2019-05-01', 4),
(2020653000000000, 'VISA', 3, 854, '2018-10-01', 5),
(4028000000000000, 'AMEX', 5, 102, '2017-07-01', 6),
(3526122000000000, 'VISA', 4, 215, '2017-12-01', 7);

-- Insertar datos en la tabla 'Ciudades'
INSERT INTO Ciudades (Nombre, Estado, Pais) VALUES
('Monterrey', 'Nuevo León', 'México'),
('Cancún', 'Quintana Roo', 'México'),
('DF', 'Ciudad de México', 'México'),
('Guadalajara', 'Jalisco', 'México'),
('Toluca', 'Estado de México', 'México'),
('Houston', 'Texas', 'USA');

-- Insertar datos en la tabla 'Vuelos'
INSERT INTO Vuelos (FechaVuelo, HoraSalida, HoraLlegada, MaximoNumeroPasajeros, EstadoVuelo, CiudadOrigen, CiudadDestino) VALUES
('2012-08-05', '10:00:00', '12:30:00', 100, 'A TIEMPO', 1, 2),
('2012-08-06', '16:00:00', '17:00:00', 20, 'CANCELADO', 4, 5),
('2012-08-05', '08:00:00', '10:00:00', 50, 'RETRASADO', 3, 6);

-- Actualizar y Eliminar Datos

-- Actualizar el apellido del cliente con IdCliente = 4
UPDATE Clientes SET Apellido = 'Castañeda' WHERE IdCliente = 4;

-- Agregar la colonia a la dirección del cliente con IdCliente = 1
UPDATE Clientes SET Direccion = 'CALLE IV #405 COL. ANÁHUAC' WHERE IdCliente = 1;

-- Eliminar el registro de la tarjeta de crédito de Martín Castañeda
DELETE FROM Tarjetas_de_Credito WHERE IdCliente = 4;

-- Parte 3: Consultas

-- Crear la tabla 'Reservaciones'
CREATE TABLE Reservaciones (
    IdReservacion INT AUTO_INCREMENT PRIMARY KEY,
    NumeroVuelo INT,
    IdCliente INT,
    TipoAsiento VARCHAR(255),
    CostoBoleto DECIMAL(10, 2),
    Comentarios VARCHAR(255),
    FOREIGN KEY (NumeroVuelo) REFERENCES Vuelos(NumeroVuelo),
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Insertar datos en la tabla 'Reservaciones'
INSERT INTO Reservaciones (NumeroVuelo, IdCliente, TipoAsiento, CostoBoleto, Comentarios) VALUES
(1, 1, 'Turista', 1500.00, ''),
(1, 2, 'Primera Clase', 3000.00, ''),
(2, 3, 'Turista', 1200.00, ''),
(3, 4, 'Primera Clase', 3200.00, ''),
(3, 5, 'Turista', 1600.00, ''),
(2, 6, 'Turista', 1100.00, ''),
(1, 7, 'Primera Clase', 2900.00, '');

-- Consultas

-- Lista el nombre, apellido, id de vuelo, nombre de la ciudad origen y destino de todos los clientes para todos los vuelos.
SELECT cl.Nombre, cl.Apellido, v.NumeroVuelo, co.Nombre AS CiudadOrigen, cd.Nombre AS CiudadDestino
FROM Clientes cl
JOIN Reservaciones r ON cl.IdCliente = r.IdCliente
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
JOIN Ciudades co ON v.CiudadOrigen = co.Clave
JOIN Ciudades cd ON v.CiudadDestino = cd.Clave;

-- Lista el apellido y el número de teléfono de los clientes que están en un vuelo con el estado de “Vuelo Cancelado”.
SELECT cl.Apellido, cl.Telefono
FROM Clientes cl
JOIN Reservaciones r ON cl.IdCliente = r.IdCliente
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
WHERE v.EstadoVuelo = 'CANCELADO';

-- Muestra el ingreso total (la suma de todos los costos de boletos) para los vuelos del día 5 de agosto.
SELECT SUM(r.CostoBoleto) AS IngresoTotal
FROM Reservaciones r
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
WHERE v.FechaVuelo = '2012-08-05';

-- Considerando todos los vuelos, muestra el promedio del campo pasajeros máximos.
SELECT AVG(v.MaximoNumeroPasajeros) AS PromedioPasajerosMaximos
FROM Vuelos v;

-- Muestra la cuenta total de pasajeros que hay en cada vuelo, agrupando por vuelo.
SELECT v.NumeroVuelo, COUNT(*) AS TotalPasajeros
FROM Reservaciones r
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
GROUP BY v.NumeroVuelo;

-- Muestra la cuenta total de pasajeros con tipo de asiento primera clase que hay en cada vuelo, agrupando por vuelo.
SELECT v.NumeroVuelo, COUNT(*) AS PasajerosPrimeraClase
FROM Reservaciones r
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
WHERE r.TipoAsiento = 'Primera Clase'
GROUP BY v.NumeroVuelo;

-- Procedimientos Almacenados y Triggers

-- Crear el procedimiento almacenado para aplicar descuento
DELIMITER //
CREATE PROCEDURE aplicarDescuento()
BEGIN
    UPDATE Reservaciones
    SET CostoBoleto = CostoBoleto * 0.9
    WHERE TipoAsiento = 'Turista';
END //
DELIMITER ;

-- Crear el procedimiento almacenado para actualizar comentarios
DELIMITER //
CREATE PROCEDURE actualizarComentarios()
BEGIN
    UPDATE Reservaciones r
    JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
    SET r.Comentarios = 'Avisar inmediatamente de retraso'
    WHERE r.TipoAsiento = 'Primera Clase' AND v.EstadoVuelo = 'Retrasado';
END //
DELIMITER ;

-- Crear el trigger para actualizar comentarios en caso de cambio de fecha de vuelo
DELIMITER //
CREATE TRIGGER triggerCambioFechaVuelo
AFTER UPDATE ON Vuelos
FOR EACH ROW
BEGIN
    IF OLD.FechaVuelo != NEW.FechaVuelo THEN
        UPDATE Reservaciones
        SET Comentarios = 'Avisar de cambio de fecha'
        WHERE NumeroVuelo = NEW.NumeroVuelo;
    END IF;
END //
DELIMITER ;

-- Desactivar temporalmente el modo de actualización segura
SET SQL_SAFE_UPDATES = 0;

-- Ejecutar Procedimientos Almacenados y Triggers

-- Ejecutar el procedimiento para aplicar descuento
CALL aplicarDescuento();

-- Verificar el descuento aplicado
SELECT * FROM Reservaciones WHERE TipoAsiento = 'Turista';

-- Ejecutar el procedimiento para actualizar comentarios
CALL actualizarComentarios();

-- Verificar los comentarios actualizados
SELECT * FROM Reservaciones r
JOIN Vuelos v ON r.NumeroVuelo = v.NumeroVuelo
WHERE v.EstadoVuelo = 'Retrasado' AND r.TipoAsiento = 'Primera Clase';

-- Actualizar la fecha del vuelo para probar el trigger
UPDATE Vuelos
SET FechaVuelo = '2024-12-31' -- Fecha de tu elección
WHERE NumeroVuelo = 1;

-- Consultar las reservaciones del vuelo actualizado para verificar el cambio en los comentarios
SELECT * FROM Reservaciones
WHERE NumeroVuelo = 1;

-- Reactivar el modo de actualización segura
SET SQL_SAFE_UPDATES = 1;
