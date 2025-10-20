# Abschlussarbeit – LaTeX-Template mit Docker

Dieses Template wird vollständig in Docker kompiliert.
**Kein Overleaf, keine lokale TeX-Installation nötig.**

---

## 📦 Voraussetzungen

* Installiertes **Docker Desktop** (Windows/macOS) oder **Docker Engine** (Linux)
* Dieses Projektverzeichnis (z. B. via ZIP oder Git)

---

## 🧱 1. Image einmalig bauen

Öffnen Sie eine Konsole (PowerShell oder Terminal) und **wechseln Sie in das Projektverzeichnis**, also dorthin, wo sich die Datei `Dockerfile` befindet.
Im Wurzelverzeichnis des Projekts:

```bash
docker build -t thesis-latex .
```

Der erste Build dauert 10–20 Minuten, da TeX Live installiert wird.
Danach läuft alles lokal und offline.

---

## 🚀 2. Projekt kompilieren

Wichtig:
Der folgende Befehl funktioniert nur, wenn Sie sich im Projektverzeichnis befinden,
also dort, wo Ihre `main.tex` liegt. Nur dann zeigt `"$PWD"` auf das richtige Verzeichnis.
Alternativ können Sie auch einen absoluten Pfad angeben.

### Fast-Build (schnell, ohne Bibliographie/Glossar)

**Linux / macOS:**

```bash
docker run --rm -v "$PWD":/work -w /work thesis-latex fast
```

**Windows PowerShell:**

```bash
docker run --rm -v "${PWD}:/work" -w /work thesis-latex fast
```

Ergebnis: `main.pdf`

### Finaler Build (mit Bibliographie & Glossar)

```bash
docker run --rm -v "$PWD":/work -w /work thesis-latex
```

### Aufräumen

```bash
docker run --rm -v "$PWD":/work -w /work thesis-latex clean
```

---

## 🧩 3. Optional: Compose-Nutzung (noch einfacher)

Erstellen Sie eine `compose.yaml`:

```yaml
services:
  latex:
    build: .
    working_dir: /work
    volumes:
      - ./:/work
    user: "${UID:-1000}:${GID:-1000}"
    entrypoint: ["make"]
```

Dann:

```bash
docker compose run --rm latex fast
docker compose run --rm latex
docker compose run --rm latex clean
```

---

## 💡 Hinweise

Der Fast-Build aktiviert automatisch:

* Bilder & Hyperlinks im *draft*-Modus
* keine Bibliographie (biber)
* kein Glossar

Für die finale Abgabe führen Sie einfach den normalen Build (`make pdf` oder `docker run ... thesis-latex`) aus.
Das PDF erscheint im selben Ordner wie Ihre `.tex`-Dateien.

---
## 🧭 Vorgehen in PyCharm

1. Menü öffnen:
`Run` → `Edit Configurations…`

2. Neue Konfiguration anlegen:
Klicken Sie auf das „+“-Symbol → wählen Sie `Shell Script` (unter Templates → Other).

3. Eintrag ausfüllen:
`Name`: z. B. Compile

4. Script text:
`docker run --rm -v "${PWD}:/work" -w /work thesis-latex`\
(oder mit fast / clean, je nach gewünschtem Build-Modus)

5. Working directory:
Projektverzeichnis, also dort, wo `main.tex` liegt.

6. Execute in the terminal:
Deaktivieren!
Dadurch wird der Befehl direkt über die Run Configuration ausgeführt und kann auch als Run Command bzw. Shortcut genutzt werden.

7. Bestätigen:
Apply → OK

▶️ Nutzung
Jetzt genügt ein Klick auf Run → Compile (oder Shift + F10), um den Docker-Container zu starten.
Die Ausgabe erscheint im PyCharm-Run-Fenster, und nach erfolgreichem Lauf liegt die main.pdf im Projektordner.

💡 Hinweis
Über Run Configurations → Duplicate können Sie Varianten für `fast`, `final` und `clean` anlegen.\
PyCharm merkt sich Arbeitsverzeichnis und Umgebungsvariablen, daher muss der Pfad nicht jedes Mal neu angegeben werden.

---

## 🧰 Fehlerbehebung

| Problem                           | Lösung                                             |
| :-------------------------------- | :------------------------------------------------- |
| `docker: command not found`       | Docker nicht installiert oder nicht im PATH        |
| `LaTeX Error: File ... not found` | Falscher Pfad in `\input` oder `\includegraphics`  |
| Sehr langer erster Build          | normal – Image wird initial gebaut                 |
| `main.pdf` fehlt                  | Logs prüfen mit `docker run ... thesis-latex fast` |
