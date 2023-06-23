from interface import *


def main():
    print("Bienvenu dans la BDD de la clinique vétérinaire.")

    while Entree != -1:
        print("Que voulez-vous faire ?")
        print("Entrez : ")
        print("   1) INSERER")
        print("   2) REQUETE")
        print("   -1) Pour sortir")
        Entree = int(input())

        if Entree == 1:
            print("Voici les options d'insertion :")
            print(" 1) Insérer un membre du personnel ")
            print(" 2) Insérer un client.")
            print(" 3) Insérer une information de propriétaire pour un animal.")
            print(" 4) Insérer un animal")
            print(" 5) Insérer un médicament.")
            print(" 6) Insérer une entrée dans un dossier médical")
            Entree = int(input("Entrez votre choix :"))
            if Entree == 1:
                insert_personnel()
            elif Entree == 2:
                insert_client()
            elif Entree == 3:
                insert_proprio()
            elif Entree == 4:
                inserer_animal()
            elif Entree == 5:
                inserer_medicament()
            elif Entree == 6:
                inserer_entree()
            else:
                print("L'entree ne correspond pas à un choix possible.")

        elif Entree == "REQUETE":
            print(
                " 1) Lister les quantités de médicaments consommés pour une période donnée."
            )
            print(
                " 2) Lister le nombre de traitements prescrits au cours d'une période donnée."
            )
            print(
                " 3) Lister les procédures effectuées sur un animal donné, avec et triées par date."
            )
            print(" 4) Compter le nombre d'animaux traités groupés par espèce.")
            print(
                " 5) Lister les animaux ayant appartenus à un client donné, triés par date d'adoption, avec le nom et prénom du client, et les informations d'identification de l'animal, sa date de naissance et son espèce."
            )
            print(
                " 6) Même question, pour les animaux appartenant actuellement au client."
            )
            print(
                " 7) Même question, pour les animaux ayant appartenu mais n'appartenant plus au client."
            )
            print(
                " 8) Lister l'évolution de croissance taille et poids d'un animal donné, par ordre chronologique."
            )
            print(
                " 9) Lister les traitements subis par un animal donné avec leurs dates, triés chronologiquement, sans plus de détails."
            )
            print(
                " 10) Lister les traitements en cours pour un animal donné, avec leurs dates, avec le détail des prescriptions (médicaments et quantités par jour)."
            )
            print(
                " 11) Lister les membres de personnel spécialisés dans les reptiles, avec leur poste et toutes leurs informations."
            )
            print(
                " 12) Afficher la liste des animaux ayant été suivis par un vétérinaire donné au cours du dernier mois."
            )
            print(
                " 13) Afficher la liste des vétérinaires ayant suivi un animal donné, avec et triés par leur date de suivi le plus récent."
            )
            Entree = int(input("Entrez votre choix :"))
            if Entree == 1:
                select_quantite_medicament_duree()
            elif Entree == 2:
                select_nombre_traitement_periode()
            elif Entree == 3:
                select_prodedure_animal()
            elif Entree == 4:
                select_compte_animal_type()
            elif Entree == 5:
                select_tous_animaux()
            elif Entree == 6:
                select_anciens_animaux()
            elif Entree == 7:
                select_current_animaux()
            elif Entree == 8:
                select_evolution_taille_poid()
            elif Entree == 9:
                select_traitement_subit_animal()
            elif Entree == 10:
                select_traitement_en_cours_animal()
            elif Entree == 11:
                select_personnel_reptile()
            elif Entree == 12:
                select_animaux_suivi_veterinaire()
            elif Entree == 13:
                select_liste_veto_suivi()
            else:
                print("L'entree ne correspond pas à un choix possible.")
        elif Entree != -1:
            print("L'entree ne correspond pas à un choix possible.")


main()