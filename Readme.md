# 📊 Base de Datos - Loop Intermodal

Este repositorio contiene el esquema y los datos base para los procesos de clientes, proveedores, rutas, cotizaciones y cargos en Loop Intermodal.

## Estructura:
- `schema/` – scripts para crear tablas
- `seed/` – datos iniciales
- `migrations/` – historial de cambios

## Uso
```bash
psql -U postgres -d loop_db -f schema/001_init.sql
psql -U postgres -d loop_db -f seed/sample_data.sql