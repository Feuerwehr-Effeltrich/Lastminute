from aiogram import Router, types
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext
from sqlalchemy import select, delete
from sqlalchemy.exc import IntegrityError

from src.database import AsyncSessionLocal
from src.models import User
from src.states import FilterStates

router = Router()


@router.message(Command("start"))
async def cmd_start(message: types.Message):
    user_id = message.from_user.id

    async with AsyncSessionLocal() as session:
        # Check if user exists
        result = await session.execute(select(User).where(User.user_id == user_id))
        user = result.scalars().first()

        if not user:
            # Create new user
            new_user = User(user_id=user_id, filters=[])
            session.add(new_user)
            await session.commit()

            await message.answer(
                "👋 <b>Hi, ich bin der LastminuteBayernBot!</b>\n\n"
                "Du bist jetzt eingetragen und erhältst Nachrichten zu jedem neuen freien Platz.\n"
                "Die Abfrage nach neuen Plätzen findet alle 10 Minuten statt.\n\n"
                "Sollte nur ein Teil für dich relevant sein, kannst du Filter hinzufügen:\n"
                "🔹 /filters zeigt deine aktuellen Filter an\n"
                "🔹 /add-filter um Filter hinzuzufügen\n"
                "🔹 /remove-filter um Filter zu entfernen\n"
                "🔹 /purge-filters um alle Filter zu löschen\n"
                "🔹 /list-courses zeigt alle bekannten Lehrgangsnamen\n"
                "🔹 /stop um dich abzumelden",
                parse_mode="HTML",
            )
        else:
            filter_count = len(user.filters) if user.filters else 0
            await message.answer(
                f"👋 Du bist bereits angemeldet.\n"
                f"Du hast {filter_count} Filter aktiviert.\n\n"
                "🔹 /filters zeigt deine aktuellen Filter an\n"
                "🔹 /add-filter um Filter hinzuzufügen\n"
                "🔹 /remove-filter um Filter zu entfernen\n"
                "🔹 /purge-filters um alle Filter zu löschen\n"
                "🔹 /list-courses zeigt alle bekannten Lehrgangsnamen\n"
                "🔹 /stop um dich abzumelden",
                parse_mode="HTML",
            )


@router.message(Command("stop"))
async def cmd_stop(message: types.Message, state: FSMContext):
    await state.set_state(FilterStates.waiting_for_stop_confirmation)
    await message.answer(
        "Möchtest du dich ganz abmelden? Bis zu einer Neuanmeldung wirst du keine Nachrichten mehr erhalten.\n\n"
        "Wenn ja, schreibe <b>j</b>, ansonsten <b>x</b> zum Abbrechen.",
        parse_mode="HTML",
    )


@router.message(FilterStates.waiting_for_stop_confirmation)
async def process_stop_confirmation(message: types.Message, state: FSMContext):
    text = message.text.lower().strip()

    if text == "j":
        user_id = message.from_user.id
        async with AsyncSessionLocal() as session:
            await session.execute(delete(User).where(User.user_id == user_id))
            await session.commit()

        await message.answer(
            "✅ Du wurdest abgemeldet. Solltest du dich umentscheiden und wieder Nachrichten bekommen wollen: /start",
            parse_mode="HTML",
        )
    else:
        await message.answer(
            "❌ Eingabe abgebrochen. Zurück zur Übersicht: /start", parse_mode="HTML"
        )

    await state.clear()
