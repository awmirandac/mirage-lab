%dw 2.0
output application/json
---
payload.warehouses filter $.quantity > 0
