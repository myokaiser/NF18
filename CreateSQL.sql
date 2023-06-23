DROP TABLE AssocAnimalClient;
DROP TABLE AssocAnimalVeterinaire;
DROP TABLE AssocTraitementMedicament;
DROP TABLE AssocTraitementEntree;
DROP TABLE AssocTraitementVeterinaire;
DROP TABLE AssocEspecePersonnel;
DROP TABLE AssocEspeceMedicament;
DROP TABLE Entree;
DROP TABLE Observation;
DROP TABLE Animal;
DROP TABLE Veterinaire;
DROP TABLE Assistant;
DROP TABLE Espece;
DROP TABLE Personnel;
DROP TABLE Traitement;
DROP TABLE Medicament;
DROP TABLE Client;
DROP TYPE type_espece;
DROP VIEW NomPoste;

---------------------------------------------------------TYPES---------------------------------------------------------
CREATE TYPE type_espece AS ENUM (
    'félin', 
    'canidés', 
    'reptiles', 
    'rongeurs', 
    'oiseaux', 
    'autres'
);

---------------------------------------------------------TABLES---------------------------------------------------------
CREATE TABLE Client(
    id_client INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    PRIMARY KEY (id_client)
);

CREATE TABLE Medicament(
    nom_molecule VARCHAR,
    description_effet VARCHAR,
    PRIMARY KEY (nom_molecule)
);

CREATE TABLE Traitement(
    id_traitement INTEGER,
    date_debut DATE,
    date_fin DATE,
    PRIMARY KEY (id_traitement),
    CHECK (date_debut < date_fin)
);

CREATE TABLE Personnel (
    id_personnel INTEGER,
    nom VARCHAR, 
    prenom VARCHAR,
    date_de_naissance DATE,
    adresse VARCHAR,
    numero_telephone VARCHAR(10),
    PRIMARY KEY (id_personnel)
);

CREATE TABLE Espece(
    type type_espece,
    PRIMARY KEY (type)
);

CREATE TABLE Assistant (
    id_personnel INTEGER,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_personnel)
);


CREATE TABLE Veterinaire (
    id_personnel INTEGER,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_personnel)
);

CREATE TABLE Animal(
    id_animal INTEGER,
    nom VARCHAR,
    date_de_naissance DATE,
    num_puce INTEGER UNIQUE,
    passeport INTEGER UNIQUE,
    type type_espece NOT NULL,
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_animal),
    CHECK (num_puce > 0 AND passeport > 0)
);

CREATE TABLE Observation(
    id_observation int,
    observation VARCHAR,
    id_personnel INTEGER NOT NULL,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    PRIMARY KEY (id_observation)
);

CREATE TABLE Entree(
    saisie TIMESTAMP,
    id_animal INTEGER,
    taille FLOAT,
    poids FLOAT,
    resultat_analyse VARCHAR, 
    procedure VARCHAR,              
    description_procedure VARCHAR,
    id_observation int UNIQUE,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    FOREIGN KEY (id_observation) REFERENCES Observation(id_observation),
    PRIMARY KEY (saisie, id_animal),
    CHECK (taille > 0 AND poids > 0)
);

CREATE TABLE AssocAnimalClient(
    id_client INTEGER,
    id_animal INTEGER,
    date_debut DATE NOT NULL,
    date_fin DATE,
    FOREIGN KEY (id_client) REFERENCES CLient(id_client),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (id_client, id_animal),
    CHECK (date_debut < date_fin)
);

CREATE TABLE AssocAnimalVeterinaire(
    id_personnel INTEGER,
    id_animal INTEGER,
    date_debut DATE NOT NULL,
    date_fin DATE,
    FOREIGN KEY (id_personnel) REFERENCES Veterinaire(id_personnel),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    PRIMARY KEY (id_personnel, id_animal),
    CHECK (date_debut < date_fin)
);

CREATE TABLE AssocTraitementMedicament(
    nom_molecule VARCHAR,
    id_traitement INTEGER,
    quantite INTEGER,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (nom_molecule, id_traitement),
    CHECK (quantite > 0)
);

CREATE TABLE AssocTraitementEntree(
    saisie TIMESTAMP,
    id_animal INTEGER,
    id_traitement INTEGER,
    FOREIGN KEY (saisie, id_animal) REFERENCES Entree(saisie, id_animal),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (saisie, id_animal, id_traitement)
);

