# Mirage Storefront Experience API

Capa **Experience** para el storefront web (SFCC / SFRA). Un solo consumidor: la cartridge del sitio.

## Para qué sirve

La página de producto no necesita saber de almacenes ni de transportistas: necesita un texto bajo el botón de
compra ("Recíbelo el miércoles 23") y un indicador de stock. Esta API traduce la respuesta de
`mirage-availability-papi` a exactamente eso. Si mañana hay una app móvil, tendrá su propia Experience API
sobre la misma Process API.

## Endpoint

| Método | Ruta |
|---|---|
| `GET` | `/products/{sku}/summary` |

## Dependencias

- `mirage-availability-papi` v1 (Process)

## Acceso

*Request access* desde esta página. Credenciales en los headers `client_id` y `client_secret`.
