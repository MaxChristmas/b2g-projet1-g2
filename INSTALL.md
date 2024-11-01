

## Installation des machines Linux

###  1. Mise en place

Télécharger et installer [Debian 12](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.7.0-amd64-netinst.iso) sur virtualbox  
Télécharger et installer [Ubuntu 24.04 LTS](https://releases.ubuntu.com/24.04.1/ubuntu-24.04.1-desktop-amd64.iso) sur virtualbox

- Sur la machine virtuelle Debian (serveur)    
    * Nom de la machine : ```SRVLX01```
    * Utilisateur ID : ```root```
    * Utilisateur Pass : ```Azerty1*```  
- Sur la machine virtuelle Ubuntu (client)
    * Nom de la machine : ```CLILIN01```
    * Utilisateur ID : ```wilder``` (groupe sudo)
    * Utilisateur Pass : ```Azerty1*```

Paramétrer virtualbox sur mode le mode "Accès par pont" ou "Réseau interne"

    1- Aller dans les paramètres de la machine virtuelle Debian.
    2- Sélectionner l'onglet "Réseau".
    3- Choisir "Accès par pont" ou "Réseau interne" pour l'adaptateur réseau.
    4- Répéter les étapes 1 à 3 pour la machine virtuelle Ubuntu.

Installer openssh

- Sur la machine virtuelle Debian (serveur)
    ``` 
    sudo apt update
    sudo apt install openssh-server
    sudo systemctl start ssh
    sudo systemctl enable ssh
    ```
- Sur la machine virtuelle Ubuntu (client)
    ``` 
    sudo apt update
    sudo apt install openssh-server
    ```
 
### 2. Configuration des adresses IP

#### Sur la machine virtuelle Debian (serveur)  
 1. Éditer le fichier de configuration réseau :  
     ``` 
     sudo nano /etc/network/interfaces  
     ```
 2. Ajouter la configuration statique pour l'interface réseau :
    ``` 
    auto enp0s3
    iface enp0s3 inet static
        address 172.16.10.10
        netmask 255.255.255.0  
    ```
  3. Redémarrer le service réseau : 
     ```  
     sudo service networking stop  
     sudo service networking start
     ``` 

#### Sur la machine virtuelle Ubuntu (client)
 1. Éditer le fichier de configuration Netplan (fichier .yaml dans /etc/netplan) :  
     ``` 
     sudo nano /etc/netplan/50-cloud-init.yaml  
     ``` 
 2. Ajouter la configuration statique pour l'interface réseau :
     ``` 
    network:    
        version: 2  
        ethernets:
            enp0s3:
                dhcp4: no
                addresses: [172.16.10.30/24]
     ```
  3. Aplliquer la configuration :  
     ``` 
     sudo netplan apply
     ```
### 3. Test de connectivité
- Sur la machine virtuelle Debian (serveur)
    ``` 
    ping 172.16.10.30
    ```
- Sur la machine virtuelle Ubuntu (client)
    ``` 
    ping 172.16.10.10
    ```


### 4. Connection client-serveur

#### Configuration de la connection SSH sur la machine virtuelle Debian (serveur)
 1. Générer une clé SSH :  
     ``` 
     ssh-keygen -t rsa -b 4096 -C "admin@projet1"  
     ``` 
 2. Copier la clé publique sur la machine distante :
     ``` 
    ssh-copy-id wilder@172.16.10.30
     ```
  3. Tester la connexion SSH :  
     ``` 
     ssh wilder@172.16.10.30
     ```
## Installation des machines Windows

###  1. Mise en place

Télécharger et installer [Windows Server 2022](https://www.microsoft.com/fr-fr/evalcenter/download-windows-server-2022) sur virtualbox  
Télécharger et installer [Windows 10 Entreprise](https://www.microsoft.com/fr-fr/evalcenter/download-windows-10-enterprise) sur virtualbox

- Sur la machine virtuelle Windows Server    
    * Nom de la machine : ```SRVWIN01```
    * Utilisateur ID : ```Administrator```
    * Utilisateur Pass : ```Azerty1*```  
- Sur la machine virtuelle Windows Entreprise
    * Nom de la machine : ```CLIWIN01```
    * Utilisateur ID : ```wilder``` (groupe admin)
    * Utilisateur Pass : ```Azerty1*```

Installer openssh

- Sur les deux machines, installer Serveur Open SSH dans les fonctionnalités facutatives

### 2. Configuration des adresses IP
- Sur la machine virtuelle Windows Serveur
    * Dans _***"Panneau de configuration > Réseau et internet > Réseau et partage > Modifier les paramètres de la carte"***_  cliquer-droit et sélectionner _***"Propriétés"***_ 
    * Double cliquer sur Protocol Internet Version 4 (TCP/IPv4), entrer la configuration réseau et valider  
      . Adresse IP : _***176.16.10.5***_  
      . Masque de sous-réseau : _***255.255.255.0***_
    * Désactiver le Firewall
    * Redémarrer la machine

- Sur la machine virtuelle Windows Entreprise
    * Dans _***"Panneau de configuration > Réseau et internet > Réseau et partage > Modifier les paramètres de la carte"***_  cliquer-droit et sélectionner _***"Propriétés"***_ 
    * Double cliquer sur Protocol Internet Version 4 (TCP/IPv4), entrer la configuration réseau et valider  
      . Adresse IP : _***176.16.10.20***_    
      . Masque de sous-réseau : _***255.255.255.0***_
    * Désactiver le Firewall
    * Rédémarrer la machine
    
### 3. Test de connectivité
- Sur la machine virtuelle Windows Serveur
    ``` 
    ping 172.16.10.20
    ```
- Sur la machine virtuelle Windows Entreprise
    ``` 
    ping 172.16.10.5
    ```
### 4. Connection client-serveur

#### Configuration de la connection SSH sur la machine virtuelle Windows Serveur
 1. Générer une clé SSH :  
     ``` 
     ssh-keygen -t rsa -b 4096 -C "admin@projet1"  
     ``` 
 2. Tester la connexion SSH :  
     ``` 
     ssh wilder@172.16.10.20
     ```
 
 3. Copier la clé publique sur la machine distante :
- Sur la machine virtuelle Windows Serveur
  * Copier le contenu de  
    ```
    C:\Users\<username>\.ssh\id_rsa.pub
     ```
- Sur la machine virtuelle Windows Entreprise
  * Coller le contenu dans
    ```
    C:\Users\wilder\.ssh\authorized_keys 
    ```

