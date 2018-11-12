#https://social.technet.microsoft.com/wiki/contents/articles/24541.powershell-bulk-create-ad-users-from-csv-file.aspx
#https://4sysops.com/archives/powershell-classes-part-3-methods/


$csvfile = ".\Documents\NEW_USER\groups.csv"
$logfile = ".\Documents\NEW_USER\logfile.txt"
$date = Get-Date

#----------------------------------------------------------
#STATIC VARIABLES
#----------------------------------------------------------

$users = import-csv $csvfile
$domain_controller = "PoliformaSM"
$ou_afdeling = "PFafdeling"

##########################################

ForEach ($gebruiker in $users ) {
    if ($gebruiker.Manager.Equals("X")) {
        $ou = "Administratie" #manager
        $group = "Administratie" #manager
    }
    if ($gebruiker.IT.Equals("X")) {
        $ou = "Automatisering" #it
        $group = "Automatisering"
    }
    if ($gebruiker.Boekhouding.Equals("X")) {
        $ou = "Directie" #boekhouding 
        $group = "Directie"
    }
    if ($gebruiker.Logistiek.Equals("X")) {
        $ou = "productie" #logistiek
        $group = "productie"
    }
    if ($gebruiker.ImportExport.Equals("X")) {
        $ou = "Staf" # importExport
        $group = "Staf"
    }

    # $gebruiker.Voornaam= $_.Voornaam
    # $gebruiker.Naam = $_.naam
    # $gebruiker.Account = $_.account
    $sam = $gebruiker.Voornaam+ "." + $gebruiker.Naam

    try {
        New-ADUser -Name $sam  -OtherAttributes @{'mail' = $gebruiker.Voornaam+ "." + $gebruiker.Naam + "@fabrikam.com"; UserPrincipalName = $gebruiker.Account}
        write-output "created user $sam" 
    }
    catch {
        write-output "user $sam already exist" 
    }

    # add member to groop but do not delete it from the pre group
    add-ADGroupMember -Identity $group -Members $sam
    write-output "add $sam to the group $group" 
 
    Move-ADobject (get-aduser $sam).DistinguishedName -TargetPath "OU=$OU,OU=$ou_afdeling,DC=$domain_controller,DC=be";
    write-output "move $sam to the OU= $ou and the afdeling= $ou_afdeling " 

    $huidigeGroupen = @()
    foreach ($group in Get-ADPrincipalGroupMembership $sam | select name) {
        if ($group.name -ne "Domain Users") {
            $huidigeGroupen += $group.name
        }
    }
    
    foreach ($group in $huidigeGroupen) {
        if ($group -eq $ou) {
        }
        else {
            Remove-ADGroupMember -Identity $group -Members $sam
            write-output "remove $sam from the group= $group  "  
        }
    }


}

