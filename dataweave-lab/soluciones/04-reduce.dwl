%dw 2.0
output application/json
---
{
  // reduce: acumula. (elemento, acumulador = valor inicial) -> nuevo acumulador
  totalConReduce: payload.warehouses reduce ((wh, acc = 0) -> acc + wh.quantity),

  // el atajo idiomático: array.campo devuelve el array de ese campo; sum lo suma
  totalConSum: sum(payload.warehouses.quantity)
}
