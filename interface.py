#!/usr/bin/python3

# http://initd.org/psycopg/docs/usage.html

import psycopg2
import main
from datetime import *

HOST = "localhost"
USER = "me"
PASSWORD = "secret"
DATABASE = "mydb"

# Open connection
conn = psycopg2.connect(
    "host=%s dbname=%s user=%s password=%s" % (HOST, DATABASE, USER, PASSWORD)
)

# # Open a cursor to send SQL commands
# cur = conn.cursor()

# # Execute a SQL SELECT command
# sql = "SELECT * FROM t"
# cur.execute(sql)

# # Fetch data line by line
# raw = cur.fetchone()
# while raw:
#     print (raw[0])
#     print (raw[1])
#     raw = cur.fetchone()

# # Close connection
# conn.close()


def select_quantite_medicament_duree():
    cur = conn.cursor()
    print("Entrez la date de début :")
    deb_jour = int(input("Jour: "))
    deb_mois = int(input("Mois: "))
    deb_annee = int(input("Annee: "))
    print("Entrez la date de fin :")
    fin_jour = int(input("Jour: "))
    fin_mois = int(input("Mois: "))
    fin_annee = int(input("Annee: "))
    deb = deb_jour + "-" + deb_mois + "-" + deb_annee
    fin = fin_jour + "-" + fin_mois + "-" + fin_annee
    sql = "SELECT nom_molecule, quantite, date_debut, date_fin - date_debut AS periode"
    +" FROM AssocTraitementMedicament ATM INNER JOIN Traitement T"
    +" ON ATM.id_traitement = T.id_traitement"
    +" WHERE date_debut >=" + deb
    +"AND date_fin <=" + fin + ";"

    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("nom_molecule : ", raw[0])
        print("quantite : ", raw[1])
        print("date_debut : ", raw[2])
        print("période : ", raw[3])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()

    # Close connection
    conn.close()


