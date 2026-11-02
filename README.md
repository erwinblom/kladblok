# FMT Kladblok

Een eenvoudig kladblok in de menubalk van je Mac. Schrijf of plak tekst, kopieer alles of bewaar een tekstbestand. Je klad wordt automatisch lokaal bewaard.

Ik maakte dit met AI omdat ik het zelf nodig had. Ik ben geen programmeur en geen designer. Door dit te delen wil ik laten zien wat mogelijk is en je op gang helpen. Bouw erop voort en maak het passend bij jouw werk en smaak.

![Appicoon](Resources/fmt-kladblok.png)

## Beginnen

Je hebt een Mac en Apple Command Line Tools nodig. Geen account, internetdienst, abonnement of API-sleutel voor gebruik. De bron gebruikt uitsluitend Apple-frameworks. Bouwen is getest op Apple Silicon; Intel, oudere macOS-versies en een tweede Mac zijn niet getest.

1. Kies op GitHub **Code → Download ZIP** en pak uit.
2. Open Terminal. Controleer `xcode-select -p`. Ontbreken de bouwtools, voer `xcode-select --install` uit en voltooi de Apple-installatie.
3. Typ `cd `, sleep de uitgepakte map met `bouw.sh` naar Terminal en druk Enter.
4. Voer `zsh bouw.sh` uit. Start daarna met `open "FMT Kladblok.app"`.
5. Schrijf een titel en een paar regels. Klik **Bewaar als tekst**, kies een plek en open het bestand in Teksteditor. Stop Kladblok en open opnieuw: je klad blijft behouden.

Klik op het pensymbool in de menubalk om het venster terug te halen. **Esc**, **⌘H** en **Verberg** verbergen alleen het venster. **Kopieer alles** zet titel en tekst op het klembord. **Wis** vraagt eerst bevestiging. Sluit eerdere kopieën voordat je een nieuwe versie start.

## Gegevens en eigen versie

Titel en tekst staan lokaal in `~/Library/Application Support/FMT Kladblok Open Source/kladblok.json`. Je klad gaat nergens automatisch naartoe; tekstexport komt op de plek die je zelf kiest. Kopiëren gebruikt het gedeelde macOS-klembord. Voor een leeg begin: stop de app en verwijder uitsluitend die opslagmap, na eventuele export.

Deze zelfstandige uitgave gebruikt een eigen app-identiteit en opslagmap. Erwins persoonlijke versie heeft koppelingen met zijn Werkplaats. Die zijn hier vervangen door **Bewaar als tekst**; deze uitgave heeft geen online bewaarknop. Je kunt tekst met kopiëren en plakken in je eigen Werkplaats gebruiken. Exports bevatten alleen je eigen titel en tekst.

Het vaste icoon staat als SVG, PNG en ICNS in Resources. `bouw.sh` neemt het mee. Hertekenen kan optioneel met Python 3 en Pillow: `python3 Resources/maak-icoon.py` en `python3 Resources/maak-icns.py`; dit is niet nodig om de app te bouwen.

## Aanpassen met AI

Maak een kopie van het volledige bronpakket. Open een nieuwe ChatGPT-, Claude- of Codex-chat, geef alle bronbestanden en deze handleiding en vraag één kleine aanpassing. Een gewone chat kan lokale bestanden niet vanzelf wijzigen; vraag het complete aangepaste project terug of gebruik een lokale AI-werkomgeving. Bouw je kopie opnieuw en test schrijven, export en heropenen.

> Dit is het volledige bronpakket van een Mac-app die ik naar mijn eigen smaak wil aanpassen. Lees eerst de bestanden en handleiding. Mijn eerste wens: verander alleen de rode bedieningskleur naar blauw. Werk in een aparte projectkopie als je lokale bestanden kunt bewerken; lever anders het complete gewijzigde project als download en noem welke bestanden veranderden. Help me bouwen en starten op mijn Mac. Behoud bestaande functies, licenties en mijn gegevens. Publiceer of verstuur niets. Vertel wat werkelijk getest is en wat ik zelf moet controleren.

Werkt de download niet, vraag voor een kleine wijziging de exacte zoektekst, vervanging en bestandsnaam. Geef bij bouwproblemen de volledige foutmelding aan de AI, zonder persoonlijke notities of geheimen. Bugs kunnen via de Issues van deze repository gemeld worden. Er is geen belofte van doorlopende ondersteuning en je hoeft eigen wijzigingen niet terug te geven.

## Licenties en beperkingen

Code en technische documentatie: [MIT](LICENSE). FMT-naam, logo en afgeleide iconen: [aparte merkvoorwaarden](MERKVOORWAARDEN.md). Voor verspreide gewijzigde versies gebruik je een eigen merk; instellingen voor eigen gebruik verplichten je niet tot hernoemen.

Dit is broncode die je zelf bouwt, geen Developer ID-ondertekende of genotariseerde download. De build tekent lokaal ad hoc. Andere Macs en installatie door een beginner zijn nog niet getest. Bewaar belangrijke teksten ook als los bestand.
