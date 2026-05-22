# Frågar användaren efter namn på huvudmappen
$mappNamn = Read-Host "Ange mappnamn"

# Funktion som skriver text till en loggfil
function Skriv-Logg {
    param (
        [string]$LoggFil,
        [string]$LoggText
    )

    Add-Content -Path $LoggFil -Value $LoggText -Encoding UTF8
}

try {
    # Kontrollerar att användaren inte lämnar fältet tomt
    if ([string]::IsNullOrWhiteSpace($mappNamn)) {
        throw "Du måste ange ett giltigt mappnamn."
    }

    # Kontrollerar att mappnamnet börjar med en bokstav
    if ($mappNamn -notmatch "^[a-zA-Z]") {
        throw "Mappnamnet måste börja med en bokstav."
    }

    # Kontrollerar om mappnamnet innehåller å, ä eller ö
    if ($mappNamn -match "[åäöÅÄÖ]") {
        throw "Mappnamnet får inte innehålla Å, Ä eller Ö."
    }

    # Basvägen blir samma mapp som skriptet ligger i
    $mappPath = $PSScriptRoot

    # Skapar fullständig sökväg till huvudmappen
    $fullPath = Join-Path -Path $mappPath -ChildPath $mappNamn

    # Kontrollerar om huvudmappen redan finns
    if (Test-Path -Path $fullPath) {
        throw "Mappen '$mappNamn' finns redan."
    }

    # Skapar huvudmappen
    New-Item -Path $fullPath -ItemType Directory | Out-Null

    # Skapar en array med undermappar
    $undermappar = @("logs", "scripts", "temp")

    # Skapar undermapparna med en foreach-loop
    foreach ($mapp in $undermappar) {
        $undermappPath = Join-Path -Path $fullPath -ChildPath $mapp
        New-Item -Path $undermappPath -ItemType Directory | Out-Null
    }

    # Hämtar dagens datum till loggfilens namn
    $datum = Get-Date -Format "yyyy-MM-dd"

    # Hämtar datum och tid till loggtexten
    $datumTid = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Skapar sökväg till loggfilen
    $loggMapp = Join-Path -Path $fullPath -ChildPath "logs"
    $loggFil = Join-Path -Path $loggMapp -ChildPath "log-$datum.txt"

    # Text som ska skrivas till loggfilen
    $loggText = "Struktur skapad: $datumTid"

    # Anropar funktionen som skriver till loggfilen
    Skriv-Logg -LoggFil $loggFil -LoggText $loggText

    # Skriver ut information till användaren
    Write-Host "Mappen och strukturen skapades utan problem!"
    Write-Host "Huvudmapp: $fullPath"
    Write-Host "Undermappar: logs, scripts och temp"
    Write-Host "Loggfil: $loggFil"
}
catch {
    Write-Host "Ett fel uppstod:"
    Write-Host $_.Exception.Message
}