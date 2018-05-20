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

# multichain
ADD . /opt/multichain
WORKDIR /opt/multichain
RUN wget https://www.multichain.com/download/multichain-1.0.4.tar.gz
RUN tar -xvzf multichain-1.0.4.tar.gz
WORKDIR /opt/multichain/multichain-1.0.4
RUN mv multichaind multichain-cli multichain-util /usr/local/bin

# multichain web demo
WORKDIR /var/www/html
RUN git clone https://github.com/MultiChain/multichain-web-demo.git

#multichain explorer
RUN apt-get install -y sqlite3 libsqlite3-dev python-dev python-pip
RUN pip install --upgrade pip
WORKDIR /tmp
RUN wget https://pypi.python.org/packages/60/db/645aa9af249f059cc3a368b118de33889219e0362141e75d4eaf6f80f163/pycrypto-2.6.1.tar.gz
RUN tar -xvzf pycrypto-2.6.1.tar.gz
WORKDIR /tmp/pycrypto-2.6.1
RUN python setup.py install
WORKDIR /opt/multichain
RUN git clone https://github.com/MultiChain/multichain-explorer.git
WORKDIR /opt/multichain/multichain-explorer
RUN python setup.py install

WORKDIR /opt/multichain
