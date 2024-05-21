-- Crear la base de datos 'VideoRentalDatabase'
CREATE DATABASE VideoRentalDatabase;
USE VideoRentalDatabase;

-- Crear la tabla 'Cliente' para almacenar información de los clientes
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del cliente
    nombre VARCHAR(255) NOT NULL, -- Nombre del cliente
    direccion VARCHAR(255), -- Dirección del cliente
    telefono VARCHAR(10), -- Teléfono del cliente
    rfc VARCHAR(13) UNIQUE -- RFC del cliente, debe ser único
);

-- Crear la tabla 'Alquiler' para almacenar información de los alquileres
CREATE TABLE Alquiler (
    folio VARCHAR(20) PRIMARY KEY, -- Folio único del alquiler
    cliente_id INT NOT NULL, -- Identificador del cliente que realiza el alquiler
    fecha_emision DATE NOT NULL, -- Fecha de emisión del alquiler

    FOREIGN KEY (cliente_id) REFERENCES Cliente(id) -- Llave foránea que referencia al cliente
);

-- Crear la tabla 'Pelicula' para almacenar información de las películas
CREATE TABLE Pelicula (
    clave_pelicula VARCHAR(20) PRIMARY KEY, -- Clave única de la película
    titulo VARCHAR(255) NOT NULL -- Título de la película
);

-- Crear la tabla 'Detalle_renta' para almacenar detalles de cada transacción de alquiler
CREATE TABLE Detalle_renta(
    transaccion_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la transacción
    folio VARCHAR(20) NOT NULL, -- Folio del alquiler asociado
    clave_pelicula VARCHAR(20) NOT NULL, -- Clave de la película alquilada
    tipo_movimiento ENUM('renta', 'devolucion') NOT NULL, -- Tipo de movimiento, puede ser 'renta' o 'devolucion'
    fecha_renta DATE NOT NULL, -- Fecha de la renta
    fecha_devolucion DATE, -- Fecha de la devolución, puede ser NULL si no se ha devuelto aún
    
    FOREIGN KEY (folio) REFERENCES Alquiler(folio), -- Llave foránea que referencia al alquiler
    FOREIGN KEY (clave_pelicula) REFERENCES Pelicula(clave_pelicula) -- Llave foránea que referencia a la película
);

-- Insertar registros en la tabla 'Cliente'
INSERT INTO Cliente (nombre, direccion, telefono, rfc) VALUES
('Juan Pérez', 'Calle Falsa 123', '555-1010', 'JPER123456789'),
('Ana López', 'Avenida Siempre Viva 45', '555-2020', 'ALOP987654321'),
('Carlos Ruiz', 'Diagonal 678', '555-3030', 'CRUI123890123'),
('Diana Morales', 'Calle Nueva 456', '555-4040', 'DMOR456789012'),
('Eduardo Gómez', 'Calle Vieja 789', '555-5050', 'EGOM567890123'),
('Fátima Blanco', 'Avenida Principal 101', '555-6060', 'FBAL678901234'),
('Gabriel Soto', 'Callejón Secreto 202', '555-7070', 'GSOT789012345'),
('Helena Núñez', 'Avenida Lateral 303', '555-8080', 'HNUN890123456'),
('Iñigo Torres', 'Pasaje Desconocido 404', '555-9090', 'ITOR901234567'),
('Julieta Medina', 'Bulevar del Río 505', '555-0001', 'JMED012345678');

-- Insertar registros en la tabla 'Alquiler'
INSERT INTO Alquiler (folio, cliente_id, fecha_emision) VALUES
('FOL001', 1, '2023-02-01'),
('FOL002', 2, '2023-02-02'),
('FOL003', 3, '2023-02-03'),
('FOL004', 4, '2023-02-04'),
('FOL005', 5, '2023-02-05'),
('FOL006', 6, '2023-02-06'),
('FOL007', 7, '2023-02-07'),
('FOL008', 8, '2023-02-08'),
('FOL009', 9, '2023-02-09'),
('FOL010', 10, '2023-02-10');

-- Insertar registros en la tabla 'Pelicula'
INSERT INTO Pelicula (clave_pelicula, titulo) VALUES
('MOV001', 'El Gran Escape'),
('MOV002', 'La Misión Imposible'),
('MOV003', 'Aventuras en el Espacio'),
('MOV004', 'El Misterio del Tiempo'),
('MOV005', 'Días de Futuro Pasado'),
('MOV006', 'La Última Frontera'),
('MOV007', 'Cazadores de Sombras'),
('MOV008', 'El Laberinto Perdido'),
('MOV009', 'Guerreros del Amanecer'),
('MOV010', 'Viaje al Centro de la Mente');

-- Insertar registros en la tabla 'Detalle_renta'
INSERT INTO Detalle_renta (folio, clave_pelicula, tipo_movimiento, fecha_renta, fecha_devolucion) VALUES
('FOL001', 'MOV001', 'renta', '2023-02-01', '2023-02-08'),
('FOL002', 'MOV002', 'renta', '2023-02-02', '2023-02-09'),
('FOL003', 'MOV003', 'renta', '2023-02-03', '2023-02-10'),
('FOL004', 'MOV004', 'renta', '2023-02-04', '2023-02-11'),
('FOL005', 'MOV005', 'renta', '2023-02-05', '2023-02-12'),
('FOL006', 'MOV006', 'renta', '2023-02-06', '2023-02-13'),
('FOL007', 'MOV007', 'renta', '2023-02-07', '2023-02-14'),
('FOL008', 'MOV008', 'renta', '2023-02-08', '2023-02-15'),
('FOL009', 'MOV009', 'renta', '2023-02-09', '2023-02-16'),
('FOL010', 'MOV010', 'renta', '2023-02-10', '2023-02-17');

-- Consultar todos los registros de la tabla 'Cliente'
SELECT * FROM Cliente;

-- Consultar todos los registros de la tabla 'Alquiler'
SELECT * FROM Alquiler;

-- Consultar todos los registros de la tabla 'Pelicula'
SELECT * FROM Pelicula;

-- Consultar todos los registros de la tabla 'Detalle_renta'
SELECT * FROM Detalle_renta;
