PORT="22"
DEBUG=1

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

#Menu's choices listing
echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
echo -e "${BLUE}    Choisir une action ou afficher des informations${NC}"
echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
menu1_opt5="Dernière connexion de l'utilisateur"
menu1_opt6="Nom de la machine"
menu1_opt7="Nom et Version de l'OS"
menu1_opt8="Etat du disque"
menu1_opt9="Redémarrer"
menu1_opt10="Arrêter"
menu1_opt11="Quitter"


USER="wilder"
HOST="172.16.10.20"

# SSH connection
remoteCommand() {
    local COMMAND=$1
    ssh -p $PORT $USER@$HOST "$COMMAND"
    exit
}

# Get the user last connection informations
getUserLastConnection() {    
    REMOTE_DERNIERE_CO=$(remoteCommand "net user $USER")
    echo -e "${YELLOW}Dernière connexion de${NC} ${RED}$REMOTE_DERNIERE_CO${NC}"
}

# Get the remote host name
getHostName() {
	REMOTE_NAME=$(remoteCommand "hostname")
	echo -e "${YELLOW}Nom de machine distante:${NC} ${RED}$REMOTE_NAME${NC}"
}

# Get the OS name and version
getHostInfo() {
	REMOTE_UNAME=$(remoteCommand "wmic os get Caption,Version")
	echo -e "${YELLOW}Nom de l'OS et version de la machine distante:${NC} ${RED}$REMOTE_UNAME${NC}"
}

# Retrieve remote device's disk state
getDiskUsage() {
	REMOTE_DISK=$(remoteCommand "wmic logicaldisk get Name,Description,FreeSpace")
	echo -e "${YELLOW}Utilisation du disque:${NC} ${RED}$REMOTE_DISK${NC}"
}

# Restart the remote device
rebootRemoteDevice() {
	REMOTE_REBOOT=$(remoteCommand "shutdown /r /t 0")
	echo -e "${YELLOW}Redémarrage de la machine distante${NC}"
}

# Shutdown the remote device
shutdownRemoteDevice() {
	REMOTE_SHUTDOWN=$(remoteCommand "shutdown /s /t 0")
	echo -e "${YELLOW}Arrêt de la machine distante${NC}"
}

# Exit command menu
quit() {
	echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
	echo -e "${BLUE}    Au plaisir de vous revoir!${NC}"
	echo -e "${BLUE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++${NC}"
}

log $USER "********StartScript********"

# Select and options prompt
PS3="Sélectionner votre choix: "
options=("$menu1_opt5" "$menu1_opt6" "$menu1_opt7" "$menu1_opt8" "$menu1_opt9" "$menu1_opt10" "$menu1_opt11")
select opt in "${options[@]}"
do
    case $opt in
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
