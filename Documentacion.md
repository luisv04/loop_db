# Documentación de la Base de Datos

## 1. Introducción
### 1.1 Objetivo
El objetivo de esta base de datos es almacenar toda la informacion del modelo de negocio de Loop Intermodal, una empresa de logistica.

### 1.2 Alcance
Esta base de datos sera utilizada por un sistema web y nocodb principalmente.

## 2. Contexto del Negocio
### 2.1 Descripción del Negocio
Loop es una empresa de transporte de carga internacional que se destaca por su compromiso en ofrecer soluciones logísticas claras, rápidas y eficientes a través de una plataforma digital avanzada y un equipo de agentes especializados.

Sus servicios abarcan transporte aéreo, terrestre y marítimo, con un enfoque personalizado para cada envío, asegurando así una entrega óptima según las necesidades específicas de cada cliente.

La empresa basa su crecimiento en principios de integridad y satisfacción del cliente, considerándolos fundamentales para el éxito a largo plazo. Además, Loop promueve la seguridad y la responsabilidad en sus operaciones, integrando tecnologías sostenibles y respetuosas con el medio ambiente en todos sus procesos.

### 2.2 Procesos de Negocio
Gestión de Clientes y Proveedores: Administración de información de empresas, contactos y datos fiscales.

Gestión de Rutas: Registro y control de servicios logísticos ofrecidos por los proveedores, incluyendo costos, tiempos de tránsito y condiciones.

Gestión de Cotizaciones: Proceso de creación y seguimiento de propuestas de servicios para clientes potenciales.

Gestión de Cargos: Registro detallado de los servicios específicos requeridos para cada cotización, incluyendo costos y descripciones.

Gestión de Shipments: Control de envíos activos que han sido confirmados por los clientes, derivados de cotizaciones aceptadas.

Gestión de Cargas: Documentación detallada de las unidades de transporte (contenedores, isotanques), incluyendo:
- Identificación de unidades
- Pesos (neto y bruto)
- Información del transportista
- Detalles del equipo de transporte

Gestión de Eventos: Registro cronológico de todos los eventos y actualizaciones de estado durante la ejecución del shipment, con seguimiento por carga.

Gestión de Formatos: Almacenamiento y control de documentación generada, incluyendo:
- Cotizaciones
- Shipments
- Booking lists y confirmaciones
- Documentos de transporte (carta porte, delivery order)
- Documentación de equipos (empty return tank)
- Certificaciones (cargas previas, certificado de lavado)

### 2.3 Usuarios y Roles
Rol: Administrador: control total de la base de datos (yo mismo)
Rol: Supervisor:  Acceso total al CRUD de las tablas.
Rol: Operaciones: Acceso limitado a datos básicos

Usuario: administrador, supervisor_user, operador_user 

## 3. Reglas de Negocio
### 3.1 Reglas Generales
1. Identificación de Clientes y Proveedores:
   - Cada cliente/proveedor debe tener un ID único generado automáticamente
   - El ID debe seguir el formato: XX-XXX-XX donde:
     * XX: Primera letra del nombre legal
     * XXX: Últimos 3 dígitos del número fiscal
     * XX: Número secuencial

2. Gestión de Cotizaciones:
   - Toda cotización debe tener un estado válido (Borrador, Enviada, Aceptada, Rechazada, Vencida, Cancelada)
   - Las cotizaciones vencen automáticamente después de su fecha de expiración
   - El precio de venta debe ser mayor que cero
   - La moneda debe ser una de las configuradas en el sistema (USD, MXN)

3. Gestión de Rutas:
   - Solo los proveedores pueden tener rutas asociadas
   - El costo total debe ser igual a la suma del costo base más impuestos
   - Las rutas inactivas no pueden ser seleccionadas para nuevas cotizaciones
   - El tiempo de tránsito debe ser un número positivo

4. Validaciones de Datos:
   - Los correos electrónicos deben tener un formato válido
   - Los números de teléfono deben seguir el formato internacional
   - Las fechas no pueden ser futuras para registros históricos
   - Los montos monetarios no pueden ser negativos

