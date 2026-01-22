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


@patch("requests.Session")
def test_parsing_with_pagination(mock_session_cls):
    # Setup mock
    mock_session = Mock()
    mock_session_cls.return_value = mock_session

    # First response has the dropdown and only some items
    html_with_dropdown = """
    <html><body>
    <table class="list">
        <tr class="odd"><td></td><td><span class="contextMenu" data-id="1"></span></td><td>Event 1</td><td>26.01.2026 10:15 Uhr</td><td>26.01.2026 12:15 Uhr</td><td>Loc</td><td>5</td></tr>
        <tr class="pagingRow">
            <td>
                <select name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl13$ctl06">
                    <option value="10">10</option>
                    <option value="100">100</option>
                </select>
            </td>
        </tr>
    </table>
    </body></html>
    """

    # Second response has more items
    html_full = """
    <html><body>
    <table class="list">
        <tr class="odd"><td></td><td><span class="contextMenu" data-id="1"></span></td><td>Event 1</td><td>26.01.2026 10:15 Uhr</td><td>26.01.2026 12:15 Uhr</td><td>Loc</td><td>5</td></tr>
        <tr class="even"><td></td><td><span class="contextMenu" data-id="2"></span></td><td>Event 2</td><td>26.01.2026 10:15 Uhr</td><td>26.01.2026 12:15 Uhr</td><td>Loc</td><td>5</td></tr>
    </table>
    </body></html>
    """

    mock_resp1 = Mock()
    mock_resp1.text = html_with_dropdown
    mock_resp1.raise_for_status.return_value = None

    mock_resp2 = Mock()
    mock_resp2.text = html_full
    mock_resp2.raise_for_status.return_value = None

    mock_session.get.return_value = mock_resp1
    mock_session.post.return_value = mock_resp2

    events = fetch_events()

    assert len(events) == 2
    assert events[0].id == 1
    assert events[1].id == 2
    assert mock_session.post.called
    # Check that it called post with the right data
    args, kwargs = mock_session.post.call_args
    assert (
        kwargs["data"][
            "ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl13$ctl06"
        ]
        == "100"
    )


@patch("requests.Session")
def test_parsing_real_dump(mock_session_cls):
    # Setup mock
    mock_session = Mock()
    mock_session_cls.return_value = mock_session

    mock_response = Mock()
    mock_response.text = read_local_html()
    mock_response.raise_for_status.return_value = None

    mock_session.get.return_value = mock_response
    mock_session.post.return_value = mock_response

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
