FROM ubuntu
MAINTAINER Oluf Lorenzen
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list  ; apt-get update ; apt-get upgrade -y

#RUN apt-get -qy install language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8 ; dpkg-reconfigure locales

RUN apt-get install --no-install-recommends -y build-essential libssl-dev libboost-all-dev libdb++-dev libminiupnpc-dev git openssl autoconf libtool

ADD build.sh /build.sh

RUN bash build.sh


# config + webUI
RUN mkdir ~/.twister
RUN git clone https://github.com/miguelfreitas/twister-html.git ~/.twister/html
RUN echo -e "rpcuser=user\nrpcpassword=pwd" > ~/.twister/twister.conf
RUN chmod 600 ~/.twister/twister.conf

# startup
ADD runtwister.sh /runtwister.sh
RUN chmod +x runtwister.sh
EXPOSE 28332
RUN cd twister-core/src
#CMD ["./twisterd", "-rpcuser=user", "-rpcpassword=pwd"]