def select_nombre_traitement_periode():
    cur = conn.cursor()
    print("Entrez la date de début :")
    deb_jour = int(input("Jour: "))
    deb_mois = int(input("Mois: "))
    deb_annee = int(input("Annee: "))
    print("Entrez la date de fin :")
    fin_jour = int(input("Jour: "))
    fin_mois = int(input("Mois: "))
    fin_annee = int(input("Annee: "))
    deb = deb_jour + "-" + deb_mois + "-" + deb_annee
    fin = fin_jour + "-" + fin_mois + "-" + fin_annee
    sql = (
        "SELECT COUNT(*) FROM Traitement WHERE date_debut >="
        + deb
        + "AND date_fin <="
        + fin
        + ";"
    )
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Nombre de traitement : ", raw[0])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_prodedure_animal():
    cur = conn.cursor()
    print("Entrez l'identifiant de l'animal :")
    id_animal = int(input("id : "))
    sql = (
        "SELECT id_animal, procedure, saisie AS date_procedure FROM Entree WHERE procedure IS NOT NULL AND id_animal ="
        + id_animal
        + "ORDER BY saisie;"
    )
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("id_animal : ", raw[0])
        print("procedure : ", raw[1])
        print("date_procedure : ", raw[2])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_compte_animal_type():
    cur = conn.cursor()
    sql = "SELECT type, COUNT(*) AS Nombre_animaux FROM Animal GROUP BY type;"
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Nombre d'animaux de type" + raw[1] + " : ", raw[0])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_tous_animaux():
    cur = conn.cursor()
    print("Entrez l'identifiant du client :")
    id_client = int(input("id : "))
    sql = "SELECT C.nom, C.prenom, A.nom, A.date_de_naissance, num_puce, passeport, A.type "
    +"FROM AssocAnimalClient AAC INNER JOIN Client C ON AAC.id_client = C.id_client INNER JOIN Animal A "
    (
        +"ON AAC.id_animal = A.id_animal WHERE C.id_client ="
        + id_client
        + "ORDER BY date_debut;"
    )
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Nom client :", raw[0])
        print("Prenom client :", raw[1])
        print("Nom animal :", raw[2])
        print("date de naissance de l'animal : ", raw[3])
        print("numero de la puce de l'animal: ", raw[4])
        print("passeport de l'animal:", raw[5])
        print("type de l'animal : ", raw[6])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_anciens_animaux():
    cur = conn.cursor()
    print("Entrez l'identifiant du client :")
    id_client = int(input("id : "))
    sql = "SELECT C.nom, C.prenom, A.nom, A.date_de_naissance, num_puce, passeport, A.type "
    +"FROM AssocAnimalClient AAC INNER JOIN Client C ON AAC.id_client = C.id_client "
    (
        +"INNER JOIN Animal A ON AAC.id_animal = A.id_animal WHERE C.id_client ="
        + id_client
        + "AND date_fin IS NULL "
    )
    +"ORDER BY date_debut"
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Nom client :", raw[0])
        print("Prenom client :", raw[1])
        print("Nom animal :", raw[2])
        print("date de naissance de l'animal : ", raw[3])
        print("numero de la puce de l'animal: ", raw[4])
        print("passeport de l'animal:", raw[5])
        print("type de l'animal : ", raw[6])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_current_animaux():
    cur = conn.cursor()
    print("Entrez l'identifiant du client :")
    id_client = int(input("id : "))
    sql = "SELECT C.nom, C.prenom, A.nom, A.date_de_naissance, num_puce, passeport, A.type "
    +" FROM AssocAnimalClient AAC INNER JOIN Client C ON AAC.id_client = C.id_client "
    +"INNER JOIN Animal A ON AAC.id_animal = A.id_animal "
    +"WHERE C.id_client =" + id_client + " AND date_fin IS NOT NULL ORDER BY date_debut;"
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Nom client :", raw[0])
        print("Prenom client :", raw[1])
        print("Nom animal :", raw[2])
        print("date de naissance de l'animal : ", raw[3])
        print("numero de la puce de l'animal: ", raw[4])
        print("passeport de l'animal:", raw[5])
        print("type de l'animal : ", raw[6])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_evolution_taille_poid():
    cur = conn.cursor()
    print("Entrez l'identifiant de l'animal :")
    id_animal = int(input("id : "))
    sql = (
        "SELECT taille, poids FROM Entree WHERE id_animal ="
        + id_animal
        + "ORDER BY saisie; "
    )
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("taille :", raw[0])
        print("Poid :", raw[1])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_traitement_subit_animal():
    cur = conn.cursor()
    print("Entrez l'identifiant de l'animal :")
    id_animal = int(input("id : "))
    sql = "SELECT id_traitement,date_debut, date_fin "
    +"FROM traitement "
    (
        +"WHERE id_traitement IN (SELECT  id_traitement FROM AssocTraitementEntree WHERE id_animal = "
        + id_animal
        + ") "
    )
    +"ORDER BY date_debut"
    cur.execute(sql)
    # Fetch data line by line
    raw = cur.fetchone()
    while raw:
        print("Identifiant du traitement :", raw[0])
        print("date de début :", raw[1])
        print("date de fin :", raw[2])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def select_personnel_reptile():
    cur = conn.cursor()
    sql = "SELECT P.*, poste FROM AssocEspecePersonnel AEP INNER JOIN Personnel P ON AEP.id_personnel = P.id_personnel INNER JOIN (SELECT *, 'veterinaire' AS poste FROM Veterinaire V UNION ALL SELECT *, 'assistant' AS poste FROM Assistant A) U ON P.id_personnel = U.id_personnel WHERE type = 'reptiles'"
    cur.execute(sql)
    raw = cur.fetchone()
    while raw:
        print("id_personnel :", raw[0])
        print("nom :", raw[1])
        print("prenom :", raw[2])
        print("date de naissance :", raw[3])
        print("adresse :", raw[4])
        print("numero de telephone :", raw[5])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()



def select_traitement_en_cours_animal():
    cur = conn.cursor()
    print("Entrez l'identifiant de l'animal :")
    id_animal = int(input("id : "))
    sql = "SELECT traitement.* , assoctraitementmedicament.nom_molecule , assoctraitementmedicament.quantite FROM traitement "
    + "INNER JOIN AssocTraitementMedicament ON traitement.id_traitement = AssocTraitementMedicament.id_traitement "
    + "WHERE traitement.id_traitement IN (SELECT  id_traitement FROM AssocTraitementEntree WHERE id_animal = " + id_animal + ") " 
    + "AND traitement.date_fin > NOW() AND traitement.date_debut < NOW() "
    cur.execute(sql)
    raw = cur.fetchone()
    while raw:
        print("id_traitement :", raw[0])
        print("date de debut :", raw[1])
        print("date de fin :", raw[2])
        print("nom_molecule :", raw[3])
        print("quantite :", raw[4])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()




def select_animaux_suivi_veterinaire():
    cur = conn.cursor()
    print("Entrez l'indentifiant du vétérinaire")
    id_veto = int(input("id :"))
    sql = "SELECT A.* FROM AssocAnimalVeterinaire AAV INNER JOIN Animal A ON AAV.id_animal = A.id_animal "
    + "WHERE id_personnel = " + id_veto + "AND (date_fin IS NULL OR date_fin BETWEEN CAST(now() AS DATE) - 30 AND CAST(now() AS DATE))"
    cur.execute(sql)
    raw = cur.fetchone()
    while raw:
        print("id_animal :", raw[0])
        print("nom :", raw[1])
        print("date_de_naissance :", raw[2])
        print("numero de puce :", raw[3])
        print("passeport :", raw[4])
        print("type :", raw[5])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()

