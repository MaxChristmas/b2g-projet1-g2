$PORT = "22"
$DEBUG = $true
$DEFAULT_USER = "wilder"
$DEFAULT_HOST = "172.16.10.20"

# menu's choices listing
$menu1_opt1 = "1. Creation d'un compte utilisateur"
$menu1_opt2 = "2. Suppression d'un compte utilisateur"
$menu1_opt3 = "3. Creation d'un groupe"
$menu1_opt4 = "4. Ajout d'un utilisateur dans un groupe"
$menu1_opt5 = "5. Derniere connexion de l'utilisateur"
$menu1_opt6 = "6. Nom de la machine"
$menu1_opt7 = "7. Nom et Version de l'OS"
$menu1_opt8 = "8. Etat du disque"
$menu1_opt9 = "9. Redemarrer"
$menu1_opt10 = "10 .Arreter"
$menu1_opt11 = "11. Quitter"

if ($DEBUG) {
    $user = $DEFAULT_USER
    $userhost = $DEFAULT_HOST
} else {
    while ($true) {
        $user = Read-Host "Entrer un nom d'utilisateur ($DEFAULT_USER)"
        $userhost = Read-Host "Entrer une adress IP ($DEFAULT_HOST)"

        if (($userhost -eq $DEFAULT_HOST) -and ($user -eq $DEFAULT_USER)) {
           break
        }
    }
}

# SSH connection
function RemoteCommand {
    param(
        [string]$Command
    )
    $sshCommand = "ssh -t $DEFAULT_USER@$DEFAULT_HOST '$Command'"
    Invoke-Expression -Command $sshCommand
}

# create a user
function createUserAccount {
    Write-Host "Entrer le nom du nouvel utilisateur:"
    $new_username = Read-Host
    Write-Host "Entrer le mot de passe du nouvel utilisateur:"
    $password = Read-Host -AsSecureString
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    RemoteCommand -Command "net user $new_username $password /add /active:yes"
    RemoteCommand -Command "net user"
}

# delete a user
function deleteUserAccount {
    Write-Host "Entrer le nom d'utilisateur à supprimer:"
    $del_username = Read-Host
    RemoteCommand -Command "net user $del_username /delete"
    RemoteCommand -Command "net user"
}

# add a group
function addGroup {
    $newgroup = Read-Host "Entrer le nom du groupe à créer"
	RemoteCommand -Command "net localgroup $newgroup /add"
	RemoteCommand -Command "net localgroup"
}

# add a user in a group
function addUserInGroup {
    $addingroup = Read-Host "Entrer le nom du groupe"
    $addinuser = Read-Host "Entrer le nom de l'utilisateur"
    RemoteCommand -Command "net localgroup $addingroup $addinuser /add"
    RemoteCommand -Command "net localgroup $addingroup"
}

# retrieve user last connection informations
function getUserLastConnection {
    RemoteCommand -Command "net user $DEFAULT_USER"
}

# retrieve remote device host name
function getHostName {
    Write-Host -ForegroundColor Cyan "Le nom de la machine distante est: "    
    RemoteCommand -Command "hostname"
}

# retrieve remote device OS name and version
function getHostInfo {
    RemoteCommand -Command  "wmic os get Caption,Version"
}

# retrieve disk usage informations
function getDiskUsage {
    RemoteCommand -Command "wmic logicaldisk get Name,Description,FreeSpace"
}

# reboot remote device
function rebootRemoteDevice {
    RemoteCommand -Command "shutdown /r /t 0"
}

# shutdown remote device
function shutdownRemoteDevice {
    RemoteCommand -Command "shutdown /s /t 0"
}

# exit script
function quit {
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host -ForegroundColor Blue "    Bye!"
    Write-Host -ForegroundColor Blue "    Au plaisir de vous revoir!"
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

# menu displaying
$continue = $true
while ($continue) {
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host -ForegroundColor Blue "    Choisir une action ou afficher des informations"
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host "    $menu1_opt1"
    Write-Host "    $menu1_opt2"
    Write-Host "    $menu1_opt3"
    Write-Host "    $menu1_opt4"
    Write-Host "    $menu1_opt5"
    Write-Host "    $menu1_opt6"
    Write-Host "    $menu1_opt7"
    Write-Host "    $menu1_opt8"
    Write-Host "    $menu1_opt9"
    Write-Host "    $menu1_opt10"
    Write-Host "    $menu1_opt11"
    $choix = Read-Host "Faire un choix"
    switch ($choix) {
        1 {
            createUserAccount
        }
        2 {
            deleteUserAccount
        }
        3 {
            addGroup
        }
        4 {
            addUserInGroup
        }
        5 {
            getUserLastConnection
        }
        6 {
            getHostName
        }
        7 {
            getHostInfo
        }
        8 {
            getDiskUsage
        }
        9 {
            rebootRemoteDevice
        }
        10 {
            shutdownRemoteDevice
        }
        11 {
            quit
            $continue = $false
        }
        default {
            Write-Host "Choix invalide" -ForegroundColor Red
        }
    }
}
