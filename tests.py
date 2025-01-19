import requests

# Define the URL for the endpoint
url = "http://127.0.0.1:5054/alert"  # Replace with your actual host and port if different

# Define the data to send in the POST request
alert_data = {
    "alertname": "HighCPUUsage",
    "severity": "critical",
    "instance": "server01.example.com",
    "description": "CPU usage has exceeded 90% for 5 minutes"
}

# Send the POST request with JSON data
response = requests.post(url, json=alert_data)

# Print the response from the server
print("Response Code:", response.status_code)
print("Response Body:", response.text)
