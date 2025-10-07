-- ====== RESET Y CREACIÓN ======
DROP DATABASE IF EXISTS idea_martinez;
CREATE DATABASE idea_martinez CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE idea_martinez;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE clientes (
  id_cliente   INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  apellido     VARCHAR(100),
  email        VARCHAR(150),
  activo       BOOLEAN DEFAULT TRUE,
  fecha_alta   DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_clientes_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE productos (
  id_producto  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(150) NOT NULL,
  precio_venta DECIMAL(12,2) DEFAULT 0,
  activo       BOOLEAN DEFAULT TRUE,
  fecha_alta   DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pedidos (
  id_pedido     INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente    INT NOT NULL,
  fecha_pedido  DATETIME DEFAULT CURRENT_TIMESTAMP,
  estado        VARCHAR(30) DEFAULT 'nuevo',
  total         DECIMAL(14,2) DEFAULT 0,
  CONSTRAINT fk_pedidos_cliente
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pedido_items (
  id_item         INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido       INT NOT NULL,
  id_producto     INT NOT NULL,
  cantidad        DECIMAL(12,3) NOT NULL,
  precio_unitario DECIMAL(12,2) NOT NULL,
  subtotal        DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_pi_pedido
    FOREIGN KEY (id_pedido)   REFERENCES pedidos(id_pedido)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_pi_producto
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_pedido_items_pedido   ON pedido_items(id_pedido);
CREATE INDEX idx_pedido_items_producto ON pedido_items(id_producto);

CREATE TABLE facturas (
  id_factura      INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido       INT NOT NULL,
  fecha_emision   DATETIME DEFAULT CURRENT_TIMESTAMP,
  tipo_comprobante VARCHAR(30),
  total           DECIMAL(14,2) DEFAULT 0,
  CONSTRAINT fk_facturas_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pagos (
  id_pago      INT AUTO_INCREMENT PRIMARY KEY,
  id_factura   INT NOT NULL,
  fecha_pago   DATETIME DEFAULT CURRENT_TIMESTAMP,
  metodo_pago  VARCHAR(50),
  monto        DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_pagos_factura
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;

-- ====== SEMILLAS MÍNIMAS ======
INSERT INTO clientes (nombre, apellido, email) VALUES
('Ana','Pérez','ana@example.com'),
('Bruno','Gómez','bruno@example.com');

INSERT INTO productos (nombre, precio_venta) VALUES
('Teclado', 35000.00),
('Mouse',   25000.00);

INSERT INTO pedidos (id_cliente, estado, total) VALUES
(1, 'procesando', 60000.00);

INSERT INTO pedido_items (id_pedido, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 35000.00, 35000.00),
(1, 2, 1, 25000.00, 25000.00);

INSERT INTO facturas (id_pedido, tipo_comprobante, total) VALUES
(1, 'B', 60000.00);

INSERT INTO pagos (id_factura, metodo_pago, monto) VALUES
(1, 'Tarjeta', 60000.00);

-- ====== VALIDACIONES QUE DEBEN MOSTRAR FILAS ======
SELECT DATABASE() AS base_actual;

SHOW TABLES;

SELECT * FROM clientes;              -- Deberías ver Ana y Bruno
SELECT * FROM productos;             -- Teclado y Mouse
SELECT * FROM pedidos;               -- 1 pedido
SELECT * FROM pedido_items;          -- 2 items
SELECT * FROM facturas;              -- 1 factura
SELECT * FROM pagos;                 -- 1 pago

-- Join de control
SELECT p.id_pedido, c.nombre AS cliente, p.estado, p.total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente;

SELECT i.id_pedido, pr.nombre AS producto, i.cantidad, i.precio_unitario, i.subtotal
FROM pedido_items i
JOIN productos pr ON pr.id_producto = i.id_producto;
