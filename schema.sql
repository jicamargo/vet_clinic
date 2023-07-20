CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(10, 2)
);

/* project 2: add a new column: species */

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

/* project 3: CREATE new tables owners and species  */

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


/* Remove the "species" column */

ALTER TABLE animals
DROP COLUMN species;

/* Add the "species_id" column as a foreign key referencing the "species" table */

ALTER TABLE animals
ADD COLUMN species_id INTEGER,
ADD CONSTRAINT fk_species_id
    FOREIGN KEY (species_id)
    REFERENCES species(id);

/* Add the "owner_id" column as a foreign key referencing the "owners" table  */

ALTER TABLE animals
ADD COLUMN owner_id INTEGER,
ADD CONSTRAINT fk_owner_id
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);

