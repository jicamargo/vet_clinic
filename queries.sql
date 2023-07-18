/* PROJECT 1  */

SELECT * FROM animals
  WHERE name LIKE '%mon';

SELECT name FROM animals
  WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals 
  WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals
  WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals
  WHERE weight_kg > 10.5;

SELECT * FROM animals
  WHERE neutered = true;

SELECT * FROM animals
  WHERE name != 'Gabumon';

SELECT * FROM animals
  WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* PROJECT 2: NEW QUERIES USING TRANSACTIONS, AGGREGATE FUNCTIONS */ 

/* 3.1 PLAYING WITH TRANSACTIONS */
BEGIN;

-- Update the species column to "unspecified"
UPDATE animals SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species column has reverted to its previous state
SELECT * FROM animals;

/* 3.2 PLAYING WITH TRANSACTIONS */

BEGIN;

-- Update the species column to 'digimon' for animals with names ending in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the species column to 'pokemon' for animals without a species already set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the changes
SELECT * FROM animals;

COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals;

/* 3.3 PLAYING WITH TRANSACTIONS */

BEGIN;

-- Delete all records from the animals table
DELETE FROM animals;

-- Verify that all records are deleted
SELECT * FROM animals;

ROLLBACK;

-- Verify that all records are restored after the rollback
SELECT * FROM animals;

/* 3.4 PLAYING WITH TRANSACTIONS */

BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update weights for animals that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals;

/* 4 QUERIES */

-- 4.1 How many animals are there?

SELECT COUNT(*) AS total_animals FROM animals;

--4.2 How many animals have never tried to escape?

SELECT COUNT(*) AS no_escape_animals FROM animals WHERE escape_attempts = 0;

--4.3 What is the average weight of animals?

SELECT AVG(weight_kg) AS average_weight FROM animals;

--4.4 Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
  FROM animals
  GROUP BY neutered
  ORDER BY total_escape_attempts DESC
  LIMIT 1;

--4.5 What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
  FROM animals
  GROUP BY species;

--4.6 What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempts) AS average_escape_attempts
  FROM animals
  WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
  GROUP BY species;

