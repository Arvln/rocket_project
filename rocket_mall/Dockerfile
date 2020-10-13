FROM python:3.7

MAINTAINER AVN

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /var/www/html/rocket_mall

WORKDIR /var/www/html/rocket_mall

ADD . /var/www/html/rocket_mall

RUN /usr/local/bin/python -m pip install --upgrade pip \
&& pip install -r requirements.txt \
&& chmod +x ./start.sh

