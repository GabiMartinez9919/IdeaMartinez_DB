# 💻 Entrega 1

**Autor:** Gabriel Martínez  
**Tema:** Base de datos de e-commerce (Gestión de ventas y stock)  
**Curso:** Comisión 81840

## 🗂️ Descripción
1. Introducción
Este proyecto diseña una base de datos relacional básica de e-commerce que centraliza clientes,
productos y ventas. Permite registrar pedidos con su detalle de ítems, emitir facturas y asociar
pagos. El objetivo es brindar una estructura mínima pero sólida para consultas contables, logísticas
y analíticas.
2. Situación problemática
En la actualidad, muchas pequeñas y medianas empresas que venden productos de manera online
o presencial enfrentan dificultades para gestionar de forma centralizada la información de sus
clientes, productos y ventas. La ausencia de una base de datos estructurada genera duplicidad de
datos, errores en cálculos de facturación y pérdida de trazabilidad. Una base relacional soluciona
estas brechas, garantizando integridad referencial, control y capacidad de análisis.
3. Modelo de negocio
El modelo propuesto corresponde a un comercio electrónico minorista que vende productos
tecnológicos a consumidores finales. El sistema permite administrar clientes, productos y ventas,
desde la creación de pedidos hasta la emisión de facturas y registro de pagos. El flujo del negocio
incluye: registro del cliente, creación de pedido, facturación y pago. Las áreas cubiertas son
comercial (pedidos, productos), contable (facturación, pagos) y analítica (ventas por período o
cliente).
4. Diagrama Entidad-Relación
El diagrama refleja la estructura relacional entre las entidades Clientes, Productos, Pedidos,
Facturas y Pagos. Cada línea representa una relación mediante claves foráneas entre las tablas
principales.
5. Listado de tablas
El esquema está compuesto por las siguientes tablas:
• Clientes
• Productos
• Pedidos
• Pedido_Items
• Facturas
• Pagos

## 📦 Contenido
- `IdeaMartinez.sql` → Script completo de creación de la base de datos.  
- `Diagrama_IdeaMartinez.png` → Diagrama E-R exportado desde MySQL Workbench.
