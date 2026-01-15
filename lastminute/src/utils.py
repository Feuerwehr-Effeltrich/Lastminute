import Levenshtein


def normalize_text(text: str) -> str:
    """Lowercase and strip text."""
    if not text:
        return ""
    return text.lower().strip()


def is_match(filter_keyword: str, text: str) -> bool:
    """
    Check if the filter matches the text using Levenshtein distance <= 1.
    Both inputs are normalized before comparison.
    """
    norm_filter = normalize_text(filter_keyword)
    norm_text = normalize_text(text)

    # If filter is empty, ignore (logic handled elsewhere usually, but safe guard)
    if not norm_filter:
        return False

    # Exact match check first (fast path)
    if norm_filter in norm_text:
        return True

    # 2. Full string Levenshtein check
    if Levenshtein.distance(norm_filter, norm_text) <= 1:
        return True

    # 3. Token-based fuzzy match
    # Allows "Gerätewrt" to match "Gerätewart" in "Gerätewart TSF"
    tokens = norm_text.split()
    for token in tokens:
        if Levenshtein.distance(norm_filter, token) <= 1:
            return True

    return False
