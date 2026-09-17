%dw 2.0
output application/json
---
{
  // "20260915" → Date con el formato de origen → String con el formato destino
  cutoffDate: (payload.fechaCorte as Date {format: "yyyyMMdd"}) as String {format: "yyyy-MM-dd"},

  // "15/09/2026 18:30" no trae zona → LocalDateTime. Se le añade la de México/Lima al serializar.
  updatedAt: (payload.ultimaActualizacion as LocalDateTime {format: "dd/MM/yyyy HH:mm"})
             as String {format: "yyyy-MM-dd'T'HH:mm:ss"} ++ "-05:00",

  // now() ya es DateTime con zona; XXX imprime el offset
  generatedAt: now() as String {format: "yyyy-MM-dd'T'HH:mm:ssXXX"}
}
