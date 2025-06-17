-- Crear usuario owner con datos del .env
CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASS}';

-- Crear base de datos y asignar owner
CREATE DATABASE loop_db OWNER ${DB_USER};

-- Conectarse a la base de datos (en psql: \c loop_db)

-- Crear usuario CRUD
CREATE USER crud_user WITH PASSWORD 'crud_pass';


CREATE TABLE clientes_proveedores (
    id_company VARCHAR(6) PRIMARY KEY,
    class VARCHAR(20) NOT NULL,
    ct VARCHAR(5) NOT NULL,
    name VARCHAR(100) NOT NULL,
    legal_name VARCHAR(100) NOT NULL,
    document_type VARCHAR(20) NOT NULL,
    tax_id VARCHAR(20) NOT NULL,
    country VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    company_number VARCHAR(20) NOT NULL,
    main_contact VARCHAR(100) NOT NULL,
    direct_phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    website VARCHAR(100),
    active BOOLEAN NOT NULL,
    creation_date TIMESTAMP,
    update_date TIMESTAMP
);

CREATE TABLE class_options (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE document_type_options (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE services_type_options (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(30) NOT NULL
);

CREATE TABLE rutas (
    id_ruta VARCHAR(10) PRIMARY KEY,
    number INTEGER NOT NULL,
    supplier_id VARCHAR(10) NOT NULL,
    origin VARCHAR(100) NOT NULL,
    intermediate VARCHAR(100),
    destination VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    service VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    tax DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    transit_time INTEGER,
    validity DATE,
    no_contract BOOLEAN
);

ALTER TABLE rutas
ADD CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES clientes_proveedores(id_company),
ADD CONSTRAINT check_supplier_type CHECK (
    supplier_id IN (
        SELECT id_company 
        FROM clientes_proveedores cp
        JOIN class_options co ON cp.class_id = co.id
        WHERE co.name IN ('Proveedor', 'Cliente/Proveedor')
    )
);






