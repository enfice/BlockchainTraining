FROM ubuntu:xenial

MAINTAINER Kakasaheb Waghmare <kk@enfice.com>

RUN apt-get clean && apt-get update -y --fix-missing
RUN apt-get install -y locales git curl net-tools wget iputils-ping nano
RUN apt-get install -y apache2
RUN apt-get install -y php libapache2-mod-php php-mcrypt php-curl

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD . /opt/multichain
WORKDIR /opt/multichain
RUN wget https://www.multichain.com/download/multichain-1.0.4.tar.gz
RUN tar -xvzf multichain-1.0.4.tar.gz
WORKDIR /opt/multichain/multichain-1.0.4
RUN mv multichaind multichain-cli multichain-util /usr/local/bin


WORKDIR /var/www/html
RUN git clone https://github.com/MultiChain/multichain-web-demo.git

WORKDIR /opt/multichain
