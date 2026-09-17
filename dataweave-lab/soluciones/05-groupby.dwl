%dw 2.0
output application/json
---
{
  // groupBy devuelve un objeto: clave = valor agrupado, valor = array de elementos
  porCapacidad: payload groupBy $.capacityBtu,

  // mapObject recorre (valor, clave) de un objeto. (k) entre paréntesis = clave dinámica
  conteoPorCapacidad: payload groupBy $.capacityBtu mapObject (skus, btu) -> { (btu): sizeOf(skus) }
}
