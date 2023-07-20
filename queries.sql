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

/* project 3: QUERIES USING JOIN TO SEVERAL TABLES */

--1. What animals belong to Melody Pond?

SELECT a.name AS animal_name, s.name AS species_name
  FROM animals a
  JOIN species s ON a.species_id = s.id
  JOIN owners o ON a.owner_id = o.id
  WHERE o.full_name = 'Melody Pond';

--2. List of all animals that are Pokemon (their type is Pokemon).

SELECT a.name AS animal_name, s.name AS species_name
  FROM animals a
  JOIN species s ON a.species_id = s.id
  WHERE s.name = 'Pokemon';

--3. List all owners and their animals, including those who don't own any animal.

SELECT o.full_name AS owner_name, a.name AS animal_name
  FROM owners o
  LEFT JOIN animals a ON o.id = a.owner_id;


--4. How many animals are there per species?

SELECT s.name AS species_name, COUNT(*) AS animal_count
  FROM animals a
  JOIN species s ON a.species_id = s.id
  GROUP BY s.name;


--5. List all Digimon owned by Jennifer Orwell.

SELECT a.name AS digimon_name
  FROM animals a
  JOIN species s ON a.species_id = s.id
  JOIN owners o ON a.owner_id = o.id
  WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';


--6. List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name AS animal_name
  FROM animals a
  JOIN owners o ON a.owner_id = o.id
  WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

--7. Who owns the most animals?

SELECT o.full_name AS owner_name, COUNT(*) AS animal_count
  FROM owners o
  JOIN animals a ON o.id = a.owner_id
  GROUP BY o.full_name
  ORDER BY animal_count DESC
  LIMIT 1;

/* PROJECT 4: QUERIES USING MANY TO MANY RELATIONSHIPS */

-- 1. Who was the last animal seen by William Tatcher?

SELECT a.name AS animal_name
  FROM animals a
  JOIN visits v ON a.id = v.animal_id
  JOIN vets vt ON v.vet_id = vt.id
  WHERE vt.name = 'William Tatcher'
  ORDER BY v.visit_date DESC
  LIMIT 1;

-- 2. How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- 3. List all vets and their specialties, including vets with no specialties.

SELECT v.name AS vet_name, COALESCE(s.name, 'No specialty') AS specialty
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name AS animal_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- 5. What animal has the most visits to vets?

SELECT a.name AS animal_name, COUNT(v.animal_id) AS num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

-- 6. Who was Maisy Smith's first visit?

SELECT a.name AS animal_name, MIN(v.visit_date) AS first_visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY a.name
LIMIT 1;

--7. Details for the most recent visit: animal information, vet information, and date of visit.

SELECT a.name AS animal_name, s.name as specie, a.date_of_birth, 
	a.escape_attempts, a.neutered, a.weight_kg, 
	vt.name AS vet_name, v.visit_date AS visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
JOIN species s ON a.species_id = s.id 
ORDER BY v.visit_date DESC
LIMIT 1;

--8. How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(v.id) AS num_visits_without_specialty
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.id IS NULL;

--9. What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT sp.name as recommended_specialty, COUNT(a.species_id) as num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
JOIN species sp ON a.species_id = sp.id
WHERE vet.name = 'Maisy Smith'
GROUP BY a.species_id, sp.name
ORDER BY num_visits DESC;