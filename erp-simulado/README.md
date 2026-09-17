# ERP simulado — PostgreSQL en Docker

Hace el papel del ERP de Mirage para el laboratorio (módulo 6 en adelante).

```
docker compose up -d                       # arrancar (la primera vez crea el esquema y los datos)
docker compose ps                          # ver estado (healthy)
docker exec -it mirage-erp-db psql -U mirage -d mirage_erp -c "SELECT * FROM products;"
docker compose down -v                     # apagar y borrar datos
```

Conexión: `localhost:5432` · base `mirage_erp` · usuario `mirage` · contraseña `mirage_dev`.

Tres tablas: `products` (ficha), `warehouses` (almacenes) y `stock` (existencias por almacén).
La consulta de disponibilidad hace JOIN de las tres y devuelve **una fila por almacén** — la
transformación a la forma `Availability` del contrato (almacenes anidados, total sumado) la hace
DataWeave en la Mule app. Ese es el ejercicio.