CREATE TABLE AssocTraitementVeterinaire(
    id_personnel INTEGER,
    id_traitement INTEGER,

    FOREIGN KEY (id_personnel) REFERENCES Veterinaire(id_personnel),
    FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement),
    PRIMARY KEY (id_personnel, id_traitement)
);

CREATE TABLE AssocEspecePersonnel(
    id_personnel INTEGER,
    type type_espece,
    FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (id_personnel, type)
);

CREATE TABLE AssocEspeceMedicament(
    nom_molecule VARCHAR,
    type type_espece,
    FOREIGN KEY (nom_molecule) REFERENCES Medicament(nom_molecule),
    FOREIGN KEY (type) REFERENCES Espece(type),
    PRIMARY KEY (nom_molecule, type)
);

CREATE VIEW NomPoste AS
SELECT *, 'veterinaire' AS poste 
FROM Veterinaire V
UNION ALL
SELECT *, 'assistant' AS poste
FROM Assistant A;


---------------------------------------------------------FONCTIONS---------------------------------------------------------

--CLIENT
CREATE OR REPLACE FUNCTION CheckFunctionClient()
RETURNS trigger
AS 
$$
BEGIN
    IF NEW.id_client NOT IN (SELECT id_personnel FROM Personnel) THEN
        RETURN NEW;
    ELSE RAISE EXCEPTION 'IMPOSSIBLE, LA CLE EXISTE DEJA, ARRET DES INSERTIONS (message erreur : CheckFunctionClient)';
    END IF;
END;
$$
LANGUAGE PLPGSQL;


--PERSONNEL
CREATE OR REPLACE FUNCTION CheckFunctionPersonnel()
RETURNS trigger
AS 
$$
BEGIN
    IF NEW.id_personnel NOT IN (SELECT id_client FROM Client) THEN
        RETURN NEW;
    ELSE RAISE EXCEPTION 'IMPOSSIBLE, LA CLE EXISTE DEJA, ARRET DES INSERTIONS (message erreur : CheckFunctionPersonnel)';
    END IF;
END;
$$
LANGUAGE PLPGSQL;


--ASSISTANT
CREATE OR REPLACE FUNCTION CheckFunctionAssistant()
RETURNS trigger
AS 
$$
BEGIN
    IF NEW.id_personnel NOT IN (SELECT id_personnel FROM Veterinaire) THEN
        RETURN NEW;
    ELSE RAISE EXCEPTION 'IMPOSSIBLE, LA CLE EXISTE DEJA, ARRET DES INSERTIONS (message erreur : CheckFunctionAssistant)';
    END IF;
END;
$$
LANGUAGE PLPGSQL;


--VETERINAIRE
CREATE OR REPLACE FUNCTION CheckFunctionVeterinaire()
RETURNS trigger
AS 
$$
BEGIN
    IF NEW.id_personnel NOT IN (SELECT id_personnel FROM Assistant) THEN
        RETURN NEW;
    ELSE RAISE EXCEPTION 'IMPOSSIBLE, LA CLE EXISTE DEJA, ARRET DES INSERTIONS (message erreur : CheckFunctionVeterinaire)';
    END IF;
END;
$$
LANGUAGE PLPGSQL;

---------------------------------------------------------TRIGGERS---------------------------------------------------------


-- --CLIENT
-- CREATE OR REPLACE TRIGGER triggerClient
--     BEFORE INSERT ON Client
--     FOR EACH ROW
--     EXECUTE PROCEDURE CheckFunctionClient();


-- --PERSONNEL
-- CREATE OR REPLACE TRIGGER triggerPersonnel
--     BEFORE INSERT ON Personnel
--     FOR EACH ROW
--     EXECUTE PROCEDURE CheckFunctionPersonnel();


-- --ASSISTANT
-- CREATE OR REPLACE TRIGGER triggerAssistant
--     BEFORE INSERT ON Assistant
--     FOR EACH ROW
--     EXECUTE PROCEDURE CheckFunctionAssistant();


-- --VETERINAIRE
-- CREATE OR REPLACE TRIGGER triggerVeterinaire
--     BEFORE INSERT ON Veterinaire
--     FOR EACH ROW
--     EXECUTE PROCEDURE CheckFunctionVeterinaire();

