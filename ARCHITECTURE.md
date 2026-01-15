# Architecture

## Overview
A Telegram bot that monitors the "Restplatzbörse" (last minute exchange) of the Bavarian Fire Department schools. It fetches data every 10 minutes, stores it in a MariaDB database, and notifies subscribers about new training opportunities based on their filters.

## Deployment
- **Stack**: Python 3.11, Docker, Docker Compose, MariaDB.
- **Containerization**: 
  - `bot`: Python application running the Telegram bot and the scraping scheduler.
  - `db`: MariaDB instance.
- **Networking**: Containers communicate via a dedicated Docker network (`bot_net`).

## Core Components

### 1. Telegram Bot
- **Library**: `aiogram` (Asyncio).
- **Features**: User management, filter configuration, notifications.
- **Language**: German.

### 2. Data Persistence
- **Database**: MariaDB.
- **ORM**: SQLAlchemy (Async).

### 3. Fetching & Scheduling
- **Library**: `APScheduler` (AsyncIOScheduler).
- **Interval**: Every 10 minutes.
- **Source**: `https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx`
- **Parsing**: `BeautifulSoup4` (HTML parsing of ASP.NET `table.list`).
- **Logic**:
  - Fetches page content.
  - Parses events (ID, Title, Dates, Seats, Location).
  - Compares with the database `events` table.
  - **Notification Trigger**: Only triggered when a **new ID** is discovered.
    - If a program ID matches an existing one in the DB, no notification is sent (even if seats change).
    - If a program ID is new (or reappears after being deleted), notifications are triggered.
  - **Error Handling**:
    - *Network Error*: Log to stdout, silent retry.
    - *Structure Change* (Parsing failure): Log error, DM all users marked as `is_admin`.

### 4. Filtering Logic
- **Normalization**: Input and Titles are converted to lowercase and stripped of whitespace.
- **Matching Algorithm**: **Levenshtein Distance ≤ 1** (Fuzzy matching allowing 1 typo/edit).
- **Behavior**:
  - Empty filter list: User receives ALL notifications.
  - Populated filter list: User receives notification if *any* filter keyword matches the event title.

## Commands

### /start
- Registers the user in the database.
- Welcome message explanation.

### /stop
- Removes the user from the database.
- Stops all notifications.

### /filters
- Lists currently active filters.

### /addfilter
- Dialogue to add new keywords.
- Does **not** list all known courses (to avoid spam).
- Supports multiple inputs separated by `;`.

### /removefilter
- Dialogue to remove existing filters.

### /purgefilters
- Removes all filters (user reverts to receiving ALL notifications).
- Requires confirmation.

### /listcourses
- Lists all known course titles stored in the database.
- Useful for users to see valid filter terms.

## Database Schema

### `users` Table
| Column | Type | Description |
|--------|------|-------------|
| `user_id` | BigInteger (PK) | Telegram User ID |
| `filters` | JSON | List of filter strings (e.g. `["gerätewart", "atemschutz"]`) |
| `is_admin` | Boolean | Flag for receiving system alerts (default: False) |
| `created_at` | DateTime | Timestamp of subscription |

### `courses` Table
| Column | Type | Description |
|--------|------|-------------|
| `title` | String (PK) | Unique, normalized course titles for suggestions |

### `events` Table
| Column | Type | Description |
|--------|------|-------------|
| `id` | Integer (PK) | The `data-id` from the source HTML (e.g. `8281`) |
| `title` | String | Course title |
| `begin_ts` | DateTime | Start timestamp |
| `end_ts` | DateTime | End timestamp |
| `location` | String | Location code (e.g. `SFS-R`) |
| `seats` | Integer | Number of free seats |
| `last_seen` | DateTime | Timestamp of last successful fetch |
