from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics




# simple flask app
# flask app boilerplate
app = Flask(__name__)

metrics = PrometheusMetrics(app)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)