%dw 2.0
output application/json
// En CSV una celda vacía llega como "" (no null). isEmpty cubre los dos casos.
fun aNumero(s) = if (isEmpty(s)) null else s as Number
---
payload map {
  sku:         $.sku,
  price:       aNumero($.precio),
  currency:    $.moneda,
  discountPct: aNumero($.descuento) default 0
}
