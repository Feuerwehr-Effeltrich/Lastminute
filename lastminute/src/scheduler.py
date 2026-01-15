import logging
import asyncio
from datetime import datetime
from sqlalchemy import select, delete
from sqlalchemy.dialects.mysql import insert as mysql_insert
from aiogram import Bot

from src.scraper import fetch_events
from src.database import AsyncSessionLocal
from src.models import Event, User, Course
from src.utils import is_match

logger = logging.getLogger(__name__)


async def notify_admins(bot: Bot, message: str):
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User).where(User.is_admin == True))
        admins = result.scalars().all()
        for admin in admins:
            try:
                await bot.send_message(admin.user_id, message)
            except Exception as e:
                logger.error(f"Failed to DM admin {admin.user_id}: {e}")


async def process_lastminute_check(bot: Bot):
    logger.info("Starting lastminute check...")

    # Run synchronous scraper in executor
    loop = asyncio.get_running_loop()
    try:
        current_events = await loop.run_in_executor(None, fetch_events)
    except ValueError as e:
        logger.error(f"Scraper failed: {e}")
        await notify_admins(
            bot,
            f"⚠️ ACHTUNG: Parsing-Fehler! Die Struktur der Webseite hat sich vermutlich geändert.\nFehler: {e}",
        )
        return
    except Exception as e:
        logger.error(f"Scraper network/unknown error: {e}")
        return

    if not current_events:
        logger.info("No events found or network error (empty list).")
        return

    async with AsyncSessionLocal() as session:
        # 1. Update Courses (Titles)
        # We want to store all unique titles seen
        unique_titles = {e.title for e in current_events if e.title}
        for title in unique_titles:
            # Simple ignore duplicate insert
            stmt = mysql_insert(Course).values(title=title)
            stmt = stmt.on_duplicate_key_update(title=title)  # No-op
            await session.execute(stmt)

        # 2. Identify New Events
        # Get all currently stored event IDs
        result = await session.execute(select(Event.id))
        stored_ids = set(result.scalars().all())

        fetched_ids = set(e.id for e in current_events)

        # New IDs are those in fetched but not in stored
        new_event_ids = fetched_ids - stored_ids

        new_events = [e for e in current_events if e.id in new_event_ids]

        if new_events:
            logger.info(f"Found {len(new_events)} new events.")

            # Fetch all users
            result = await session.execute(select(User))
            users = result.scalars().all()

            for event in new_events:
                msg = (
                    f"🔔 <b>Neuer Platz frei!</b>\n\n"
                    f"<b>{event.title}</b>\n"
                    f"📍 {event.location}\n"
                    f"📅 {event.begin_ts.strftime('%d.%m.%Y %H:%M')} - {event.end_ts.strftime('%d.%m.%Y %H:%M')}\n"
                    f"💺 Freie Plätze: {event.seats}"
                )

                for user in users:
                    send = False
                    if not user.filters:
                        send = True
                    else:
                        # Check if ANY filter matches
                        # filters is a JSON list of strings
                        for f in user.filters:
                            if is_match(f, event.title):
                                send = True
                                break

                    if send:
                        try:
                            await bot.send_message(user.user_id, msg, parse_mode="HTML")
                        except Exception as e:
                            # User might have blocked bot
                            logger.warning(
                                f"Failed to send to user {user.user_id}: {e}"
                            )
                            # Optionally delete user if blocked

        # 3. Update Events Table
        # "Delete old entries, then store the current state"
        # We replace the entire table content with the current fetch
        # This ensures 'stored_ids' in the next run correctly reflects this state

        # Delete all
        await session.execute(delete(Event))

        # Insert all current
        session.add_all(current_events)

        await session.commit()
        logger.info("Database updated with current events.")
