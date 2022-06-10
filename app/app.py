from flask import Flask
from random import randrange
from time import time
import json

app = Flask(__name__)

registry = {
    'server_requests_process_count': {
        'main': 0,
        'rv': 0
    },
    'server_pending_requests': {
        'main': 0,
        'rv': 0
    },
}

def update_metric_values(registry):
    registry['server_pending_requests']['main'] = randrange(0, 2) * randrange(0, 11)
    registry['server_pending_requests']['rv'] = randrange(0, 2) * randrange(0, 3)
    registry['server_requests_process_count']['main'] += randrange(100, 1001)
    registry['server_requests_process_count']['rv'] += randrange(10, 51)

@app.after_request
def treat_as_plain_text(response):
    response.headers["content-type"] = "text/plain"
    return response

@app.route("/metrics/prometheus")
def prometheus():
    global registry
    update_metric_values(registry)

    return f"""# HELP server_requests_process
# TYPE server_requests_process counter
server_requests_process_count{{alias="server-rv"}} {registry['server_requests_process_count']['rv']}
server_requests_process_count{{alias="server-main"}} {registry['server_requests_process_count']['main']}
# HELP server_pending_requests
# TYPE server_pending_requests gauge
server_pending_requests{{alias="server-rv"}} {registry['server_pending_requests']['rv']}
server_pending_requests{{alias="server-main"}} {registry['server_pending_requests']['main']}"""

@app.route("/metrics/json")
def json_metrics():
    global registry
    update_metric_values(registry)

    current_time = time()
    data = [
        {
            'label_pairs': {
                'alias': 'server-rv'
            },
            'timestamp': current_time,
            'metric_name': 'server_requests_process_count',
            'value': registry['server_requests_process_count']['rv']
        },

        {
            'label_pairs': {
                'alias': 'server-main'
            },
            'timestamp': current_time,
            'metric_name': 'server_requests_process_count',
            'value': registry['server_requests_process_count']['main']
        },

        {
            'label_pairs': {
                'alias': 'server-rv'
            },
            'timestamp': current_time,
            'metric_name': 'server_pending_requests',
            'value': registry['server_pending_requests']['rv']
        },

        {
            'label_pairs': {
                'alias': 'server-main'
            },
            'timestamp': current_time,
            'metric_name': 'server_pending_requests',
            'value': registry['server_pending_requests']['main']
        }
    ]

    return json.dumps(data)
