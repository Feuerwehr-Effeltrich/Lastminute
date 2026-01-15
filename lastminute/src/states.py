from aiogram.fsm.state import State, StatesGroup


class FilterStates(StatesGroup):
    waiting_for_add_filter = State()
    waiting_for_remove_filter = State()
    waiting_for_purge_confirmation = State()
    waiting_for_stop_confirmation = State()
