-- Esquema del ERP simulado. Se ejecuta solo la primera vez que arranca el contenedor.
CREATE TABLE products (
  sku          VARCHAR(32)  PRIMARY KEY,
  name         VARCHAR(120) NOT NULL,
  capacity_btu INTEGER      NOT NULL,
  updated_at   TIMESTAMPTZ  NOT NULL
);

CREATE TABLE warehouses (
  code VARCHAR(16)  PRIMARY KEY,
  name VARCHAR(120) NOT NULL
);

CREATE TABLE stock (
  sku            VARCHAR(32) NOT NULL REFERENCES products(sku),
  warehouse_code VARCHAR(16) NOT NULL REFERENCES warehouses(code),
  quantity       INTEGER     NOT NULL DEFAULT 0 CHECK (quantity >= 0),
  PRIMARY KEY (sku, warehouse_code)
);