def select_liste_veto_suivi():
    cur = conn.cursor()
    print("Entrez l'identifiant de l'animal :")
    id_animal = int(input("id : "))
    sql = "SELECT P.*, date_debut AS date_de_suivi FROM AssocAnimalVeterinaire AAV INNER JOIN Personnel P"
    +  "ON AAV.id_personnel = P.id_personnel WHERE AAV.id_animal =" + id_animal + "ORDER BY date_debut DESC" 
    cur.execute(sql)
    raw = cur.fetchone()
    while raw:
        print("id_personnel :", raw[0])
        print("nom :", raw[1])
        print("prenom :", raw[2])
        print("date de naissance :", raw[3])
        print("adresse :", raw[4])
        print("telephone :", raw[5])
        print("date de suivi :", raw[6])
        print(
            "================================================================================"
        )
        raw = cur.fetchone()
    # Close connection
    conn.close()


def insert_personnel():
    cur = conn.cursor()
    id = int(input("Entrez l'id du proprietaire:"))
    sql = "INSERT INTO Personnel (id_personnel) VALUES (%d)" %(id)
    cur.execute(sql)

    choix = int(input("Si vous voulez entrer un nom tapez 1"))
    if choix == 1:
        nom = input("Entrez le nom du personnel:")
        sql = "INSERT INTO Personnel (nom) VALUES (%s)" %(nom)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un prenom tapez 1"))
    if choix == 1:
        prenom = input("Entrez le prenom du personnel:")
        sql = "INSERT INTO Personnel (prenom) VALUES (%s)" %(prenom)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer une date de naissance tapez 1"))
    if choix == 1:
        date = input("Entrez la date de naissance du personnel:")
        sql = "INSERT INTO Personnel (date_de_naissance) VALUES (%s)" %(date)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un nom tapez 1"))
    if choix == 1:
        adresse = input("Entrez l'adresse du personnel:")
        sql = "INSERT INTO Personnel (adresse) VALUES (%s)" %(adresse)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un numero de telephone tapez 1"))
    if choix == 1:
        telephone = input("Entrez le numero de telephone du personnel:")
        sql = "INSERT INTO Personnel (numero_telephone) VALUES (%s)" %(telephone)
        cur.execute(sql)

    poste = 0
    while poste != 1 and poste != 2:
        poste = int(input("Si le personnel est un vétérinaire tapez 1 et si le personnel est un assistant tapez 2"))
    if poste == 1:
        sql1 = "INSERT INTO Veterinaire (id_personnel) VALUES (%d)" %(id)
    else:
        sql1 = "INSERT INTO Assistant (id_personnel) VALUES (%d)" %(id)
    cur.execute(sql1)
    conn.connect()
    conn.close()


def insert_client():
    cur = conn.cursor()
    id = int(input("Entrez l'id du client:"))
    sql = "INSERT INTO Client (id_client) VALUES (%d)" %(id)
    cur.execute(sql)

    choix = int(input("Si vous voulez entrer un nom tapez 1"))
    if choix == 1:
        nom = input("Entrez le nom du client:")
        sql = "INSERT INTO Client (nom) VALUES (%s)" %(nom)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un prenom tapez 1"))
    if choix == 1:
        prenom = input("Entrez le prenom du client:")
        sql = "INSERT INTO Client (prenom) VALUES (%s)" %(prenom)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer une date de naissance tapez 1"))
    if choix == 1:
        date = input("Entrez la date de naissance du client:")
        sql = "INSERT INTO Client (date_de_naissance) VALUES (%s)" %(date)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un nom tapez 1"))
    if choix == 1:
        adresse = input("Entrez l'adresse du client:")
        sql = "INSERT INTO Client (adresse) VALUES (%s)" %(adresse)
        cur.execute(sql)

    choix = int(input("Si vous voulez entrer un numero de telephone tapez 1"))
    if choix == 1:
        telephone = input("Entrez le numero de telephone du client:")
        sql = "INSERT INTO Client (numero_telephone) VALUES (%s)" %(telephone)
        cur.execute(sql)

    conn.connect()
    conn.close()


