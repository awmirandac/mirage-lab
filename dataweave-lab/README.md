# Laboratorio DataWeave — Módulo 1

Diez ejercicios con datos de Mirage. Se hacen en el **DataWeave Playground**:
https://dataweave.mulesoft.com

**Cómo trabajar cada uno**

1. Abre el Playground. Panel izquierdo = *Input* (payload), centro = *Script*, derecha = *Output*.
2. Pega el contenido de `entradas/<n>-….json|xml|csv` en el Input. Si es XML o CSV, cambia el
   tipo de entrada en el desplegable del Input (por defecto es JSON).
3. Escribe el script hasta que el Output coincida con el esperado.
4. **Solo entonces** abre `soluciones/<n>-….dwl` y compara. Si tu versión es distinta y funciona,
   también vale — pero lee la solución: suele haber un atajo idiomático.

Regla del módulo: **15 minutos al día**, un ejercicio o dos. No hace falta terminarlos de golpe.

---

## 01 · Renombrar y anidar — `entradas/01-producto-erp.json`

El ERP devuelve campos en mayúsculas y planos. El storefront quiere nombres legibles y el precio
anidado.

Salida esperada:
```json
{ "sku": "MIRAGE-MS-12K", "name": "Minisplit Inverter MS 12,000 BTU", "capacityBtu": 12000,
  "active": true, "price": { "amount": 12499.00, "currency": "MXN" } }
```
Pista: `active` es `true` cuando `ACTIVO == "S"`.

## 02 · `map` con campo calculado — `entradas/02-skus.json`

Añade `available` a cada elemento: `true` si `qty > 0`.

Salida esperada: los tres objetos, cada uno con `sku`, `qty` y `available` (`true, true, false`).
Pista: dentro de `map`, `$` es el elemento actual.

## 03 · `filter` — `entradas/03-04-almacenes.json`

Solo los almacenes con existencia.

Salida esperada: array con `CDMX-01` y `MTY-02`; `GDL-01` queda fuera.

## 04 · `reduce` — `entradas/03-04-almacenes.json`

Suma las existencias de todos los almacenes. Hazlo **primero con `reduce`**, luego busca el atajo.

Salida esperada: `14`.
Pista: `reduce ((elemento, acumulador = 0) -> …)`. Atajo: `sum(...)` sobre `payload.warehouses.quantity`.

## 05 · `groupBy` — `entradas/05-catalogo.json`

Agrupa por `capacityBtu`.

Salida esperada: un objeto con claves `"12000"`, `"18000"`, `"24000"` y arrays dentro.
Bonus: un segundo objeto con el **conteo** por capacidad (`{"12000": 2, "18000": 1, "24000": 2}`).
Pista bonus: `mapObject (valor, clave) -> { (clave): … }`.

## 06 · `orderBy` + `flatten` — `entradas/06-pedidos.json`

Todos los ítems de todos los pedidos, en una sola lista, del más caro al más barato.

Salida esperada: `[ 24K 19999, 18K 15999, 12K 12499 ]`.
Pista: `payload.orders.items` te da un array de arrays. `orderBy -$.price` invierte el orden.

## 07 · XML → JSON — `entradas/07-respuesta-erp.xml` *(cambia el Input a XML)*

El caso más realista: muchos ERPs hablan XML.

Salida esperada:
```json
{ "sku": "MIRAGE-MS-12K", "name": "Minisplit Inverter MS 12,000 BTU",
  "warehouses": [ { "code": "CDMX-01", "quantity": 9 }, { "code": "MTY-02", "quantity": 5 } ] }
```
Pistas: `@codigo` lee un atributo; `.*Almacen` lee **todos** los elementos repetidos; el texto de
un elemento llega como String y se convierte con `as Number`.

## 08 · CSV → JSON — `entradas/08-precios.csv` *(cambia el Input a CSV)*

Precios con celdas vacías.

Salida esperada: tres objetos; el 24K con `price: null`; los descuentos vacíos como `0`.
Pista: en CSV una celda vacía es `""`, no `null` — `default` no la cubre, `isEmpty` sí.

## 09 · Función propia — `entradas/09-precios.json`

Escribe `formatMXN(n)` que devuelva `"$12,499.00 MXN"`.

Salida esperada: `priceLabel: "$12,499.00 MXN"` y `"$19,999.50 MXN"`.
Pista: `fun nombre(param) = …` en la cabecera; `as String {format: "#,##0.00"}`.

## 10 · Fechas — `entradas/10-fechas-erp.json`

El ERP manda `"20260915"` y `"15/09/2026 18:30"`. El storefront quiere ISO-8601.

Salida esperada: `"2026-09-15"` y `"2026-09-15T18:30:00-05:00"`.
Pista: `as Date {format: "yyyyMMdd"}` para **leer**, `as String {format: …}` para **escribir**.
Una fecha sin zona es `LocalDateTime`.

---

## Cuando termines

Habrás usado todo lo que necesita el módulo 6: `map`, `filter`, `reduce`/`sum`, `groupBy`,
`orderBy`, `flatten`, atributos XML, `isEmpty`/`default`, funciones y fechas. Es el 80 % del
DataWeave que se usa en integraciones reales.
