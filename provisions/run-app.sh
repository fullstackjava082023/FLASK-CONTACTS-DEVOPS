#!/bin/bash
echo starting installing venv

python3 -m venv ~/.venv
. ~/.venv/bin/activate

# Install Python dependencies from requirements.txt
pip3 install -r requirements.txt

# Run migrations
# python3 migrate.py

# Start the application
python3 app.py