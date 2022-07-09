import time

import redis
from flask import Flask
import random


app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)
host_id = random.randint(100000, 1000000)


def get_hit_count():
    retries = 5

    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)


@app.route('/')
def hello():
    count = get_hit_count()
    return 'Count: {}, host_id: {}.\n'.format(count, host_id)
