import pytest
import os
from unittest.mock import patch, Mock
from datetime import datetime
from src.scraper import fetch_events
from src.models import Event


# Helper to read the local HTML file
def read_local_html():
    with open("lastminute.aspx", "r", encoding="utf-8") as f:
        return f.read()


@patch("requests.get")
def test_parsing_real_dump(mock_get):
    # Setup mock
    mock_response = Mock()
    mock_response.text = read_local_html()
    mock_response.raise_for_status.return_value = None
    mock_get.return_value = mock_response

    # Run scraper
    events = fetch_events()

    # Assertions based on the known content of lastminute.aspx
    # We saw 5 rows in the file (Treffer 5)
    # IDs: 8302, 8281, 8577, 8303, 8282

    assert len(events) == 5

    # Check first event
    e1 = events[0]
    assert e1.id == 8302
    assert e1.title == "Gerätewart TSF"
    assert e1.location == "SFS-R"
    assert e1.seats == 7
    # 26.01.2026 10:15 Uhr
    assert e1.begin_ts == datetime(2026, 1, 26, 10, 15)
    # 28.01.2026 14:00 Uhr
    assert e1.end_ts == datetime(2026, 1, 28, 14, 0)

    # Check third event (ID 8577)
    e3 = events[2]
    assert e3.id == 8577
    assert e3.seats == 15
