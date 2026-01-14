import requests

resp = requests.get("https://www.bms-fw.bayern.de/Navigation/Public/lastminute.aspx")

print(resp.text)
