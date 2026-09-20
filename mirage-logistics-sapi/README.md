# Mirage Logistics System API

System API sobre el sistema de logística de Mirage. Expone el **tiempo de entrega (lead time)** por almacén.

## Para qué sirve

Cuando el storefront necesita decir "te llega en 2 días", alguien tiene que saber desde qué almacén sale el pedido
y cuánto tarda ese almacén. Esta API responde la segunda parte; la primera (qué almacén tiene stock) la responde
`mirage-erp-sapi`. La combinación la hace la capa Process (`mirage-availability-papi`).

## Endpoint

| Método | Ruta | Descripción |
|---|---|---|
| `GET` | `/warehouses/{code}/lead-time` | Días hábiles, transportista y hora de corte del almacén |

## Acceso

Solicita acceso desde esta página (*Request access*). Las credenciales van en los headers `client_id` y `client_secret`.