---------------------------------------------------------INSERTIONS---------------------------------------------------------
-- INSERT INTO Client VALUES ('0001', 'DUPOND', 'Jean', '1998-10-05', '10 Rue du Général de Gaule 60000 BEAUVAIS', '0623564387');
-- INSERT INTO Client VALUES ('0002', 'DURAND', 'Paul', '1995-12-08', '21 Rue du Général 38400 Saint-Martin_dhères', '0623698487');
-- INSERT INTO Client VALUES ('0003', 'CHAN', 'Ines', '2004-04-02', '54 Avenue de la Gare 60000 BEAUVAIS', '0623784529');

-- INSERT INTO Espece VALUES ('félin');
-- INSERT INTO Espece VALUES ('oiseaux');
-- INSERT INTO Espece VALUES ('reptiles');

-- INSERT INTO Personnel VALUES ('0004', 'LEJEUNE', 'Martin', '1985-12-06', '12 Clos des roses 60200 Compiègne', '0756439851');
-- INSERT INTO Personnel VALUES ('0005', 'LEBLAN', 'Marie', '1995-05-01', '44 Rue du général 60200 Compiègne', '0756875851');
-- INSERT INTO Personnel VALUES ('0006', 'LENOIR', 'Paul', '1995-12-06', '56 Avenue UTC 60200 Compiègne', '0789649851');

-- INSERT INTO Assistant VALUES (4);
-- INSERT INTO Assistant VALUES (6);

-- INSERT INTO Veterinaire VALUES (5);

-- INSERT INTO Medicament VALUES ('Doliprane', 'Ce médicament permet de limiter les maux de tete');
-- INSERT INTO Medicament VALUES ('Medo2', 'Ce médicament permet de reduire les risques de cancer'); 

-- INSERT INTO Animal VALUES ('0001', 'moustache' , '2015-12-06', '1234', '4321', 'félin');
-- INSERT INTO Animal VALUES ('0002', 'Pero', '2012-11-12', '5678', '8765', 'oiseaux');
-- INSERT INTO Animal VALUES ('0003', 'croco', '2018-02-07', '1289', '9821', 'reptiles');

-- INSERT INTO AssocAnimalClient VALUES (1, 2, '2022-11-9' );
-- INSERT INTO AssocAnimalClient VALUES (2, 3, '2015-10-2' );
-- INSERT INTO AssocAnimalClient VALUES (3, 1, '2019-07-6' );

-- INSERT INTO AssocAnimalVeterinaire VALUES (0005, 0002, '2019-02-24' );
-- INSERT INTO AssocAnimalVeterinaire VALUES (0005, 0001, '2019-02-24' );

-- INSERT INTO Observation VALUES (0001, 'faiblesse et fatigue, coussinet craqueles', 4);
-- INSERT INTO Observation VALUES (0002, 'Consultation de moustache RAS', 4);

-- INSERT INTO Entree VALUES ('24-02-2019 14:15:56', 0001, 1.1, 10.4, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 2);
-- INSERT INTO Entree (saisie, id_animal, taille) VALUES ('10-11-2022 14:09:26', 0001, 1.3);
-- INSERT INTO Entree VALUES ('10-11-2022 14:15:56', 0001, 1.4, 12.4, 'Manque de Fer', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 0001);


-- INSERT INTO Traitement VALUES (0001, '2019-02-24', '2019-02-28');
-- INSERT INTO Traitement VALUES (0002, '2019-02-24', '2019-03-12');

-- INSERT INTO AssocTraitementMedicament VALUES ('Doliprane', 0001, 8);
-- INSERT INTO AssocTraitementMedicament VALUES ('Medo2', 0002, 12);

-- INSERT INTO AssocTraitementEntree VALUES ('24-02-2019 14:15:56', 1, 1);

-- INSERT INTO AssocTraitementVeterinaire VALUES (5, 2);
-- INSERT INTO AssocTraitementVeterinaire VALUES (5, 1);

-- INSERT INTO AssocEspecePersonnel VALUES (4, 'félin');
-- INSERT INTO AssocEspecePersonnel VALUES (5, 'oiseaux');
-- INSERT INTO AssocEspecePersonnel VALUES (5, 'reptiles');

-- INSERT INTO AssocEspeceMedicament VALUES ('Doliprane', 'félin');
-- INSERT INTO AssocEspeceMedicament VALUES ('Medo2', 'oiseaux');
-- INSERT INTO AssocEspeceMedicament VALUES ('Medo2', 'reptiles');
