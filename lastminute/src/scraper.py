import requests
import re
from bs4 import BeautifulSoup
from datetime import datetime, timezone
from typing import List, Optional, Dict
import logging
from src.models import Event

logger = logging.getLogger(__name__)

URL = "https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx"


def parse_date(date_str: str) -> Optional[datetime]:
    """Parse date string like '26.01.2026 10:15 Uhr'."""
    try:
        clean_str = date_str.replace(" Uhr", "").strip()
        return datetime.strptime(clean_str, "%d.%m.%Y %H:%M")
    except ValueError as e:
        logger.error(f"Failed to parse date '{date_str}': {e}")
        return None


def _get_hidden_fields(soup: BeautifulSoup) -> Dict[str, str]:
    """Extract ASP.NET hidden fields from the soup."""
    fields = {}
    for input_tag in soup.find_all("input", type="hidden"):
        name = input_tag.get("name")
        if name:
            fields[name] = input_tag.get("value", "")
    return fields


def fetch_events() -> List[Event]:
    """
    Fetches and parses the last minute events.
    Sets the page size to 100 if a paging dropdown is found.
    Returns a list of Event objects.
    Raises Exception if parsing fails (structure change).
    """
    session = requests.Session()
    # Add a common User-Agent to avoid being blocked
    session.headers.update(
        {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        }
    )

    try:
        resp = session.get(URL, timeout=30)
        resp.raise_for_status()
    except requests.RequestException as e:
        logger.error(f"Network error fetching initial page: {e}")
        return []

    soup = BeautifulSoup(resp.text, "html.parser")

    # Try to find the page size dropdown and set it to 100
    # We look for the pagingRow and then the select element inside it
    paging_row = soup.find("tr", class_="pagingRow")
    target_select = paging_row.find("select") if paging_row else None

    if target_select:
        target_name = str(target_select.get("name"))

        hidden_fields = _get_hidden_fields(soup)
        payload = {
            "__EVENTTARGET": target_name,
            "__EVENTARGUMENT": "",
            "__LASTFOCUS": "",
            **hidden_fields,
            target_name: "100",
        }
        try:
            logger.info("Requesting 100 entries per page...")
            resp = session.post(URL, data=payload, timeout=30)
            resp.raise_for_status()
            soup = BeautifulSoup(resp.text, "html.parser")
        except requests.RequestException as e:
            logger.error(f"Network error setting page size: {e}")
            # Continue with initial soup if post fails

    table = soup.find("table", class_="list")

    if not table:
        # Critical error: Structure changed?
        logger.error("Could not find table with class 'list'")
        raise ValueError("Table 'list' not found")

    events = []
    rows = table.find_all("tr", class_=["odd", "even"])

    for row in rows:
        cols = row.find_all("td")
        if len(cols) < 7:
            continue

        try:
            # ID is in the span in the second column (index 1)
            id_span = cols[1].find("span", class_="contextMenu")
            if not id_span or "data-id" not in id_span.attrs:
                logger.warning("Could not find data-id in row")
                continue

            event_id = int(str(id_span["data-id"]))

            title = cols[2].get_text(strip=True)
            begin_str = cols[3].get_text(strip=True)
            end_str = cols[4].get_text(strip=True)
            location = cols[5].get_text(strip=True)
            seats_str = cols[6].get_text(strip=True)

            begin_ts = parse_date(begin_str)
            end_ts = parse_date(end_str)
            seats = int(seats_str) if seats_str.isdigit() else 0

            event = Event(
                id=event_id,
                title=title,
                begin_ts=begin_ts,
                end_ts=end_ts,
                location=location,
                seats=seats,
                last_seen=datetime.now(timezone.utc).replace(tzinfo=None),
            )
            events.append(event)

        except (ValueError, AttributeError) as e:
            logger.error(f"Error parsing row: {e}")
            continue

    return events
