#!/bin/bash

DEBUG=1
PORT="22"

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
	echo "Nom de machine distante: $REMOTE_NAME"
}

# Get the OS name and version
getHostInfo() {
	REMOTE_UNAME=$(remoteCommand "uname -sr")
	echo "Nom de l'OS et version de la machine distante: $REMOTE_UNAME"
}

# Get the user last connection date
getUserLastConnection() {    
    REMOTE_DERNIERE_CO=$(remoteCommand "last $USER | head -n 1 | awk '{print \$1 \": depuis \" \$3 \" le \" \$4 \" \" \$5 \" \" \$6 \" \" \$7 \" \" \$8 \" \" \$9 \" \" \$10}'")
    echo "Dernière connexion de $REMOTE_DERNIERE_CO"
}

# Restart the distant device
rebootRemoteDevice() {
	REMOTE_REBOOT=$(remoteCommand "sudo reboot")
	echo "Redémarrage de la machine distante"
}

# Retrieve distance device's disk state
getDiskUsage() {
	DISKUSAGE="df -h | grep 'sda' | awk '{print \$1 \" Espace Disponible: \" \$4 \"-\" \$5}'"
	REMOTE_DISK=$(remoteCommand "$DISKUSAGE")
	echo "Utilisation du disque: $REMOTE_DISK"
}

# Add a user
createUserAccount(){
	read -p "Entrer le nom de l'utilisateur : " login_user	
	REMOTE_ADD_USER=$(remoteCommand "sudo -s useradd $login_user -m")
	REMOTE_ADD_USER=$(remoteCommand "sudo -s passwd $login_user")
}

# Delete a user
deleteUserAccount() {
	read -p "Indiquer le nom d'utilisateur à supprimer: " user_deleted	
	DEL_USER=$(remoteCommand "sudo userdel $user_deleted")
}

# Shutdown the distant device
shutdownRemoteDevice() {
	REMOTE_SHUTDOWN=$(remoteCommand "sudo shutdown now")
	echo "Arrêt de la machine distante"
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
			break
			;;
		*) echo "Invalid option $REPLY";;
    esac
done
