python3 -m venv ~/.venv
source ~/.venv/bin/activate

# Install Python dependencies from requirements.txt
pip3 install -r requirements.txt

# Run migrations
python3 migrate.py

# Start the application
python3 app.py