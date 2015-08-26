FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ADD https://launchpadlibrarian.net/139763816/unzip_6.0-9ubuntu1_amd64.deb /unzip.deb
RUN dpkg -i /unzip.deb && rm -f /unzip.deb

ADD https://dl.ngrok.com/ngrok_2.0.19_linux_amd64.zip /ngrok.zip
RUN unzip -o ngrok.zip -d /bin && false || rm -f ngrok.zip

RUN mkdir -p /etc/service/ngrok

ADD ./add/etc/service/ngrok/run /etc/service/ngrok/run
RUN chmod +x /etc/service/ngrok/run

RUN groupadd -r ngrok && useradd -rm -g ngrok ngrok

ADD ./add/home/ngrok/.ngrok2/ngrok.yml /home/ngrok/.ngrok2/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
