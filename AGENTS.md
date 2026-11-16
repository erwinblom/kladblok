# Kladblok aanpassen: instructies voor de AI

Je helpt iemand die dit kladblok naar eigen smaak wil maken. Ga ervan uit dat die persoon geen programmeur is. Dit bestand vertelt wat je vrij mag veranderen en wat heel moet blijven.

## Hoe je werkt

- Werk in een kopie van de map. Het origineel blijft onaangeroerd.
- Maak één wijziging per keer, zo klein als kan.
- Leg in gewone taal uit wat je hebt veranderd en hoe de gebruiker dat zelf controleert.
- Zeg eerlijk wat je werkelijk hebt getest en wat niet.
- Publiceer, verstuur of upload niets. Voeg geen externe scripts, fonts, tracking of accounts toe, tenzij de gebruiker daar zelf om vraagt.
- Kun je de bestanden niet zelf bewerken? Lever dan het complete aangepaste `index.html` terug.

## Waar alles staat

De hele app zit in één bestand: `index.html`. Er staan twee blokken met instellingen in, allebei met de kop INSTELLINGEN. Begin daar.

| Wat | Waar in `index.html` |
|---|---|
| Kleuren, lettertype, lettergrootte, breedte | het blok `:root { ... }` bovenaan de stijl |
| Naam, ondertitel, logo, welkomstzin, bestandsnaam van de download | `const INSTELLINGEN = { ... }` aan het begin van het script |
| Teksten op knoppen | de knoppen in `<nav>` |
| Meldingen onder de knoppen | de `melding(...)`-regels in het script |
| Wat er in de download en op het klembord komt | de functie `uitvoer()` |
| Automatisch bewaren | de functie `bewaar()` en `OPSLAGSLEUTEL` |

`Sources/`, `bouw.sh` en `Resources/maak-*.py` horen bij een oudere Mac-app. Laat die met rust, tenzij de gebruiker er uitdrukkelijk om vraagt.

## Vrij te veranderen

Kleuren, lettertype, lettergrootte, indeling, naam, logo, alle teksten, de taal, extra knoppen, extra exportformaten en nieuwe functies. Dit is een vertrekpunt: de vormgeving van de maker is geen voorschrift.

## Wat heel moet blijven

1. **Automatisch bewaren.** Elke toetsaanslag wordt bewaard in de browser. Na sluiten en heropenen staat de tekst er weer.
2. **De waarde van `OPSLAGSLEUTEL` (`fmt-kladblok-browser-v1`).** Verander je die, dan lijkt het bestaande klad van de gebruiker verdwenen. Moet het toch, lees dan eerst de oude sleutel uit en neem de tekst mee.
3. **Niets gaat stil verloren.** Wissen vraagt bevestiging en is te herstellen. Bij een fout blijft de tekst in beeld staan.
4. **De download bevat precies wat de gebruiker schreef.** Geen toegevoegde regels, geen verplichte naamsvermelding.
5. **Alles blijft lokaal.** Geen verbinding met internet zonder uitdrukkelijke vraag van de gebruiker.
6. **`LICENSE` blijft in de map**, met de naam van de oorspronkelijke maker.

## Controleren na elke wijziging

Laat de gebruiker dit zelf doen in Chrome of Edge:

1. Open `index.html`, typ een titel en een paar regels.
2. Sluit de browser helemaal en open het bestand opnieuw. Staat de tekst er nog?
3. Download als tekst en als Markdown. Open beide bestanden.
4. Klik **Kopieer alles** en plak ergens anders.
5. Klik **Wis**, bevestig, en klik **Herstel gewist klad**.

Wie Node.js heeft, kan ook `npm ci`, `npx playwright install chromium` en `npm test` draaien. Die test controleert de download op de exacte inhoud. Verander je bewust wat er in de download komt, pas dan ook `tests/browser.cjs` aan en zeg dat erbij.

## Een eigen versie delen

Voor eigen gebruik hoeft de gebruiker niets te hernoemen. Wil hij zijn versie verspreiden, dan gelden de afspraken in `docs/MERKVOORWAARDEN.md`: eigen naam, eigen logo en eigen icoon, en geen FMT of fastmovingtargets.nl meer in beeld. Vervang dan `naam`, `ondertitel` en `logo` in `INSTELLINGEN`, de vaste tekst in `<title>` en `<header>`, en het icoon in `<link rel="icon">`. "Gebaseerd op FMT Kladblok" vermelden mag.
