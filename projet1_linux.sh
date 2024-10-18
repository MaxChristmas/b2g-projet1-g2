#!/bin/bash

PORT="22"
DEBUG=1

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


if [ $DEBUG -eq 1 ]; then
	USER="wilder"
	HOST="172.16.10.30"
else
	while true; do
		read -p "Entrer une adress IP (172.16.10.30): " HOST
		read -p "Entrer un nom d'utilisateur (wilder): " USER
		if [[ $HOST == "172.16.10.30" ]] && [[ $USER == "wilder" ]]; then
		    break
		fi
	done
fi

# Execute defined command on distant device
remoteCommand() {
    local COMMAND=$1
    ssh -p $PORT $USER@$HOST "$COMMAND"
    exit
}

# Get the distant host name
getHostName() {
	REMOTE_NAME=$(remoteCommand "uname -n")
	echo -e "${YELLOW}Nom de machine distante:${NC} ${RED}$REMOTE_NAME${NC}"
}

# Get the OS name and version
getHostInfo() {
	REMOTE_UNAME=$(remoteCommand "uname -sr")
	echo -e "${YELLOW}Nom de l'OS et version de la machine distante:${NC} ${RED}$REMOTE_UNAME${NC}"
}

# Get the user last connection date
getUserLastConnection() {    
    REMOTE_DERNIERE_CO=$(remoteCommand "last $USER | head -n 1 | awk '{print \$1 \": depuis \" \$3 \" le \" \$4 \" \" \$5 \" \" \$6 \" \" \$7 \" \" \$8 \" \" \$9 \" \" \$10}'")
    echo -e "${YELLOW}Dernière connexion de${NC} ${RED}$REMOTE_DERNIERE_CO${NC}"
}

# Restart the distant device
rebootRemoteDevice() {
	REMOTE_REBOOT=$(remoteCommand "sudo reboot")
	echo -e "${YELLOW}Redémarrage de la machine distante${NC}"
}

# Retrieve distance device's disk state
getDiskUsage() {
	DISKUSAGE="df -h | grep 'sda' | awk '{print \$1 \" Espace Disponible: \" \$4 \"-\" \$5}'"
	REMOTE_DISK=$(remoteCommand "$DISKUSAGE")
	echo -e "${YELLOW}Utilisation du disque:${NC} ${RED}$REMOTE_DISK${NC}"
}

# Add a user
createUserAccount(){
	read -p "Entrer le nom de l'utilisateur : " login_user	
	REMOTE_ADD_USER=$(remoteCommand "sudo -s useradd $login_user -m")
	REMOTE_ADD_USER=$(remoteCommand "sudo -s passwd $login_user")
	echo -e "${YELLOW}L'utilisateur${NC} ${RED}$login_user${NC} ${YELLOW}a été ajoutté${NC}"
}

# Delete a user
deleteUserAccount() {
	read -p "Indiquer le nom d'utilisateur à supprimer: " user_deleted	
	DEL_USER=$(remoteCommand "sudo userdel -r $user_deleted")
	echo -e "${YELLOW}L'utilisateur${NC} ${RED}$user_deleted${NC} ${YELLOW}a été supprimé${NC}"
}

# Shutdown the distant device
shutdownRemoteDevice() {
	REMOTE_SHUTDOWN=$(remoteCommand "sudo shutdown now")
	echo -e "${YELLOW}Arrêt de la machine distante${NC}"
}

# Add group
addGroup() {
	REMOTE_SHUTDOWN=$(remoteCommand "sudo shutdown now")
	echo -e "${YELLOW}Arrêt de la machine distante${NC}"
}


# Exit command menu
quit() {
	echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
	echo -e "${BLUE}    Bye!\n    Au plaisir de vous revoir!${NC}"
	echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
}

#Menu's choices listing
menu1_opt1="Création d'un compte utilisateur"
menu1_opt2="Suppression d'un compte utilisateur"
menu1_opt3="Création d'un groupe"
menu1_opt4="Ajout d'un utilisateur dans un groupe"
menu1_opt5="Dernière connexion de l'utilisateur"
menu1_opt6="Nom de la machine"
menu1_opt7="Nom et Version de l'OS"
menu1_opt8="Etat du disque"
menu1_opt9="Redémarrer"
menu1_opt10="Arrêter"
menu1_opt11="Quitter"

echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
echo -e "${BLUE}    Choisir une action ou afficher des informations${NC}"
echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"

# Select and options prompt
PS3="Sélectionner votre choix: "
options=("$menu1_opt1" "$menu1_opt2" "$menu1_opt3" "$menu1_opt4" "$menu1_opt5" "$menu1_opt6" "$menu1_opt7" "$menu1_opt8" "$menu1_opt9" "$menu1_opt10" "$menu1_opt11")
select opt in "${options[@]}"
do
    case $opt in
		$menu1_opt1)
			createUserAccount
			;;
		$menu1_opt2)
			deleteUserAccount
			;;
		$menu1_opt3)
			
			;;
		$menu1_opt4)
			
			;;
		$menu1_opt5)
			getUserLastConnection
			;;
		$menu1_opt6)
			getHostName
			;;
		$menu1_opt7)
			getHostInfo
			;;
		$menu1_opt8)
			getDiskUsage
			;;
		$menu1_opt9)
			rebootRemoteDevice
			;;
		$menu1_opt10)
			shutdownRemoteDevice
			;;
		$menu1_opt11)
			quit
			break
			;;
		*) echo -e "${RED}Invalid option $REPLY${NC}";;
    esac
done
