DROP TABLE IF EXISTS property;

CREATE TABLE property(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  build VARCHAR(255),
  no_bedrooms INT2,
  value INT8
);
