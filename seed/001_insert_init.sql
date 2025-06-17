-- Insertar opciones de clase
INSERT INTO class_options (name) VALUES ('Cliente'), ('Proveedor'),('Cliente/Proveedor');

-- Insertar opciones de tipo de documento
INSERT INTO document_type_options (name) VALUES 
('RFC'), ('NIF'), ('CUIT'),('VAT'),('SSN'),('Otro');

-- Insertar opciones de tipo de servicio
INSERT INTO services_type_options (name, type) VALUES 
    ('Sencillo', 'Terrestre'),
    ('Full', 'Terrestre'),
    ('Caja seca 20', 'Terrestre'),
    ('Caja seca 40', 'Terrestre'),
    ('Caja seca 53', 'Terrestre'),
    ('Caja refeer 20', 'Terrestre'),
    ('Caja refeer 40', 'Terrestre'),
    ('Caja refeer 53', 'Terrestre'),
    ('Contenedor 20" Dry', 'Maritimo'),
    ('Contenedor 20" Open Top', 'Maritimo'),
    ('Contenedor 40" Dry', 'Maritimo'),
    ('Contenedor 40" Dry HC', 'Maritimo'),
    ('Contenedor 40" Refeer', 'Maritimo'),
    ('Volumen LxAxA', 'Aereo'),
    ('Otro', 'Multimodal'),
    ('Otro', 'Otro'),
    ('Drayage Full - General Cargo', 'Terrestre'),
    ('Drayage Single - General Cargo', 'Terrestre'),
    ('Drayage Full - Hazmat Cargo', 'Terrestre'),
    ('Drayage Single - Hazmat Cargo', 'Terrestre'),
    ('Drayage Full - Reefer Cargo', 'Terrestre'),
    ('Drayage Single - Reefer Cargo', 'Terrestre'),
    ('Consolidado', 'Consolidado'),
    ('Export services', 'Custom Agent'),
    ('Entry Service', 'Custom Agent'),
    ('Entry Service - Add Invoices', 'Custom Agent');


-- Insertar opciones de incoterms
INSERT INTO incoterms_options (code, name) VALUES
    ('EXW', 'Ex Works (En fábrica)'),
    ('FCA', 'Free Carrier'),
    ('CPT', 'Carriage Paid To'),
    ('CIP', 'Carriage and Insurance Paid to'),
    ('DAP', 'Delivered at Place'),
    ('DPU', 'Delivered at Place Unloaded'),
    ('DDP', 'Delivered Duty Paid'),
    ('FAS', 'Free Alongside Ship'),
    ('FOB', 'Free On Board');

    -- Insertar estados básicos para cotizaciones
INSERT INTO status_options (name, description) VALUES
    ('Borrador', 'Cotización en proceso de creación'),
    ('Enviada', 'Cotización enviada al cliente'),
    ('Aceptada', 'Cotización aceptada por el cliente'),
    ('Rechazada', 'Cotización rechazada por el cliente'),
    ('Vencida', 'Cotización fuera de su período de validez'),
    ('Cancelada', 'Cotización cancelada por el vendedor');

    -- Insertar monedas básicas
INSERT INTO currency_options (code, name, symbol) VALUES
    ('USD', 'Dólar Estadounidense', '$'),
    ('MXN', 'Peso Mexicano', '$');

    