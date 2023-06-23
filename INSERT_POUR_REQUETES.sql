INSERT INTO Client VALUES ('0001', 'DUPOND', 'Jean', '1998-10-05', '10 Rue du Général de Gaule 60000 BEAUVAIS', '0623564387');
INSERT INTO Client VALUES ('0002', 'DURAND', 'Paul', '1995-12-08', '21 Rue du Général 38400 Saint-Martin_dhères', '0623698487');
INSERT INTO Client VALUES ('0003', 'CHAN', 'Ines', '2004-04-02', '54 Avenue de la Gare 60000 BEAUVAIS', '0623784529');

INSERT INTO Espece VALUES ('félin');
INSERT INTO Espece VALUES ('oiseaux');
INSERT INTO Espece VALUES ('reptiles');

INSERT INTO Personnel VALUES ('0004', 'LEJEUNE', 'Martin', '1985-12-06', '12 Clos des roses 60200 Compiègne', '0756439851');
INSERT INTO Personnel VALUES ('0005', 'LEBLAN', 'Marie', '1995-05-01', '44 Rue du général 60200 Compiègne', '0756875851');
INSERT INTO Personnel VALUES ('0006', 'LENOIR', 'Paul', '1995-12-06', '56 Avenue UTC 60200 Compiègne', '0789649851');

INSERT INTO Assistant VALUES (4);
INSERT INTO Assistant VALUES (6);

INSERT INTO Veterinaire VALUES (5);

INSERT INTO Medicament VALUES ('Doliprane', 'Ce médicament permet de limiter les maux de tete');
INSERT INTO Medicament VALUES ('Medo2', 'Ce médicament permet de reduire les risques de cancer'); 

INSERT INTO Animal VALUES ('0001', 'moustache' , '2015-12-06', '1234', '4321', 'félin');
INSERT INTO Animal VALUES ('0002', 'Pero', '2012-11-12', '5678', '8765', 'oiseaux');
INSERT INTO Animal VALUES ('0003', 'croco', '2018-02-07', '1289', '9821', 'reptiles');

INSERT INTO AssocAnimalClient VALUES (1, 2, '2022-11-9' );
INSERT INTO AssocAnimalClient VALUES (1, 3, '2022-11-9', '2022-11-21');
INSERT INTO AssocAnimalClient VALUES (1, 1, '2022-11-9', '2022-11-12' );
INSERT INTO AssocAnimalClient VALUES (2, 3, '2015-10-2' );
INSERT INTO AssocAnimalClient VALUES (3, 1, '2019-07-6' );

INSERT INTO AssocAnimalVeterinaire VALUES (0005, 0002, '2019-02-24', '2020-11-15');
INSERT INTO AssocAnimalVeterinaire VALUES (0005, 0001, '2019-02-24' );
INSERT INTO AssocAnimalVeterinaire VALUES (0005, 0003, '2019-02-24', '2020-11-15');

INSERT INTO Observation VALUES (0001, 'faiblesse et fatigue, coussinet craqueles', 4);
INSERT INTO Observation VALUES (0003, 'faiblesse et fatigue, coussinet craqueles', 4);
INSERT INTO Observation VALUES (0004, 'faiblesse et fatigue, coussinet craqueles', 4);
INSERT INTO Observation VALUES (0005, 'faiblesse et fatigue, coussinet craqueles', 4);
INSERT INTO Observation VALUES (0002, 'Consultation de moustache RAS', 4);
INSERT INTO Observation VALUES (0006, 'Consultation de moustache RAS', 6);
INSERT INTO Observation VALUES (0007, 'Consultation de moustache RAS', 4);

INSERT INTO Entree VALUES ('2019-02-24 14:15:56', 0001, 1.1, 10.4, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 1);
INSERT INTO Entree VALUES ('2020-02-24 14:15:56', 0001, 1.2, 10.4, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 2);
INSERT INTO Entree VALUES ('2021-02-24 14:15:56', 0001, 1.3, 4, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 3);
INSERT INTO Entree VALUES ('2022-02-24 14:15:56', 0001, 1.4, 10, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 4);
INSERT INTO Entree VALUES ('2023-02-24 14:15:56', 0001, 15, 104, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 5);
INSERT INTO Entree VALUES ('2024-02-24 14:15:56', 0001, 11, 10.4, 'Rien a signaler', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 6);
INSERT INTO Entree (saisie, id_animal, taille) VALUES ('2022-11-10 14:09:26', 0001, 1.3);
INSERT INTO Entree VALUES ('2022-11-10 14:15:56', 0001, 1.4, 12.4, 'Manque de Fer', 'prelevement sanguin','prelevement sanguin a froid et analyse sanguine', 0007);


INSERT INTO Traitement VALUES (0001, '2019-02-24', '2019-02-28');
INSERT INTO Traitement VALUES (0002, '2019-02-24', '2019-03-12');
INSERT INTO Traitement VALUES (0003, '2020-02-26', '2023-01-12');
INSERT INTO Traitement VALUES (0004, '2021-02-24', '2021-03-12');

INSERT INTO AssocTraitementMedicament VALUES ('Doliprane', 0001, 8);
INSERT INTO AssocTraitementMedicament VALUES ('Medo2', 0002, 12);
INSERT INTO AssocTraitementMedicament VALUES ('Medo2', 0003, 10);
INSERT INTO AssocTraitementMedicament VALUES ('Medo2', 0004, 5);

INSERT INTO AssocTraitementEntree VALUES ('2019-02-24 14:15:56', 1, 1);
INSERT INTO AssocTraitementEntree VALUES ('2020-02-24 14:15:56', 1, 2);
INSERT INTO AssocTraitementEntree VALUES ('2021-02-24 14:15:56', 1, 3);

INSERT INTO AssocTraitementVeterinaire VALUES (5, 2);
INSERT INTO AssocTraitementVeterinaire VALUES (5, 1);

INSERT INTO AssocEspecePersonnel VALUES (4, 'félin');
INSERT INTO AssocEspecePersonnel VALUES (5, 'oiseaux');
INSERT INTO AssocEspecePersonnel VALUES (5, 'reptiles');

INSERT INTO AssocEspeceMedicament VALUES ('Doliprane', 'félin');
INSERT INTO AssocEspeceMedicament VALUES ('Medo2', 'oiseaux');
INSERT INTO AssocEspeceMedicament VALUES ('Medo2', 'reptiles');
