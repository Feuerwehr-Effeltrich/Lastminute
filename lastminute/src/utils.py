import Levenshtein
import re


def deep_normalize(text: str) -> str:
    """Lowercase, replace umlaute (ä->ae etc), and remove all whitespace."""
    if not text:
        return ""
    text = text.lower()
    text = (
        text.replace("ä", "ae").replace("ö", "oe").replace("ü", "ue").replace("ß", "ss")
    )
    # Remove all whitespace
    text = re.sub(r"\s+", "", text)
    return text


def is_match(filter_keyword: str, text: str) -> bool:
    """
    Check if the filter matches the text using Levenshtein distance <= 1.
    Uses deep normalization (ignore case, spaces, and umlaute mapping).
    """
    norm_filter = deep_normalize(filter_keyword)
    norm_text = deep_normalize(text)

    # If filter is empty, ignore
    if not norm_filter:
        return False

    # 1. Exact match check (now includes substring since spaces are gone)
    # e.g. "geraetewart" in "geraetewarttsf"
    if norm_filter in norm_text:
        return True

    # 2. Full string Levenshtein check
    if Levenshtein.distance(norm_filter, norm_text) <= 1:
        return True

    # 3. Token-based fuzzy match
    # Since norm_text has no spaces, we need the original tokens but normalized
    original_tokens = text.split()
    for token in original_tokens:
        norm_token = deep_normalize(token)
        if Levenshtein.distance(norm_filter, norm_token) <= 1:
            return True

    return False
