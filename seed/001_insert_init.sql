-- Insertar opciones de clase
INSERT INTO class_options (name) VALUES ('Cliente'), ('Proveedor'),('Cliente/Proveedor');

-- Insertar opciones de tipo de documento
INSERT INTO document_type_options (name) VALUES ('RFC'), ('NIF'), ('CUIT'),('VAT'),('SSN'),('Otro');

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
