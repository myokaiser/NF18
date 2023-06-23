------------------------------------COMMENTAIRE------------------------------------
-- ce fichier contient les requetes de selection qui ont pour but final d'etre utilisees 
-- par l'utilisateur via l'application python creee en parallele. De ce fait, l'ensemble
-- des requetes ci-dessous ont ete remaniees de telle sorte a ce qu'elles soient executables.
-- Une ligne de commentaire se trouve a cote des champs normalement variables par l'action de 
-- l'utilisateur.
------------------------------------REQUETE SQL------------------------------------
--REQUETE 1
SELECT nom_molecule, quantite, date_debut AS "date de début de consommation", date_fin AS "date de fin de consommation"
    FROM AssocTraitementMedicament ATM INNER JOIN Traitement T
    ON ATM.id_traitement = T.id_traitement
    WHERE date_debut >= '2018-01-01' -- valeur a entrer via interface python par l'utilisateur
    AND date_fin <= '2020-01-01'; -- valeur a entrer via interface python par l'utilisateur

-- REQUETE 2 
SELECT COUNT(*) 
    FROM Traitement 
    WHERE date_debut >= '2019-01-01' -- valeur a entrer via interface python par l'utilisateur
    AND date_fin <= '2022-01-01'; -- valeur a entrer via interface python par l'utilisateur

-- REQUETE 3
SELECT id_animal, procedure, saisie AS date_procedure 
    FROM Entree
    WHERE procedure IS NOT NULL 
    AND id_animal = 1 -- valeur a entrer via interface python par l'utilisateur
    ORDER BY saisie; 

-- REQUETE 4
SELECT type, COUNT(*) AS Nombre_animaux
    FROM Animal
    GROUP BY type;

-- REQUETE 5
SELECT C.nom AS "nom du client", C.prenom AS "prenom du client", A.nom "nom de l'animal", A.date_de_naissance AS "date de naissance de l'animal", num_puce, passeport, A.type
    FROM AssocAnimalClient AAC INNER JOIN Client C
        ON AAC.id_client = C.id_client INNER JOIN Animal A
        ON AAC.id_animal = A.id_animal
    WHERE C.id_client = 1 -- valeur a entrer via interface python par l'utilisateur
    ORDER BY date_debut;

-- REQUETE 6
SELECT C.nom AS "nom du client", C.prenom AS "prenom du client", A.nom "nom de l'animal", A.date_de_naissance AS "date de naissance de l'animal", num_puce, passeport, A.type
    FROM AssocAnimalClient AAC INNER JOIN Client C
        ON AAC.id_client = C.id_client INNER JOIN Animal A
        ON AAC.id_animal = A.id_animal
    WHERE C.id_client = 1 -- valeur a entrer via interface python par l'utilisateur
    AND date_fin IS NULL
    ORDER BY date_debut;

-- REQUETE 7
SELECT C.nom AS "nom du client", C.prenom AS "prenom du client", A.nom "nom de l'animal", A.date_de_naissance AS "date de naissance de l'animal", num_puce, passeport, A.type
    FROM AssocAnimalClient AAC INNER JOIN Client C
        ON AAC.id_client = C.id_client INNER JOIN Animal A
        ON AAC.id_animal = A.id_animal
    WHERE C.id_client = 1 -- valeur a entrer via interface python par l'utilisateur
    AND date_fin IS NOT NULL
    ORDER BY date_debut;

-- REQUETE 8
SELECT CAST(saisie AS VARCHAR) AS "date", taille AS "taille de l'animal", poids AS "poids de l'animal"
    FROM Entree
    WHERE id_animal = 1 -- valeur a entrer via interface python par l'utilisateur
    ORDER BY saisie;

-- REQUETE 9
SELECT id_traitement,date_debut, date_fin 
    FROM traitement
    WHERE id_traitement IN (SELECT  id_traitement 
                                FROM AssocTraitementEntree 
                                WHERE id_animal = 1 -- valeur a entrer via interface python par l'utilisateur
                            )
    ORDER BY date_debut;

-- REQUETE 10
SELECT traitement.* , assoctraitementmedicament.nom_molecule , assoctraitementmedicament.quantite 
    FROM traitement INNER JOIN AssocTraitementMedicament 
        ON traitement.id_traitement = AssocTraitementMedicament.id_traitement
    WHERE traitement.id_traitement IN (SELECT  id_traitement 
                                            FROM AssocTraitementEntree 
                                            WHERE id_animal = 1) 
    AND traitement.date_fin > NOW()
    AND traitement.date_debut < NOW();

-- REQUETE 11
SELECT P.*, poste
    FROM AssocEspecePersonnel AEP INNER JOIN Personnel P 
    ON AEP.id_personnel = P.id_personnel
    INNER JOIN (SELECT *, 'veterinaire' AS poste
                    FROM Veterinaire V
                UNION ALL
                SELECT *, 'assistant' AS poste
                    FROM Assistant A) U
    ON P.id_personnel = U.id_personnel
    WHERE type = 'reptiles';

-- REQUETE 12
SELECT A.*
    FROM AssocAnimalVeterinaire AAV INNER JOIN Animal A
        ON AAV.id_animal = A.id_animal
    WHERE id_personnel = 5 -- valeur a entrer via interface python par l'utilisateur
    AND (date_fin IS NULL 
    OR date_fin BETWEEN CAST(now() AS DATE) - 30 AND CAST(now() AS DATE));

-- REQUETE 13
SELECT P.*, date_debut AS date_de_suivi
    FROM AssocAnimalVeterinaire AAV INNER JOIN Personnel P
        ON AAV.id_personnel = P.id_personnel
    WHERE AAV.id_animal = 1 -- valeur a entrer via interface python par l'utilisateur
    ORDER BY date_debut DESC;