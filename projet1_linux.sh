#!/bin/bash

# Variables
USER="wilder"
HOST="172.16.10.30"
PORT="22"

# Exécuter une commande sur la machine distante
remote_command() {
    local COMMAND=$1
    ssh -p $PORT $USER@$HOST "$COMMAND"
    exit
}

# Utilise la commande uname pour obtenir le nom de la machine
nomClient() {
	REMOTE_NAME=$(remote_command "uname -n")
	echo "Nom de machine distante: $REMOTE_NAME"
}

# Utilise la commande uname pour obtenir le nom et la version de l'OS
nomVerClient() {
	REMOTE_UNAME=$(remote_command "uname -sr")
	echo "Nom de l'OS et version de la machine distante: $REMOTE_UNAME"
}

# Utilise la commande last pour obtenir la dernière connexion de l'utilisateur
derniereCo() {    
    REMOTE_DERNIERE_CO=$(remote_command "last $USER | head -n 1 | awk '{print \$1 \": depuis \" \$3 \" le \" \$4 \" \" \$5 \" \" \$6 \" \" \$7 \" \" \$8 \" \" \$9 \" \" \$10}'")
    echo "Dernière connexion de $REMOTE_DERNIERE_CO"
}

# Redémarre la machine distante
rebootRemote() {
	REMOTE_REBOOT=$(remote_command "sudo reboot")
	echo "Redémarrage de la machine distante"
}

# Utilise la commande df pour récupérer les infos disque
getDiskUsage() {
	DISKUSAGE="df -h | grep 'sda' | awk '{print \"Disque: \" \$1 \" Espace Disponible : \" \$4 \"-\" \$5}'"
	REMOTE_DISK=$(remote_command "$DISKUSAGE")
	echo "Utilisation du disque: $REMOTE_DISK"
}

menu1_opt1="Création de compte"
menu1_opt2="Suppression de compte"
menu1_opt3="Ajout d'un utilisateur dans un groupe"
menu1_opt4="Dernière connexion de l'utilisateur"
menu1_opt5="Nom de la machine"
menu1_opt6="Nom et Version de l'OS"
menu1_opt7="Etat du disque"
menu1_opt8="Redémarrer"
menu1_opt9="Arrêter"
menu1_opt10="Quitter"

# Prompt du select et options
PS3="Sélectionner votre choix: "
options=("$menu1_opt1" "$menu1_opt2" "$menu1_opt3" "$menu1_opt4" "$menu1_opt5" "$menu1_opt6" "$menu1_opt7" "$menu1_opt8" "$menu1_opt9" "$menu1_opt10")
select opt in "${options[@]}"
do
    case $opt in
		$menu1_opt1)
			
			;;
		$menu1_opt2)
			
			;;
		$menu1_opt3)
			
			;;
		$menu1_opt4)
			derniereCo
			;;
		$menu1_opt5)
			nomClient
			;;
		$menu1_opt6)
			nomVerClient
			;;
		$menu1_opt7)
			getDiskUsage
			;;
		$menu1_opt8)
			rebootRemote
			;;
		$menu1_opt9)
		
			;;
		$menu1_opt10)
			break
			;;
		*) echo "Invalid option $REPLY";;
    esac
done
