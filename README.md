# Inlämning 1 – Strukturverktyg i PowerShell

## Beskrivning

Detta PowerShell skript frågar användaren efter ett mappnamn och skapar sedan en mapp med det namnet.

Inuti huvudmappen skapas tre undermappar: `logs`, `scripts` och `temp`


I mappen `logs` skapas även en loggfil med dagens datum i filnamnet.

Loggfilen innehåller en rad som visar när strukturen skapades.

## Hur man kör skriptet

1. Kör skriptet i PowerShell.
2. Gå till mappen där skriptet ligger.
3. Kör skriptet med kommandot:

```powershell
.\strukturverktyg.ps1
```

4. Skriv in ett mappnamn när programmet frågar efter det.

Exempel:

```powershell
Ange mappnamn: test
```

Då skapas mappstrukturen jag nämnde ovan med `logs`, `scripts` och `temp` i den nyskapade mappen.

## Felhantering

Skriptet använder `try/catch` för att hantera fel. Det kontrollerar bland annat:

- att mappnamnet inte är tomt
- att mappnamnet börjar med en bokstav
- att mappnamnet inte innehåller å, ä eller ö
- att mappen inte redan finns

Om något blir fel visas ett tydligt felmeddelandet

## Reflektion

Jag tyckte det var kul att äntligen komma igång med lite scripting. Det är kul att se alla möjligheter man kan skapa med scripting i Powershell. 

Det som var lite svårare var att få felhanteringen tydlig och att tänka på vilka fel som kan uppstå, till exempel om användaren lämnar mappnamnet tomt eller om mappen redan finns.
