## 1. Mise en place

### Installation des machines Linux

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

Paramétrer virtualbox sur mode le mode "Accès par pont"

    1- Aller dans les paramètres de la machine virtuelle Debian.
    2- Sélectionner l'onglet "Réseau".
    3- Choisir "Accès par pont" pour l'adaptateur réseau.
    5- Répéter les étapes 1 à 3 pour la machine virtuelle Ubuntu.

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
    sudo apt install openssh-client
    ```
 
### Configuration des adresses IP

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
### Test de connectivité
- Sur la machine virtuelle Debian (serveur)
    ``` 
    ping 172.16.10.30
    ```
- Sur la machine virtuelle Ubuntu (client)
    ``` 
    ping 172.16.10.10
    ```


## 2. Connection client-serveur

### Configuration de la connection SSH sur la machine virtuelle Debian (serveur)
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
