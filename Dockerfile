FROM ubuntu:14.04
MAINTAINER Kenneth Falck <kennu@iki.fi>
RUN apt-get update -qq
RUN apt-get install -y -qq wget
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y -qq cron
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y -qq munin
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apache2
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
ADD default.conf /etc/apache2/sites-enabled/default.conf
RUN (mkdir -p /var/run/munin && chown -R munin:munin /var/run/munin)
ADD run.sh /usr/local/bin/run
VOLUME /var/lib/munin
VOLUME /var/log/munin
EXPOSE 80
CMD ["/usr/local/bin/run"]