5. Seguridad y Acceso:
   - Solo los administradores pueden modificar la estructura de la base de datos
   - Los supervisores pueden realizar todas las operaciones CRUD
   - Los operadores tienen acceso limitado a ciertas operaciones
   - Todas las modificaciones deben quedar registradas con usuario y timestamp


### 3.2 Validaciones Específicas
1. Validación de Clientes/Proveedores:
   - El nombre legal no puede estar vacío
   - El número fiscal debe ser único
   - La dirección debe incluir calle, número, ciudad y país
   - El correo electrónico debe ser único por empresa

2. Validación de Cotizaciones:
   - La fecha de solicitud no puede ser posterior a la fecha de envío
   - La fecha de expiración debe ser posterior a la fecha de envío
   - El tiempo de respuesta debe ser un número positivo
   - El país de origen y destino no pueden ser iguales
   - El servicio debe estar activo al momento de la cotización

3. Validación de Rutas:
   - El proveedor debe estar activo
   - La ruta debe tener al menos un punto de origen y destino
   - El costo base debe ser mayor que cero
   - La moneda debe ser una de las configuradas
   - La fecha de validez debe ser futura

4. Validación de Cargos:
   - Cada cargo debe estar asociado a un servicio válido
   - El monto debe ser mayor que cero
   - La moneda debe coincidir con la de la cotización
   - Los impuestos deben calcularse según el país de origen/destino

5. Validación de Shipments:
   - Debe estar basado en una cotización aceptada
   - La fecha de inicio no puede ser anterior a la fecha de aceptación
   - Debe tener al menos una carga asociada
   - El estado debe seguir la secuencia correcta (Pendiente → En Tránsito → Completado)


## 4. Flujo de Datos
### 4.1 Inserción de Datos
- Administrador:
  * Puede insertar todos los tipos de datos
  * Puede modificar la estructura de la base de datos
  * Puede gestionar usuarios y permisos

- Supervisor:
  * Puede insertar y modificar cotizaciones
  * Puede gestionar rutas y servicios
  * Puede actualizar estados de envíos

- Operaciones:
  * Solo puede insertar datos básicos de clientes
  * Puede consultar cotizaciones existentes
  * No puede modificar datos históricos

### 4.2 Actualización de Datos
- Administrador:
  * Actualización de datos maestros (clientes, proveedores, servicios)
  * Modificación de configuraciones del sistema
  * Gestión de usuarios y permisos
  * Corrección de datos históricos

- Supervisor:
  * Actualización de cotizaciones y estados
  * Modificación de rutas y servicios
  * Actualización de precios y costos
  * Gestión de envíos activos

- Operaciones:
  * Actualización de datos básicos de clientes
  * Registro de seguimiento de envíos
  * No puede modificar datos históricos

### 4.3 Consulta de Datos
- Consultas Comunes:
  * Búsqueda de clientes por nombre o ID
  * Historial de cotizaciones por cliente
  * Estado actual de envíos
  * Reportes de costos y precios
  * Análisis de rutas y servicios

- Niveles de Acceso:
  * Administrador: Acceso completo a todos los datos
  * Supervisor: Acceso a datos operativos y reportes
  * Operaciones: Acceso limitado a datos básicos

## 5. Mantenimiento y Mejora
### 5.1 Revisión Periódica
- Frecuencia:
  * Revisión diaria: Validación de backups
  * Revisión semanal: Análisis de rendimiento
  * Revisión mensual: Optimización de índices
  * Revisión trimestral: Auditoría de seguridad

- Responsables:
  * Administrador de Base de Datos: Mantenimiento técnico
  * Supervisor: Validación de datos
  * Equipo de Desarrollo: Implementación de mejoras

### 5.2 Mejoras Futuras
- Implementación de:
  * Sistema de notificaciones automáticas
  * Integración con APIs de seguimiento
  * Dashboard de métricas en tiempo real
  * Sistema de facturación automática
  * Módulo de análisis predictivo
  * App móvil para seguimiento de envíos

## 6. Contacto
- Soporte Técnico:
- Desarrollo:
  * Email: luisangel.vp04@gmail.com
