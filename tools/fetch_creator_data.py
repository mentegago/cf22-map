#!/usr/bin/env python3
import json
import urllib.request
from pathlib import Path

URL = "https://cf22-config.nnt.gg/data/creator-data.json"
OUTPUT = Path(__file__).parent.parent / "data" / "creator-data-initial.json"

def main():
    print(f"Fetching {URL}...")
    req = urllib.request.Request(URL, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as response:
        data = json.loads(response.read().decode())

    with open(OUTPUT, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f"Saved to {OUTPUT}")

if __name__ == "__main__":
    main()
