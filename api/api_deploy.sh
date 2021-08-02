#!/bin/bash
python3 -m venv env
source env/bin/activate
python3 -m pip install -r requirements.txt

trap 'kill %1; kill %2'
python3 api.py & bash scrape_and_parse.sh
pkill -f api.py