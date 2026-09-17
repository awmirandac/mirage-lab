%dw 2.0
output application/json
---
{
  sku:         payload.COD_ART,
  name:        payload.DESCRIPCION,
  capacityBtu: payload.CAP_BTU,
  active:      payload.ACTIVO == "S",
  price: {
    amount:   payload.PRECIO_LISTA,
    currency: "MXN"
  }
}
