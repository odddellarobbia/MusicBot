FROM python:alpine

MAINTAINER Alexander Thurman, it.snake.co.inc@gmail.com ptero

#Install dependencies
RUN sudo apk update \
    && sudo apk install software-properties-common -y \
    && sudo add-apt-repository ppa:fkrull/deadsnakes -y \
    && sudo add-apt-repository ppa:mc3man/trusty-media -y \
    && sudo apk update -y \
    && sudo apk install build-essential unzip -y \
    && sudo apk install python3.5 python3.5-dev -y \
    && sudo apk install ffmpeg -y \
    && sudo apk install libopus-dev -y \
    && sudo apk install libffi-dev -y

#Install Pip
RUN sudo apt-get install wget \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && sudo python3.5 get-pip.py

RUN         apt-get update \
            && apk upgrade \
            && apk add --no-cache curl ca-certificates openssl \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container

#Add musicBot
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]

#Install PIP dependencies
RUN sudo pip install -r requirements.txt

#Add volume for configuration
VOLUME /home/container/config

CMD python3.5 run.py

