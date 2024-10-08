FROM centos
MAINTAINER Jessica Forrester <jforresttyty@redhat.com>

# Add repo files
ADD ./mongo.repo /etc/yum.repos.d/

# Install MongoDB packages and extras
RUN yum --assumeyes update && \
    yum --assumeyes install \ 
      mongo-10gen-server \
      mongo-10gen \
      procps-ng \
      iptables && \
    yum clean all && \
    mkdir -p /var/lib/mongodb && \
    touch /var/lib/mongodb/.keep && \
    chown -R mongod:mongod /var/lib/mongodb

VOLUME ["/var/lib/mongodb"]
USER mongod

ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017
CMD ["/usr/bin/mongod", "--config", "/etc/mongodb.conf"]
