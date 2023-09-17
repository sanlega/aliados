FROM python:3-slim

WORKDIR /app

COPY . .

RUN pip install paho-mqtt

CMD ["python", "backend.py"]
