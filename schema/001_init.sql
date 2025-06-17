-- Crear usuario owner con datos del .env
CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASS}';

-- Crear base de datos y asignar owner
CREATE DATABASE loop_db OWNER ${DB_USER};

-- Conectarse a la base de datos (en psql: \c loop_db)

-- Crear usuario CRUD
CREATE USER crud_user WITH PASSWORD 'crud_pass';


CREATE SEQUENCE company_id_seq;

CREATE TABLE clientes_proveedores (
    id_company VARCHAR(6) PRIMARY KEY DEFAULT (
        SUBSTRING(UPPER(legal_name), 1, 2) || 
        SUBSTRING(tax_id, LENGTH(tax_id)-2, 3) || 
        LPAD(NEXTVAL('company_id_seq')::TEXT, 2, '0')
    ),
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

CREATE SEQUENCE ruta_id_seq;

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY DEFAULT NEXTVAL('ruta_id_seq'),
    supplier_id VARCHAR(6) NOT NULL REFERENCES clientes_proveedores(id_company),
    origin VARCHAR(100) NOT NULL,
    intermediate VARCHAR(100),
    destination VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL REFERENCES services_type_options(name),
    service VARCHAR(50) NOT NULL REFERENCES services_type_options(name),
    cost DECIMAL(10, 2) NOT NULL,
    tax DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL CHECK (total = cost + tax),
    currency VARCHAR(3) NOT NULL REFERENCES currency_options(code),
    transit_time INTEGER,
    validity DATE,
    no_contract BOOLEAN,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

CREATE TABLE incoterms_options (
    id SERIAL PRIMARY KEY,
    code VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE status_options (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE currency_options (
    id SERIAL PRIMARY KEY,
    code VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    symbol VARCHAR(5) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE cotizaciones (
    id VARCHAR(12) PRIMARY KEY,
    id_quote VARCHAR(20) NOT NULL,
    client_id VARCHAR(10) NOT NULL,
    request_date DATE NOT NULL,
    sent_date DATE NOT NULL,
    expiration_date DATE NOT NULL,
    respond_time INTEGER NOT NULL,
    origin_country VARCHAR(50) NOT NULL,
    origin_city VARCHAR(50) NOT NULL,
    origin_address TEXT NOT NULL,
    destination_country VARCHAR(50) NOT NULL,
    destination_city VARCHAR(50) NOT NULL,
    destination_address TEXT NOT NULL,
    service_type VARCHAR(30) NOT NULL,
    cargo_description TEXT NOT NULL,
    incoterm VARCHAR(3) NOT NULL,
    status VARCHAR(50) NOT NULL,
    comments TEXT,
    sales_price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES clientes_proveedores(id_company),
    CONSTRAINT fk_service_type FOREIGN KEY (service_type) REFERENCES services_type_options(type),
    CONSTRAINT fk_incoterm FOREIGN KEY (incoterm) REFERENCES incoterms_options(code),
    CONSTRAINT fk_status FOREIGN KEY (status) REFERENCES status_options(name),
    CONSTRAINT fk_currency FOREIGN KEY (currency) REFERENCES currency_options(code)
);

CREATE TABLE cargos (
    id_cargo INTEGER PRIMARY KEY,
    id_cotizacion VARCHAR(20) NOT NULL,
    id_ruta VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    currency VARCHAR(3) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    tax DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    exchange_rate_quote DECIMAL(10, 2),
    total_quote DECIMAL(10, 2),
    profit_type VARCHAR(20),
    value DECIMAL(10, 2),
    sales_cost DECIMAL(10, 2),
    profit_quote DECIMAL(10, 2),
    real_cost DECIMAL(10, 2),
    iva_real DECIMAL(10, 2),
    total_cost DECIMAL(10, 2),
    total_usd_real DECIMAL(10, 2),
    real_profit DECIMAL(10, 2),
    payment DECIMAL(10, 2),
    earring DECIMAL(10, 2),
    status VARCHAR(50) NOT NULL,
    exchange_rate_invoice DECIMAL(10, 2),
    factura VARCHAR(20)
);













