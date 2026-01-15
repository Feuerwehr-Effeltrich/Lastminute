import pytest
from src.utils import is_match


@pytest.mark.parametrize(
    "filter_kw, title, expected",
    [
        ("Gerätewart", "Gerätewart TSF", True),  # Substring exact
        ("gerätewart", "Gerätewart TSF", True),  # Case insensitive
        ("  Gerätewart ", "Gerätewart TSF", True),  # Whitespace
        (
            "Geraetewart",
            "Gerätewart TSF",
            True,
        ),  # Distance 0 with ae->ä normalization
        ("Geräte wart", "Gerätewart TSF", True),  # Ignore spaces
        ("Gerätewrt", "Gerätewart TSF", True),  # Distance 1 (missing 'a')
        (
            "Gerätewar",
            "Gerätewart TSF",
            True,
        ),  # Substring exact (missing 't' at end of word)
        # Full title checks
        ("Gerätewart TSF", "Gerätewart TSF", True),  # Exact full
        ("Gerätewrt TSF", "Gerätewart TSF", True),  # Edit distance 1 full string
        ("Geraetewart TSF", "Gerätewart TSF", True),  # Umlaute and full string
        # Non-matches
        ("Atemschutz", "Gerätewart TSF", False),
    ],
)
def test_levenshtein_matching(filter_kw, title, expected):
    assert is_match(filter_kw, title) == expected
