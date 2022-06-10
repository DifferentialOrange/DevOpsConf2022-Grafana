FROM python:3.9

COPY . .
RUN pip3 install --upgrade pip -r requirements.txt

ENV FLASK_APP='app'

CMD flask run --host 0.0.0.0 --port 8081
