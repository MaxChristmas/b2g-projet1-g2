# **Présentation** 

Le projet contient deux programmes:
- Script LINUX : Adapté pour une utilisation d'un serveur Linux vers des clients distants également sous environnement Linux.
- Script WINDOWS : Adapté pour une utilisation sur un serveur Windows vers des clients cibles également sous exploitation Windows.

Les parties suivantes proposent un guide détaillé de chaque commande pour les deux distributions, respectivement Linux et Windows. 

 # **LINUX** 
Cette partie décrit les fonctionnalités du programme permettant de gérer les utilisateurs et d'administrer un système Linux. Il est divisé en trois sections : **Gestion des utilisateurs** , **Gestion du système** et **Récupération de données**. Vous y trouverez des instructions pour accomplir des tâches courantes de gestion et d'administration proposées par le script.

Pour initialiser le script sous Linux, tapez la commande suivante :
``` 
    bash ./projet1-linux.sh
  ```
  
Pour initialiser le script sous Windows, tapez la commande suivante :
``` 
    (à compléter)
  ```

A l'initialisation du programme, il vous sera demandé d'entrer : 
- Le nom de l'utilisateur 
- L'adresse IP du poste client ciblé  

Le programme vous propose alors un menu comportant les options suivantes : 
- 1) Création d'un utilisateur
- 2) Suppression d'un utilisateur
- 3) Création d'un groupe
- 4) Ajout d'un utilisateur dans un groupe
- 5) Afficher la dernière connexion de l'utilisateur
- 6) Nom de la machine
- 7) Nom et version de l'OS
- 8) Etat du disque 
- 9) Redémarrer la machine
- 10) Arrêter la machine
- 11) Quitter

Les différentes commandes sont exhaustivement détaillées ci-après.
## I - 1. Gestion des utilisateurs

### *1.1-Création d'un utilisateur*
Cette option permet la création d'un utilisateur. Il vous sera demandé : d'entrer son nom puis de de choisir un mot de passe. Si le nom de l'utilisateur n'est pas disponible, un message d'erreur est renvoyé.
Commande utilisée par le script sous Linux:
``` 
    useradd <nom_utilisateur> -m"
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
### *1.2-Suppression d'un utilisateur*
Le programme permet également de supprimer un utilisateur. Il vous sera demandé de rentrer le nom de l'utilisateur que vous souhaitez supprimer. La suppression comprends également le répertoire de l'utilisateur.
Commande utilisée par le script sous Linux:
``` 
   deluser --remove-home <nom_utilisateur>
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
### *1.3-Création d'un groupe*
Créer un nouveau groupe d'utilisateur. 
Commande utilisée par le script sous Linux:
``` 
   groupadd <nom_groupe>
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
### *1.4-Ajout d'un utilisateur dans un groupe*
Permet d'ajouter un utilisateur dans un nouveau groupe.
Commande utilisée par le script sous Linux:
``` 
   usermod -aG <nom_groupe> <nom_utilisateur>
  ```

### *1.5-Afficher la dernière connexion d'un utilisateur*
Affiche la dernière date de connexion de l'utilisateur ciblé.
Commande utilisée par le script sous Linux:
``` 
   lastlog -u <nom_utilisateur>
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
## I - 2. Récupérer des informations

### *2.1-Récupérer les informations d'utilisation du disque dur*
L'option de récupération des informations du disque dur affiche l'état de la partition principale en affichant son nom, l'espace disponible en giga-octets et le pourcentage total restant.
Commande utilisée par le script sous Linux:
``` 
   df -h
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
### *2.2-Récupérer le nom de la machine*
Cette option affiche le nom de la machine du client ciblé.
Commande utilisée par le script sous Linux:
``` 
   uname -n
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
  
### *2.3-Récupérer le nom et la version de l'OS*
Cette commande affiche des informations sur le système d'exploitation installé en renvoyant le nom du système et sa version.
Commande utilisée par le script sous Linux:
``` 
   uname -sr
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
## I - 3. Gestion du système

### *2.4-Redémarrer la machine*
Redémarre la machine distante
Commande utilisée par le script sous Linux:
``` 
   reboot
  ```

Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```
### *2.5-Arrêter la machine*
Arrête le client ciblé
Commande utilisée par le script sous Linux:
``` 
   shutdown now
  ```
  
Commande utilisée par le script sous Windows:
``` 
   (à compléter)
  ```

