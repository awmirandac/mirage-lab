%dw 2.0
output application/json
---
{
  sku:  payload.Respuesta.Articulo.@codigo,        // @ = atributo XML
  name: payload.Respuesta.Articulo.Descripcion,
  warehouses: payload.Respuesta.Articulo.Existencias.*Almacen map {   // * = elementos repetidos
    code:     $.@id,
    quantity: $ as Number                           // el texto del elemento, convertido
  }
}
