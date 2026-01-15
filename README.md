# LastminuteBayernBot

Ein Telegram-Bot, der die [Feuerwehr-Restplatzbörse Bayern](https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx) überwacht und Benutzer über neue freie Lehrgangsplätze informiert.

## Funktionen

- 🔄 **Automatische Überwachung**: Prüft alle 10 Minuten auf neue Plätze.
- 🔔 **Benachrichtigungen**: Sendet eine Nachricht, sobald ein *neuer* Kursplatz verfügbar wird.
- 🔍 **Filter**: Benutzer können nach Lehrgangsnamen filtern (z.B. "Gerätewart").
- 🧠 **Intelligente Suche**: Unterstützt Tippfehler und Teilübereinstimmungen (Fuzzy Matching).
- 🐳 **Dockerisiert**: Einfache Installation mit Docker Compose.

## Installation & Start

### Voraussetzungen
- Docker & Docker Compose
- Ein Telegram-Bot-Token (via @BotFather)

### Setup

1. Repository klonen.
2. `.env` Datei erstellen:
   ```bash
   TOKEN=dein_telegram_bot_token
   MYSQL_ROOT_PASSWORD=geheimes_passwort
   MYSQL_DATABASE=lastminute
   MYSQL_USER=user
   MYSQL_PASSWORD=password
   ```
3. Bot starten:
   ```bash
   docker compose up -d --build
   ```

Der Bot läuft nun und überwacht die Webseite.

## Datenbank-Inspektion

Um die Datenbank manuell einzusehen (z.B. Benutzer oder gefundene Kurse), kann folgender Befehl genutzt werden:

```bash
docker exec -it lastminute_db mariadb -u user -p lastminute
```
(Das Passwort ist standardmäßig `password`, sofern in der `.env` nicht anders definiert.)

## Entwicklung & Tests

Das Projekt nutzt `uv` für das Dependency Management.

### Lokale Tests ausführen

1. Abhängigkeiten installieren:
   ```bash
   cd lastminute
   uv sync
   ```
2. Tests starten:
   ```bash
   uv run python -m pytest
   ```

## Projektstruktur

- `lastminute/src/`: Quellcode des Bots.
- `lastminute/tests/`: Unit-Tests für Parsing und Filter-Logik.
- `docker-compose.yml`: Definition der Bot- und Datenbank-Container.
