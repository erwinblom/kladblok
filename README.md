# FMT Kladblok

**Een klein kladblok voor Mac, Windows en Linux.** Schrijf of plak een idee, kopieer je tekst of download hem als tekst- of Markdown-bestand. Je klad wordt automatisch in je browser bewaard. Werkt offline, zonder account, abonnement of AI-sleutel.

Ik maakte dit met AI omdat ik het zelf nodig had. Ik ben geen programmeur en geen designer. Ik deel de software om je op gang te helpen: probeer haar, bouw erop voort en maak haar passend bij jouw werk.

![FMT Kladblok met een voorbeeldnotitie](docs/kladblok.png)

## Beginnen

1. Kies **Code → Download ZIP** bovenaan deze GitHub-pagina.
2. Pak de hele ZIP uit in een vaste map op je computer.
3. Open **index.html** in Chrome of Edge. Je ziet het kladblok en kunt meteen schrijven. Er is geen installatie of lokale server nodig.
4. Bewaar een bladwijzer naar dit bestand om het terug te vinden.

Deze browseruitgave is dezelfde op Mac, Windows en Linux. Gebruik steeds dezelfde browser, hetzelfde profiel en dezelfde uitgepakte map. Verplaatsen of een andere browser gebruiken kan een andere opslagplek opleveren. De browseruitgave heeft geen icoon in de systeemmenubalk.

## Je eerste klad

Vul een titel en wat tekst in. Wijzigingen worden automatisch lokaal in deze browser bewaard. Sluit de browser helemaal en open hetzelfde bestand weer: je klad komt terug.

Kies **Tekst (.txt)** of **Markdown (.md)** en klik **Download bestand**. De browser bewaart `Klad.txt` of `Klad.md` in je downloadmap, of vraagt waar je het wilt bewaren. Open het bestand om je uitvoer te controleren. Markdown zet `# ` voor de titel; je tekst blijft ongewijzigd. Beide bestanden zijn UTF-8.

**Kopieer alles** kopieert titel en tekst. Blokkeert je browser het klembord, selecteer en kopieer je tekst met Ctrl+C (Windows/Linux) of ⌘C (Mac). **Wis** vraagt bevestiging; **Herstel gewist klad** haalt de laatste gewiste titel en tekst tijdens dezelfde sessie terug.

## Waar blijft mijn tekst?

Alleen in de lokale browseropslag van dit bestand. Er is geen synchronisatie of verzending. Download belangrijke teksten ook als los bestand: privémodus, browsergegevens wissen of een browserprobleem kan je klad verwijderen. Een gedownload bestand blijft zelfstandig bruikbaar.

De eerdere native Mac-versie blijft beschikbaar in `Sources/`. Die bewaart haar eigen klad in `~/Library/Application Support/FMT Kladblok Open Source/kladblok.json`. Er is geen automatische migratie: kopieer je tekst uit die app naar deze browseruitgave. De persoonlijke Werkplaats-koppelingen zijn geen onderdeel van deze openbare tool.

## Zo pas je Kladblok aan

Je hoeft niet te kunnen programmeren om een kleine wijziging te proberen:

1. Maak een kopie van de hele uitgepakte map. Houd je werkende versie apart.
2. Open de kopie in een lokale AI-werkomgeving, bijvoorbeeld Codex. Of geef een nieuwe ChatGPT- of Claude-chat de bestanden `index.html` en deze README.
3. Vraag één concrete verandering, bijvoorbeeld een grotere letter, een donkere achtergrond of een extra knop.
4. Neem de gewijzigde bestanden terug, open `index.html` en test schrijven, downloaden en opnieuw openen.

**Kopieer deze opdracht naar je AI:**

> Dit is FMT Kladblok. Ik ben geen programmeur. Lees de bestanden en handleiding. Ik gebruik [Mac/Windows/Linux]. Verander alleen de rode knoppen naar blauw. Werk in een kopie en behoud schrijven, automatisch bewaren, kopiëren en tekst/Markdown-export. Geef het complete aangepaste bestand terug als je mijn lokale map niet kunt bewerken. Help me het te openen en testen. Publiceer of verstuur niets. Vertel wat je werkelijk hebt gecontroleerd.

Een gewone chat kan je computer niet vanzelf aanpassen. Werkt een download niet, vraag: “Noem de bestandsnaam, de exacte tekst die ik moet zoeken en de vervanging.” Geef bij problemen de volledige foutmelding door, zonder je privénotities of geheimen. `index.html` bevat interface en werking; de kleur staat bovenaan bij `--accent`.

## Oude native Mac-app bouwen

De browserversie hierboven vraagt geen bouwtools. Voor de bestaande Mac-menubalkapp: installeer Apple Command Line Tools (`xcode-select --install`), open Terminal in deze map en voer `zsh bouw.sh` uit. Open daarna `FMT Kladblok.app`. Deze bronroute is alleen voor macOS en tekent lokaal ad hoc; het is geen genotariseerde download. De iconenfamilie staat in `Resources/` en blijft meegeleverd.

## Controle en vrijheid

De geautomatiseerde [platformcontrole](https://github.com/erwinblom/kladblok/actions/workflows/platforms.yml) test tekst- en Markdown-export op exacte bytes, volledig sluiten/heropenen van Chromium, annuleren van wissen en herstel. De workflow draait op Ubuntu 24.04, Windows Server 2022 en macOS 14. Een groene run bewijst deze routes op die systemen; geen fysieke beginnersproef of alle browsers. Raadpleeg de run bij de betreffende versie voor de daadwerkelijke uitslag.

Voor ontwikkelaars: Node.js 22, `npm ci`, `npx playwright install chromium`, `npm test`. Dit is alleen voor controles; dagelijks gebruik vraagt geen Node.js.

Code en documentatie: [MIT](LICENSE). FMT-naam en iconen: [merkvoorwaarden](MERKVOORWAARDEN.md). Je hoeft eigen wijzigingen niet terug te geven. Meld reproduceerbare problemen via [Issues](https://github.com/erwinblom/kladblok/issues).
