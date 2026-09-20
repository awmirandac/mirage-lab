# Mirage Availability Process API

Capa **Process**. Responde *"¿está disponible y cuándo llega?"* combinando dos System APIs.

## Regla de negocio

1. Consulta `mirage-erp-sapi` → existencias por almacén.
2. Si no hay existencias en ninguno → `available: false`, sin promesa de entrega.
3. Si hay → elige el almacén con **más existencias** y consulta su lead time en `mirage-logistics-sapi`.
4. Devuelve stock total, almacén elegido y promesa de entrega.

Esta regla es la misma para todos los canales: web, app móvil o call center. Por eso vive aquí y no en el canal.

## Endpoint

| Método | Ruta |
|---|---|
| `GET` | `/availability/{sku}` |

## Dependencias

- `mirage-erp-sapi` v1 (System)
- `mirage-logistics-sapi` v1 (System)

## Acceso

*Request access* desde esta página. Credenciales en los headers `client_id` y `client_secret`.
