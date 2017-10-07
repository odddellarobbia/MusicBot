FROM ubuntu:14.04

MAINTAINER Alexander Thurman, it.snake.co.inc@gmail.com ptero

#Install dependencies
RUN sudo apt-get update \
    && sudo apt-get install software-properties-common -y \
    && sudo add-apt-repository ppa:fkrull/deadsnakes -y \
    && sudo add-apt-repository ppa:mc3man/trusty-media -y \
    && sudo apt-get update -y \
    && sudo apt-get install build-essential unzip -y \
    && sudo apt-get install python3.5 python3.5-dev -y \
    && sudo apt-get install ffmpeg -y \
    && sudo apt-get install libopus-dev -y \
    && apt-get upgrade \
    && apt-get install curl -y \
    && apt-get install ca-certificates -y \ 
    && apt-get install openssl -y \    
    && sudo apt-get install libffi-dev -y

#Install Pip
RUN sudo apt-get install wget \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && sudo python3.5 get-pip.py

COPY ./requirements.txt /requirements.txt

#Install PIP dependencies
RUN sudo pip install -r requirements.txt

RUN         adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container

#Add musicBot
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]

CMD python3.5 run.py

