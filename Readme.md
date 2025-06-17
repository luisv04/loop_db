# 📊 Base de Datos - Loop

Este repositorio contiene el esquema y los datos base para los procesos de clientes, productos y cotizaciones en Jasu Industries.

## Estructura:
- `schema/` – scripts para crear tablas
- `seed/` – datos iniciales
- `migrations/` – historial de cambios

## Uso
```bash
psql -U postgres -d jasu_db -f schema/001_init.sql
psql -U postgres -d jasu_db -f seed/sample_data.sql