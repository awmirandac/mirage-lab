# Mirage ERP System API

System API que expone el **inventario de minisplits** del ERP de Mirage. Es la capa `system`
del modelo API-led: devuelve el dato crudo del ERP, sin lógica de negocio. La combinación con
cobertura de instalación la resuelve la Process API (`mirage-availability-papi`).

## Qué responde

| Operación | Descripción |
|---|---|
| `GET /products/{sku}/availability` | Existencias del SKU desglosadas por almacén, según el último corte de inventario del ERP |

Un **SKU de Mirage** identifica un modelo de minisplit y sigue el patrón `MIRAGE-<serie>-<capacidad>`.
Ejemplo: `MIRAGE-MS-12K` es la serie MS de 12 000 BTU.

La respuesta indica si hay unidades (`available`), cuántas en total (`quantity`) y el desglose por
almacén (`warehouses[]`). **No determina si el producto es vendible**: eso depende también de que
exista cobertura de instalación en el código postal del cliente.

## Cómo consumirla

1. Registra tu aplicación cliente en **API Manager** y firma el contrato con esta API.
2. Recibirás un `client_id` y un `client_secret`. Ambos viajan como **cabeceras** en cada petición.
3. Respeta el límite de peticiones: ante un `429`, espera los segundos indicados en `Retry-After`.

```
GET /products/MIRAGE-MS-12K/availability
client_id:     <tu client_id>
client_secret: <tu client_secret>
```

## Errores

Todas las respuestas de error comparten el mismo formato (`Error`): un `code` estable para tomar
decisiones, un `message` legible, `timestamp` y `traceId` de correlación.

| HTTP | `code` | Cuándo |
|---|---|---|
| 400 | `INVALID_SKU_FORMAT` | El SKU no cumple el patrón |
| 401 | `UNAUTHORIZED` | Credenciales ausentes o inválidas |
| 404 | `SKU_NOT_FOUND` | El SKU no existe en el catálogo del ERP |
| 429 | `RATE_LIMIT_EXCEEDED` | Se superó la cuota. Reintenta tras `Retry-After` |
| 500 | `ERP_UNAVAILABLE` | El ERP no respondió |

## Probar sin implementar

El activo tiene **Mocking Service** activo: desde la consola de la API puedes ejecutar las
operaciones y recibir los ejemplos declarados en el contrato, sin credenciales reales.

## Versionado

- **API version** (`v1`): cambia solo con rupturas de contrato.
- **Asset version** (`1.x.y`): cambia con cada publicación. PATCH = correcciones; MINOR = añadidos
  compatibles; MAJOR = ruptura (y normalmente nueva API version).

## Contacto

Equipo de Integraciones Mirage — integraciones@avatar-global.com
