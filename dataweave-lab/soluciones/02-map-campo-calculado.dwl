%dw 2.0
output application/json
---
// $ es el elemento actual. Equivale a: payload map (item) -> { ... }
payload map {
  sku:       $.sku,
  qty:       $.qty,
  available: $.qty > 0
}
