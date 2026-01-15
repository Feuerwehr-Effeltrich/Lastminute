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
            False,
        ),  # Distance > 1 (ä -> ae is 2 chars difference? No, ä is 1 char, ae is 2. Replace is 1 edit. Insert 'e' is another.)
        # Levenshtein "Gerätewart" vs "Geraetewart"
        # G-e-r-ä-t vs G-e-r-a-e-t
        # ä -> a (sub) + insert e. Distance 2.
        ("Gerätewrt", "Gerätewart TSF", True),  # Distance 1 (missing 'a')
        (
            "Gerätewar",
            "Gerätewart TSF",
            True,
        ),  # Substring exact (missing 't' at end of word)
        # Full title checks
        ("Gerätewart TSF", "Gerätewart TSF", True),  # Exact full
        ("Gerätewrt TSF", "Gerätewart TSF", True),  # Edit distance 1 full string
        # Non-matches
        ("Atemschutz", "Gerätewart TSF", False),
    ],
)
def test_levenshtein_matching(filter_kw, title, expected):
    assert is_match(filter_kw, title) == expected
