from flask import Flask, request, jsonify, Response
import logging
import os

app = Flask(__name__)

# Configure logging
# Configure logging to output to both console and a file
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s', handlers=[
    logging.FileHandler("webhook.log"),
    logging.StreamHandler()
])
logger = logging.getLogger()

@app.route('/')
def index():
    text = 'Webhooks service is running! 11'
    # Prepare response content
    if os.path.exists("webhook.log"):
        with open("webhook.log", 'r') as file:
            log_content = file.read()
        response_content = f"{text}\n\n{log_content}"
        return Response(response_content, mimetype='text/plain')
    else:
        response_content = f"{text}\n\nLog file does not exist."
        return Response(response_content, mimetype='text/plain', status=404)
    

@app.route('/webhook', methods=['POST'])
def webhook():
    if request.method == 'POST':
        payload = request.json
        # logger.info(payload)
         # Extract commit ID and commit message
        if payload:
            # Extract repository name
            repository = payload.get('repository', {}).get('name', 'Unknown Repository')
            logger.info(f"Repository Name: {repository}")
            commits = payload.get('commits', [])
            for commit in commits:
                commit_id = commit.get('id')
                commit_message = commit.get('message')
                modified_files = commit.get('modified', [])
                added_files = commit.get('added', [])
                removed_files = commit.get('removed', [])
                
                logger.info(f"Commit ID: {commit_id}")
                logger.info(f"Commit Message: {commit_message}")
                logger.info(f"Modified Files: {modified_files}")
                logger.info(f"Added Files: {added_files}")
                logger.info(f"Removed Files: {removed_files}")
        return jsonify({'status': 'success'}), 200
     
    logger.error('Invalid request')
    return jsonify({'status': 'error'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)