from aiogram import Router, types
from aiogram.filters import Command
from aiogram.fsm.context import FSMContext
from sqlalchemy import select, update
from typing import List

from src.database import AsyncSessionLocal
from src.models import User, Course
from src.states import FilterStates
from src.utils import deep_normalize

router = Router()


async def get_user_filters(user_id: int) -> List[str]:
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(User).where(User.user_id == user_id))
        user = result.scalars().first()
        return user.filters if user and user.filters else []


async def update_user_filters(user_id: int, filters: List[str]):
    async with AsyncSessionLocal() as session:
        # Fetch user first to ensure session tracking (or use update statement directly)
        stmt = update(User).where(User.user_id == user_id).values(filters=filters)
        await session.execute(stmt)
        await session.commit()


@router.message(Command("filters"))
async def cmd_filters(message: types.Message):
    filters = await get_user_filters(message.from_user.id)

    if not filters:
        await message.answer(
            "ℹ️ Du hast derzeit keine eigenen Filter festgelegt, du bekommst sofort alle freien Plätze mit.\n\n"
            "Zurück zur Übersicht: /start"
        )
    else:
        filter_list = "\n".join([f"- {f}" for f in filters])
        await message.answer(
            f"📋 Deine aktuellen Filter:\n{filter_list}\n\nZurück zur Übersicht: /start"
        )


@router.message(Command("addfilter"))
async def cmd_add_filter(message: types.Message, state: FSMContext):
    await state.set_state(FilterStates.waiting_for_add_filter)
    await message.answer(
        "Gebe einen oder mehrere Suchtitel ein, nach denen gefiltert werden soll.\n"
        "Für mehrere Titel, trenne diese mit einem Strichpunkt <b>;</b>\n\n"
        "Groß- und Kleinschreibung ist egal, ebenso werden Leerzeichen bei Filtern ignoriert.\n"
        "Um die Eingabe abzubrechen, schreibe <b>x</b>",
        parse_mode="HTML",
    )


@router.message(FilterStates.waiting_for_add_filter)
async def process_add_filter(message: types.Message, state: FSMContext):
    text = message.text.strip()

    if text.lower() == "x":
        await state.clear()
        await message.answer("❌ Eingabe abgebrochen. Zurück zur Übersicht: /start")
        return

    new_keywords = [k.strip() for k in text.split(";") if k.strip()]

    if not new_keywords:
        await message.answer(
            "⚠️ Keine gültigen Filter erkannt. Bitte versuche es erneut oder 'x' zum Abbrechen."
        )
        return

    current_filters = await get_user_filters(message.from_user.id)
    # Combine and deduplicate based on normalized version to avoid redundant looking filters
    # but we want to keep the one the user just typed if it's "better" or just unique.
    # Actually, simpler: just add them and deduplicate by deep_normalize.

    existing_norm = {deep_normalize(f) for f in current_filters}
    for k in new_keywords:
        if deep_normalize(k) not in existing_norm:
            current_filters.append(k)
            existing_norm.add(deep_normalize(k))

    await update_user_filters(message.from_user.id, current_filters)

    await state.clear()
    await message.answer(
        "✅ Dein Filter wurde eingetragen. Zurück zur Übersicht: /start"
    )


@router.message(Command("removefilter"))
async def cmd_remove_filter(message: types.Message, state: FSMContext):
    filters = await get_user_filters(message.from_user.id)

    if not filters:
        await message.answer(
            "ℹ️ Du hast derzeit keine eigenen Filter festgelegt. Zurück zur Übersicht: /start"
        )
        return

    filter_list = "\n".join([f"- {f}" for f in filters])
    await state.set_state(FilterStates.waiting_for_remove_filter)
    await message.answer(
        f"📋 Deine aktuellen Filter:\n{filter_list}\n\n"
        "Gebe einen oder mehrere Filter ein, die wieder entfernt werden sollen.\n"
        "Für mehrere Filter, trenne diese mit einem Strichpunkt <b>;</b>\n\n"
        "Um die Eingabe abzubrechen, schreibe <b>x</b>",
        parse_mode="HTML",
    )


@router.message(FilterStates.waiting_for_remove_filter)
async def process_remove_filter(message: types.Message, state: FSMContext):
    text = message.text.strip()

    if text.lower() == "x":
        await state.clear()
        await message.answer("❌ Eingabe abgebrochen. Zurück zur Übersicht: /start")
        return

    to_remove_norm = {deep_normalize(k) for k in text.split(";") if k.strip()}
    current_filters = await get_user_filters(message.from_user.id)

    # Remove best effort (normalized comparison)
    updated_filters = [
        f for f in current_filters if deep_normalize(f) not in to_remove_norm
    ]

    await update_user_filters(message.from_user.id, updated_filters)

    await state.clear()
    await message.answer("✅ Die Filter wurden entfernt. Zurück zur Übersicht: /start")


@router.message(Command("purgefilters"))
async def cmd_purge_filters(message: types.Message, state: FSMContext):
    await state.set_state(FilterStates.waiting_for_purge_confirmation)
    await message.answer(
        "⚠️ <b>Filter zurücksetzen</b>\n\n"
        "Du bist dabei, alle deine Filter zu löschen. Ab dann bekommst du wieder Nachrichten für <b>alle</b> freien Plätze.\n\n"
        "Willst du das wirklich tun?\n"
        "🔹 Schreibe <b>j</b> zum Bestätigen\n"
        "🔹 Schreibe <b>x</b> zum Abbrechen",
        parse_mode="HTML",
    )


@router.message(FilterStates.waiting_for_purge_confirmation)
async def process_purge_confirmation(message: types.Message, state: FSMContext):
    text = message.text.lower().strip()

    if text == "j":
        await update_user_filters(message.from_user.id, [])
        await message.answer(
            "✅ <b>Deine Filter wurden entfernt.</b>\n\nZurück zur Übersicht: /start",
            parse_mode="HTML",
        )
    else:
        await message.answer("❌ Eingabe abgebrochen. Zurück zur Übersicht: /start")

    await state.clear()


@router.message(Command("listcourses"))
async def cmd_list_courses(message: types.Message):
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(Course.title).order_by(Course.title))
        titles = result.scalars().all()

    if not titles:
        await message.answer("ℹ️ Noch keine Lehrgänge bekannt.")
        return

    # Telegram message limit is 4096 chars.
    # We might need to split.
    msg_buffer = "📚 <b>Bekannte Lehrgänge:</b>\n\n"

    for title in titles:
        line = f"- {title}\n"
        if len(msg_buffer) + len(line) > 4000:
            await message.answer(msg_buffer, parse_mode="HTML")
            msg_buffer = ""
        msg_buffer += line

    if msg_buffer:
        await message.answer(msg_buffer, parse_mode="HTML")
