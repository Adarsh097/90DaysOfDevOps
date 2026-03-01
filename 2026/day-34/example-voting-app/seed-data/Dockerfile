FROM python:3.12-slim

WORKDIR /seed

RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN python make-data.py

CMD ["/seed/generate-votes.sh"]

