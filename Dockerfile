
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
    && sudo apt-get install libffi-dev -y \
    && sudo apt-get install sudo -y

#Install Pip
RUN sudo apt-get install wget \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && sudo python3.5 get-pip.py

RUN mkdir -p /home/container

WORKDIR /home/container

COPY ./requirements.txt /home/container/requirements.txt

#Install PIP dependencies
RUN sudo pip install -r requirements.txt

RUN         sudo adduser -D -h /home/container container sudo

RUN         sudo sh -c "echo 'container ALL=NOPASSWD: ALL' >> /etc/sudoers"

USER        container
ENV         USER=container HOME=/home/container

#Add musicBot
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]

CMD python3.5 run.py
