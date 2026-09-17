%dw 2.0
output application/json
---
// payload.orders.items → array de arrays. flatten lo aplana. orderBy con - invierte el orden.
flatten(payload.orders.items) orderBy -$.price
