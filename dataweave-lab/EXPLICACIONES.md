# Explicación de las soluciones — Módulo 1

## El método, válido para cualquier transformación

1. Mira la forma de la entrada (objeto, array, texto).
2. Escribe la salida esperada como literal en el cuerpo. Ya es un script válido, solo que fijo.
3. Sustituye cada valor fijo por de dónde sale (`payload.X`).
4. Colecciones: envuelve con `map` / `filter`.
5. Casos raros al final: nulos, vacíos, tipos.

DataWeave se escribe **de la salida hacia la entrada**.

## 01 · Renombrar y anidar
- El cuerpo es una expresión: un objeto literal `{ clave: expresión }`.
- `payload.X` navega por clave (selector).
- Un valor puede ser cualquier expresión: `payload.ACTIVO == "S"` → booleano.
- Literales para lo que fija el contrato (`"MXN"`). Anidar = objeto como valor.
- Error típico: olvidar `---`.

## 02 · map
- `array map expr` aplica expr a cada elemento y devuelve un array **nuevo** (inmutable).
- `$` = elemento actual, `$$` = índice. Forma larga: `map (item, i) -> {…}`.
- Añadir un campo conservando el resto: `payload map ($ ++ { available: $.qty > 0 })`.

## 03 · filter
- Navega al array primero (`payload.warehouses`), luego `filter cond`.
- Operadores infijos: `array filter cond` ≡ `filter(array, cond)`. Se encadenan de izquierda a derecha.

## 04 · reduce / sum
- `reduce ((elem, acc = 0) -> acc + elem.x)`. **Siempre** pon el valor inicial.
- Atajo: `payload.warehouses.quantity` (selector multi-valor sobre array → array de valores) y `sum(...)`.
- Antes de un `reduce`, busca si existe la función: `sum`, `max`, `min`, `avg`, `joinBy`, `sizeOf`.

## 05 · groupBy / mapObject
- `groupBy` → objeto {valor: [elementos]}; claves como strings.
- `mapObject (valor, clave, índice) -> {…}` — orden de parámetros.
- `(clave):` con paréntesis = clave dinámica. Sin paréntesis = clave literal llamada "clave".

## 06 · flatten / orderBy
- `payload.orders.items` → array de arrays; `flatten` lo aplana.
- `orderBy -$.price` → descendente numérico (negar). Strings: `(x orderBy $.name)[-1 to 0]`.
- Construye por capas, comprobando cada una en el Playground.

## 07 · XML → JSON
- Elemento = clave; valor = texto o hijos. Atributos con `@`.
- `.Almacen` devuelve **solo el primero**; `.*Almacen` devuelve **todos**. Trampa clásica.
- Todo texto: `$ as Number` para convertir.
- Con `xmlns`: declarar `ns erp http://…` en cabecera y usar `payload.erp#Respuesta`.

## 08 · CSV → JSON
- El lector CSV produce objetos con claves de la cabecera; **todo String**; celda vacía = `""`.
- `default` solo sustituye `null`; `isEmpty()` cubre `null`, `""`, `[]`, `{}`.
- `fun aNumero(s) = if (isEmpty(s)) null else s as Number` — `if/else` es expresión.
- Conoce lo que produce el lector de tu formato.

## 09 · fun + format
- `fun nombre(p: Tipo): Tipo = expr`. Tipos opcionales pero útiles.
- `"\$"` escapado: `$(…)` es interpolación dentro de strings.
- `n as String {format: "#,##0.00"}` — patrón DecimalFormat.
- En el módulo 11 se extrae a `Format.dwl` e `import * from dw::mirage::Format`.

## 10 · Fechas
- Dos conversiones, en orden: `as Date {format: ENTRADA}` para leer → `as String {format: SALIDA}` para escribir.
- Tipos: `Date`, `LocalDateTime` (sin zona), `DateTime` (con zona; `now()`).
- Letras sensibles a mayúsculas: `MM` mes / `mm` minuto; `HH` 24 h / `hh` 12 h. `XXX` = offset; `'T'` = literal.