def insert_proprio():
    cur = conn.cursor()

    insert_client()

    id_c = int(input("Entrez l'id du proprietaire:"))
    sql = "INSERT INTO AssocAnimalClient (id_client) VALUES (%d)" %(id_c)
    cur.execute(sql)

    id_a = int(input("Entrez l'id de l'animal:"))
    sql = "INSERT INTO AssocAnimalClient (id_animal) VALUES (%d)" %(id_a)
    cur.execute(sql)

    date_d = int(input("Entrez la date de debut du proprietaire:"))
    sql = "INSERT INTO AssocAnimalClient (date_debut) VALUES (%s)" %(date_d)
    cur.execute(sql)

    choix = int(input("Si vous voulez rentrer une date de fin tapez 1:"))
    if choix == 1:
        date_f = int(input("Entrez la date de fin pour ce proprietaire:"))
        sql = "INSERT INTO AssocAnimalClient (date_fin) VALUES (%s)" %(date_f)
        cur.execute(sql)
    
    conn.connect()
    conn.close()


# Insérer un animal (gérer les propriétaires et les champs inconnus)
def inserer_animal():
    cur = conn.cursor()

    id_animal = int(input("Entrez l'id de l'animal"))
    sql = "INSERT INTO Animal (id-animal) VALUES (%d)" % (id_animal)
    cur.execute(sql)

    choix = int(input("Si vous voulez rentrer un nom tapez 1:"))
    if choix == 1:
        nom = input("Entrez le nom de l'animal")
        sql = "INSERT INTO Animal (nom) VALUES (%s)" % (nom)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer une date de naissance tapez 1:"))
    if choix == 1:
        date_de_naissance = input("Entrez la date de naissance: ")
        sql = "INSERT INTO Animal (date_de_naissance) VALUES (%s)" % (date_de_naissance)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrez un numero de puce tapez 1:"))
    if choix == 1:
        num_puce = input("Entrez le numero de puce")
        sql = "INSERT INTO Animal (num_puce) VALUES (%s)" % (num_puce)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer un numero de passeport tapez 1:"))
    if choix == 1:
        passeport = input("Entrez le numero de passeport")
        sql = "INSERT INTO Animal (passeport) VALUES (%s)" % (passeport)
        cur.execute(sql)

    type = input("Entrez le type")
    sql = "INSERT INTO Animal (type) VALUES (%s)" % (type)
    cur.execute(sql)

    #cur.execute(sql) #à enlever ???
    conn.connect()
    conn.close()


# 5)Insérer un médicament.
def inserer_medicament():
    cur = conn.cursor()
    nom_molecule = input("Entrez le nom du medicament: ")
    sql = "INSERT INTO Medicament (nom_molecule) VALUES (%s)" % (nom_molecule)
    cur.execute(sql)

    choix = int(input("Si vous voulez rentrer une description tapez 1:"))
    if choix == 1:
        description_effet = input("Entrez la description des effets: ")
        sql = "INSERT INTO Medicament (description_effet) VALUES (%s)" % (description_effet)
        cur.execute(sql)


    #cur.execute(sql) #à enlever ???
    conn.connect()
    conn.close()


# 6)Insérer une entrée dans un dossier médical (gérer tous les cas).
def inserer_entree():
    cur = conn.cursor()
    saisie = datetime.now()
    sql = "INSERT INTO Entree (saisie) VALUES (%s)" % (saisie) #type de saisie ?
    cur.execute(sql)

    id_animal = int(input("Entrez l'id de l'animal:"))
    sql = "INSERT INTO Entree (id_animal) VALUES (%d)" % (id_animal)
    cur.execute(sql)

    choix = int(input("Si vous voulez rentrer une taille tapez 1:"))
    if choix == 1:
        taille = float(input("Entrez la taille de l'animal:"))
        sql = "INSERT INTO Entree (taille) VALUES ("%f")" % (taille)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer un poids tapez 1:"))
    if choix == 1:
        poids = float(input("Entrez le poids de l'animal:"))
        sql =" INSERT INTO Entree (poids) VALUES ("%f")" % (poids)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer un resultat d'analyse tapez 1:"))
    if choix == 1:
        resultat_analyse = input("Entrez le resultat d'analyse de l'animal:")
        sql = "INSERT INTO Entree (resultat_analyse) VALUES (%s)" % (resultat_analyse)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer un une procedure tapez 1:"))
    if choix == 1:
        procedure = input("Entrez la procedure :")
        sql = "INSERT INTO Entree (procedure) VALUES (%s)" % (procedure)
        cur.execute(sql)

    choix = int(input("Si vous voulez rentrer une descrption de procedure tapez 1:"))
    if choix == 1:
        description_procedure = input("Entrez la description de procedure :")
        sql = "INSERT INTO Entree (description_procedure) VALUES (%s)" % (description_procedure)
        cur.execute(sql)

    id_observation = int(input("Entrez l'id d'observation :"))
    sql = "INSERT INTO Entree (id_observation) VALUES (%d)" % (id_observation)
    cur.execute(sql)

    conn.connect()
    conn.close()