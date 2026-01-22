from typing import Optional
from aiogram import Router, types, F
from aiogram.filters import Command, StateFilter
from aiogram.fsm.context import FSMContext
from sqlalchemy import select, delete
from sqlalchemy.exc import IntegrityError

from src.database import AsyncSessionLocal
from src.models import User
from src.states import FilterStates

router = Router()


async def send_welcome_overview(message: types.Message, user: Optional[User] = None):
    link = "🌐 <a href='https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx'>Restplatzbörse öffnen</a>"
    if not user:
        await message.answer(
            "👋 <b>Hi, ich bin der LastminuteBayernBot!</b>\n\n"
            "Du bist jetzt eingetragen und erhältst Nachrichten zu jedem neuen freien Platz.\n"
            "Die Abfrage nach neuen Plätzen findet alle 10 Minuten statt.\n\n"
            f"{link}\n\n"
            "Sollte nur ein Teil für dich relevant sein, kannst du Filter hinzufügen:\n"
            "🔹 /filters zeigt deine aktuellen Filter an\n"
            "🔹 /addfilter um Filter hinzuzufügen\n"
            "🔹 /removefilter um Filter zu entfernen\n"
            "🔹 /purgefilters um alle Filter zu löschen\n"
            "🔹 /listcourses zeigt alle bekannten Lehrgangsnamen\n"
            "🔹 /stop um dich abzumelden",
            parse_mode="HTML",
            disable_web_page_preview=True,
        )
    else:
        # Check if user.filters is a list (SQLAlchemy JSON might return it as such)
        filters = user.filters if user.filters else []
        filter_count = len(filters)
        await message.answer(
            f"👋 Du bist angemeldet.\n"
            f"Du hast {filter_count} Filter aktiviert.\n\n"
            f"{link}\n\n"
            "🔹 /filters zeigt deine aktuellen Filter an\n"
            "🔹 /addfilter um Filter hinzuzufügen\n"
            "🔹 /removefilter um Filter zu entfernen\n"
            "🔹 /purgefilters um alle Filter zu löschen\n"
            "🔹 /listcourses zeigt alle bekannten Lehrgangsnamen\n"
            "🔹 /stop um dich abzumelden",
            parse_mode="HTML",
            disable_web_page_preview=True,
        )


@router.message(Command("start"))
async def cmd_start(message: types.Message, state: FSMContext):
    await state.clear()
    if not message.from_user:
        return
    user_id = message.from_user.id

    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User).where(User.user_id == user_id))
        user = result.scalars().first()

        if not user:
            new_user = User(user_id=user_id, filters=[])
            session.add(new_user)
            await session.commit()
            # Re-fetch or just pass None to show the welcome for new users
            await send_welcome_overview(message, None)
        else:
            await send_welcome_overview(message, user)


@router.message(Command("stop"))
async def cmd_stop(message: types.Message, state: FSMContext):
    await state.set_state(FilterStates.waiting_for_stop_confirmation)
    await message.answer(
        "⚠️ <b>Abmeldung</b>\n\n"
        "Möchtest du dich ganz abmelden? Bis zu einer Neuanmeldung wirst du keine Nachrichten mehr erhalten.\n\n"
        "🔹 Schreibe <b>j</b> zum Bestätigen\n"
        "🔹 Schreibe <b>x</b> zum Abbrechen",
        parse_mode="HTML",
    )


@router.message(FilterStates.waiting_for_stop_confirmation)
async def process_stop_confirmation(message: types.Message, state: FSMContext):
    text = message.text.lower().strip() if message.text else ""

    if text == "j":
        user_id = message.from_user.id
        async with AsyncSessionLocal() as session:
            await session.execute(delete(User).where(User.user_id == user_id))
            await session.commit()

        await message.answer(
            "✅ <b>Du wurdest abgemeldet.</b>\n\n"
            "Solltest du dich umentscheiden und wieder Nachrichten bekommen wollen: /start",
            parse_mode="HTML",
        )
        await state.clear()
    elif text == "x":
        await message.answer(
            "❌ Eingabe abgebrochen. Zurück zur Übersicht: /start", parse_mode="HTML"
        )
        await state.clear()
    else:
        # Invalid input for this state, don't clear state, just prompt again
        await message.answer(
            "⚠️ Bitte antworte mit <b>j</b> zum Abmelden oder <b>x</b> zum Abbrechen.",
            parse_mode="HTML",
        )


@router.message(StateFilter(None))
async def cmd_unknown(message: types.Message):
    user_id = message.from_user.id
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User).where(User.user_id == user_id))
        user = result.scalars().first()

        if not user:
            await message.answer(
                "👋 <b>Hi, ich bin der LastminuteBayernBot!</b>\n\n"
                "Wenn du Benachrichtigungen für freie Plätze auf der Feuerwehr-Restplatzbörse erhalten möchtest: /start",
                parse_mode="HTML",
            )
        else:
            await send_welcome_overview(message, user)
