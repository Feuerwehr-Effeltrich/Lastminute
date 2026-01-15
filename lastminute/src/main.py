import asyncio
import logging
from aiogram import Bot, Dispatcher
from apscheduler.schedulers.asyncio import AsyncIOScheduler

from src.config import BOT_TOKEN
from src.database import init_db
from src.handlers import general, filters
from src.scheduler import process_lastminute_check

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


async def main():
    logger.info("Starting bot...")

    # Initialize DB
    await init_db()
    logger.info("Database initialized.")

    # Initialize Bot and Dispatcher
    bot = Bot(token=BOT_TOKEN)
    dp = Dispatcher()

    # Register routers
    dp.include_router(general.router)
    dp.include_router(filters.router)

    # Initialize Scheduler
    scheduler = AsyncIOScheduler()
    # Add job to run every 10 minutes, and also immediately on startup
    scheduler.add_job(process_lastminute_check, "interval", minutes=10, args=[bot])

    # Run once immediately
    asyncio.create_task(process_lastminute_check(bot))

    scheduler.start()
    logger.info("Scheduler started.")

    # Start polling
    await bot.delete_webhook(drop_pending_updates=True)
    await dp.start_polling(bot)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except (KeyboardInterrupt, SystemExit):
        logger.info("Bot stopped.")
