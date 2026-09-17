%dw 2.0
output application/json
fun formatMXN(n: Number): String = "\$" ++ (n as String {format: "#,##0.00"}) ++ " MXN"
---
payload map {
  sku:        $.sku,
  priceLabel: formatMXN($.price)
}
