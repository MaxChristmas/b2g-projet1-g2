$PORT = "22"
$DEBUG = $true
$DEFAULT_USER = "wilder"
$DEFAULT_HOST = "172.16.10.20"

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
        $user = Read-Host -Prompt "Entrer un nom d'utilisateur ($DEFAULT_USER)"
        $userhost = Read-Host -Prompt "Entrer une adress IP ($DEFAULT_HOST)"

        if (($userhost -eq $DEFAULT_HOST) -and ($user -eq $DEFAULT_USER)) {
           break
        }
    }
}

function RemoteCommand {
    param(
        [string]$Command
    )
    $sshCommand = "ssh -t $DEFAULT_USER@$DEFAULT_HOST '$Command'"
    Invoke-Expression -Command $sshCommand
}

function createUserAccount {
    Write-Host $menu1_opt1
}

function deleteUserAccount {
    Write-Host $menu1_opt2
}

function addGroup {
    Write-Host $menu1_opt3
}

function addUserInGroup {
    Write-Host $menu1_opt4
}

function getUserLastConnection {
    RemoteCommand -Command "net user $DEFAULT_USER"
}

function getHostName {
    Write-Host -ForegroundColor Cyan "Le nom de la machine distante est: "    
    RemoteCommand -Command "hostname"
}


function getHostInfo {
    RemoteCommand -Command  "wmic os get Caption,Version"
}

function getDiskUsage {
    RemoteCommand -Command "wmic logicaldisk get Name,Description,FreeSpace"
}

function rebootRemoteDevice {
    RemoteCommand -Command "shutdown /r /t 0"
}

function shutdownRemoteDevice {
    RemoteCommand -Command "shutdown /s /t 0"
}

function quit {
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host -ForegroundColor Blue "    Bye!"
    Write-Host -ForegroundColor Blue "    Au plaisir de vous revoir!"
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

$continue = $true
while ($continue) {
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host -ForegroundColor Blue "    Choisir une action ou afficher des informations"
    Write-Host -ForegroundColor Blue "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    Write-Host $menu1_opt1
    Write-Host $menu1_opt2
    Write-Host $menu1_opt3
    Write-Host $menu1_opt4
    Write-Host $menu1_opt5
    Write-Host $menu1_opt6
    Write-Host $menu1_opt7
    Write-Host $menu1_opt8
    Write-Host $menu1_opt9
    Write-Host $menu1_opt10
    Write-Host $menu1_opt11
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
