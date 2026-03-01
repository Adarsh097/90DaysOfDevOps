FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt /app

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt

COPY . /app

EXPOSE 80

CMD ["python","app.py"]
