FROM debian:8

MAINTAINER qxip <info@qxip.net>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# Setup Packages & Permissions
RUN apt-get update && apt-get install -y wget \
 && wget -O /dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 \
 && chmod +x /dumb-init \
 && cd /etc/apt/sources.list.d \
 && echo deb http://packages.irontec.com/debian oasis main extra > ivozprovider.list \
 && echo deb http://packages.irontec.com/debian chloe main > klear.list \
 && wget http://packages.irontec.com/public.key -q -O - | apt-key add - \
 && apt-get update && apt-get install -y ivozprovider \
 && apt-get clean && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
 # dpkg-reconfigure ivozprovider
 
 # Expose Ports
EXPOSE 5060 5061
EXPOSE 22
EXPOSE 80 443
EXPOSE 10000-20000

# Exec on start
ENTRYPOINT ["/dumb-init", "--"]
