# Architecture

Deployment via Docker-Compose.

Telegram bot.

Mariadb database for keeping records

fetches https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx every 10 minutes, notifying users for new seats on trainings they subscribed to

stores all known identifiers of training programs in db table, so users can quickly see how things are named

For searching, both the fetched titles and the user's filters are converted to lowercase and stripped of whitespaces.
It is considered a match when the hamming distance is 1 or lower.

## Commands

After every command (except stop), the overview of commands is shown, allowing for fluent usage.

Should the user never have typed /start (i.e. there is no entry for them in the db), always send the welcome message:

> Hi, ich bin der LastminuteBayernBot! Wenn du Benachrichtigungen für freie Plätze auf der Feuerwehr-Restplatzbörse erhalten möchtest: /start

### /start

Marks the user as interested in notifications, saving a respective entry for the user in the db.
By default, a notification for every new seat is sent.

new user:

> Du bist jetzt eingetragen und erhältst Nachrichten zu jedem neuen freien Platz.  
> Die Abfrage nach neuen Plätzen findet alle 10 Minuten statt.  
> Sollte nur ein Teil für dich relevant sein, kannst du Filter hinzufügen:
> - /filters zeigt deine aktuellen Filter an
> - /add-filter um einen oder mehrere Filter hinzuzufügen, zeigt auch alle derzeit bekannten Lehrgangsbezeichnungen
> - /remove-filter um diese wieder zu entfernen
> - /purge-filters um alle Filter zurückzusetzen und wieder alle freien Plätze zu bekommen
>
> Solltest du dich ganz austragen wollen, kannst du das mit /stop tun.

existing user:

> Du erhältst derzeit Nachrichten zu neuen freien Lehrgangsplätzen. Du hast {x} Filter aktiviert.
> - /filters zeigt deine aktuellen Filter an
> - /add-filter um einen oder mehrere Filter hinzuzufügen, zeigt auch alle derzeit bekannten Lehrgangsbezeichnungen
> - /remove-filter um diese wieder zu entfernen
> - /purge-filters um alle Filter zurückzusetzen und wieder alle freien Plätze zu bekommen
>
> Solltest du dich ganz austragen wollen, kannst du das mit /stop tun.

### /filters

Shows the filters the current user has applied.

with no filters:

> Du hast derzeit keine eigenen Filter festgelegt, du bekommst sofort alle freien Plätze mit.

with filters:

> Deine aktuellen Filter:
> - {keyword1}
> - {keyword2}
> - ...

with this added at the bottom for both cases:

> Zurück zur Übersicht: /start

### /add-filter

User can type in a filter keyword, or multiple separated with semicolons.
When filter was previously empty (i.e. everything is shown), then now only seats for trainings that include the filter keyword are shown
When other filters are already applied, add the new keyword to the list, also showing notifications for those.

logic (kotlin-style): `filters.size == 0 || filters.any{ it == title }`

> Aktuell bekannte Lehrgangsbezeichnungen:
> - {title1}
> - {title2}
> - ...
>
> Gebe einen oder mehrere Suchtitel ein, nach denen gefiltert werden soll. Für mehrere Titel, trenne diese mit einem Strichpunkt ;
>
> Groß- und Kleinschreibung ist egal, ebenso werden Leerzeichen bei Filtern ignoriert.
> Um die Eingabe abzubrechen, schreibe x

User can now type in their filter(s). Reply:

> Dein Filter wurde eingetragen. Zurück zur Übersicht: /start

Or if they typed x:

> Eingabe abgebrochen. Zurück zur Übersicht: /start

### /remove-filter

Removes a keyword from the filter.

with no filters:

> Du hast derzeit keine eigenen Filter festgelegt. Zurück zur Übersicht: /start

with filters:

> Deine aktuellen Filter:
> - {keyword1}
> - {keyword2}
> - ...
>
> Gebe einen oder mehrere Filter ein, die wieder entfernt werden sollen. Für mehrere Filter, trenne diese mit einem Strichpunkt ;
>
> Groß- und Kleinschreibung ist egal, ebenso werden Leerzeichen bei Filtern ignoriert.
> Um die Eingabe abzubrechen, schreibe x

User can now type in their filter(s). Reply:

> Die Filter wurden entfernt. Zurück zur Übersicht: /start

If the user types in filters they didn't have previously, delete them on a best-effort basis, disregarding missing ones.

Or if they typed x:

> Eingabe abgebrochen. Zurück zur Übersicht: /start

### /purge-filters

Resets the filters, showing every new seat again.

> Du bist dabei, alle deine Filter zu löschen, ab dann bekommst du wieder Nachrichten für alle freien Plätze.
>
> Willst du das wirklich tun? Wenn ja, schreibe j, ansonsten x zum abbrechen.

After confirmation:

> Deine Filter wurden entfernt. Zurück zur Übersicht: /start

Or if they typed x:

> Eingabe abgebrochen. Zurück zur Übersicht: /start

### /stop

Marks the user as unsubscribed, deleting their entry from the database.
Sends a message confirming the canceling. Shows /start should the user re-subscribe

> Möchtest du dich ganz abmelden? Bis zu einer Neuanmeldung wirst du keine Nachrichten mehr erhalten.
>
> Wenn ja, schreibe j, ansonsten x zum abbrechen.

After confirmation:

> Du wurdest abgemeldet. Solltest du dich umentscheiden und wieder Nachrichten bekommen wollen: /start

Or if they typed x:

> Eingabe abgebrochen. Zurück zur Übersicht: /start

## Database Tables

### User

Once subscribed, the user is stored in here.

- user name/handle/number (key)
- filter-keywords array

### Courses

Stores all known titles of training programs, for giving the user suggestions on what filters they can apply.

- title (key)

### Events

Keep the previous fetched state (so a restart doesn't notify everyone because in-memory state is lost).
On fetch, compare pulled status with ones from this table, sending notifications for new free seats.
Delete old entries, then store the current state for the next fetch.

- ID (key)
- title
- begin timestamp
- end timestamp
- location
- seats
