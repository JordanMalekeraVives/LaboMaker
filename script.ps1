function addLabo {
    $path = Get-Location
    $labo = Read-Host -Prompt "Naam van labo?"

    if (Test-Path -Path $path\$labo) {
        write-host $path\$labo
        write-warning "Deze labo bestaat al"
        addLabo
    }
    else {
        try {
            mkdir $labo -ErrorAction Stop
        }
        catch {
            Write-Error $Error[0]
            Write-Warning 'Een bestandsnaam mag geen van de volgende tekens bevatten: \ / : * ? " < > |'
            addLabo
        }
        Set-Location $labo
        Write-Host $(Get-Location)
        addOpdracht
        cd..
    }
}

function addOpdracht {
    $path = Get-Location
    $aantal = Read-Host -Prompt "Hoeveel opdrachten?"
    for ($i = 0; $i -lt $aantal; $i++) {
        $opdracht = Read-Host -Prompt "Naam opdracht $($i + 1)"
        if (Test-Path -Path $path\$labo) {
            write-host $path\$opdracht
            write-warning "Deze opdracht bestaat al"
            $i = 0
        }
        try {
            mkdir $opdracht -ErrorAction Stop
            Copy-Item ..\template\* -recurse -Force -Destination $opdracht
        }
        catch {
            $i--
            Write-Error $Error[0]
            Write-Warning 'Een bestandsnaam mag geen van de volgende tekens bevatten: \ / : * ? " < > |'
        }
    }
}
addLabo