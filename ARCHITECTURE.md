# Architecture

Deployment via Docker-Compose.

Telegram bot.

Database for keeping records (which one? valkey? mariadb?)

fetches https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx every 10 minutes, notifying users for new seats on trainings they subscribed to

stores all known identifiers of training programs in db table, so users can quickly see how things are named

## Commands

After every command (except stop), the overview of commands is shown, allowing for fluent usage.

Should the user never have typed /start (i.e. there is no entry for them in the db), always send the welcome message

### /start

Marks the user as interested in notifications, saving a respective entry for the user in the db.
By default, a notification for every new seat is sent.

### /filters

Shows the filters the current user has applied

### /add-filter

User can type in a filter keyword.
When filter was previously empty (i.e. everything is shown), then now only seats for trainings that include the filter keyword are shown
When other filters are already applied, add the new keyword to the list, also showing notifications for those.

logic (kotlin-style): `filters.size == 0 || filters.any{ it == title }`

### /remove-filter

Removes a keyword from the filter.

### /purge-filters

Resets the filters, showing every new seat again.

### /stop

Marks the user as unsubscribed, deleting their entry from the database.
Sends a message confirming the canceling. Shows /start should the user re-subscribe

## Database Tables

### User

- username (key)
- filter-keywords

### Courses

- title (key)

### Events

- ID (key)
- title
- begin timestamp
- end timestamp
- location
- free seats

(we only really need the changes from the previous scrape to the current, can be kept in memory as well)
