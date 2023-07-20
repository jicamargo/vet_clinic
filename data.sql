/* PROJECT 1 - UPDATES */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11);


/* PROJECT 2 - UPDATE TABLE WIOTH NEW ROWS */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', '1998-10-13', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Ditto', '2022-05-14', 4, true, 22);

/* PROJECT 3 - ADDING DATA TO NEW TABLES owners and species */

INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

/* modify the previously inserted data in the "animals" table and set the appropriate "species_id" */

UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
  WHERE name LIKE '%mon';

UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
  WHERE species_id IS NULL;


/*  Modify inserted animals to include owner information  */

-- Update animals owned by Sam Smith
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name = 'Agumon';

-- Update animals owned by Jennifer Orwell
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name IN ('Gabumon', 'Pikachu');

-- Update animals owned by Bob
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name IN ('Devimon', 'Plantmon');

-- Update animals owned by Melody Pond
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update animals owned by Dean Winchester
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name IN ('Angemon', 'Boarmon');

  
/* project 4: */

--insert data into vets */

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert specialization for Vet William Tatcher (Pokemon)
INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1);

-- Insert specialization for Vet Stephanie Mendez (Digimon)
INSERT INTO specializations (vet_id, species_id)
VALUES (3, 2);

-- Insert specialization for Vet Stephanie Mendez (Pokemon)
INSERT INTO specializations (vet_id, species_id)
VALUES (3, 1);

-- Insert specialization for Vet Jack Harkness (Digimon)
INSERT INTO specializations (vet_id, species_id)
VALUES (4, 2);

/***** insert visits *****/

-- Insert visit for Agumon visiting Vet William Tatcher on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 1, '2020-05-24');

-- Insert visit for Agumon visiting Vet Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 3, '2020-07-22');

-- Insert visit for Gabumon visiting Vet Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 4, '2021-02-02');

-- Insert visit for Pikachu visiting Vet Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, '2020-01-05');

-- Insert visit for Pikachu visiting Vet Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, '2020-03-08');

-- Insert visit for Pikachu visiting Vet Maisy Smith on May 14th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 2, '2020-05-14');

-- Insert visit for Devimon visiting Vet Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 3, '2021-05-04');

-- Insert visit for Charmander visiting Vet Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 4, '2021-02-24');

-- Insert visit for Plantmon visiting Vet Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 2, '2019-12-21');

-- Insert visit for Plantmon visiting Vet William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 1, '2020-08-10');

-- Insert visit for Plantmon visiting Vet Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 2, '2021-04-07');

-- Insert visit for Squirtle visiting Vet Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (7, 3, '2019-09-29');

-- Insert visit for Angemon visiting Vet Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 4, '2020-10-03');

-- Insert visit for Angemon visiting Vet Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 4, '2020-11-04');

-- Insert visit for Boarmon visiting Vet Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 2, '2019-01-24');

-- Insert visit for Boarmon visiting Vet Maisy Smith on May 15th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 2, '2019-05-15');

-- Insert visit for Boarmon visiting Vet Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 2, '2020-02-27');

-- Insert visit for Boarmon visiting Vet Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 2, '2020-08-03');

-- Insert visit for Blossom visiting Vet Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 3, '2020-05-24');

-- Insert visit for Blossom visiting Vet William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 1, '2021-01-11');