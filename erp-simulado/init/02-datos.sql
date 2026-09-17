INSERT INTO products (sku, name, capacity_btu, updated_at) VALUES
  ('MIRAGE-MS-12K', 'Minisplit Inverter MS 12,000 BTU', 12000, '2026-09-15 06:00:00-05'),
  ('MIRAGE-MS-18K', 'Minisplit Inverter MS 18,000 BTU', 18000, '2026-09-15 06:00:00-05'),
  ('MIRAGE-MS-24K', 'Minisplit Inverter MS 24,000 BTU', 24000, '2026-09-15 06:00:00-05'),
  ('MIRAGE-MX-12K', 'Minisplit MX 12,000 BTU',          12000, '2026-09-14 06:00:00-05');

INSERT INTO warehouses (code, name) VALUES
  ('CDMX-01', 'Centro de distribución Vallejo'),
  ('MTY-02',  'Bodega Apodaca'),
  ('GDL-01',  'Bodega Zapopan');

INSERT INTO stock (sku, warehouse_code, quantity) VALUES
  ('MIRAGE-MS-12K', 'CDMX-01', 9),
  ('MIRAGE-MS-12K', 'MTY-02',  5),
  ('MIRAGE-MS-18K', 'CDMX-01', 3),
  ('MIRAGE-MS-24K', 'CDMX-01', 0),
  ('MIRAGE-MS-24K', 'MTY-02',  0),
  ('MIRAGE-MX-12K', 'GDL-01',  7);
