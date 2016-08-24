FROM    ubuntu:xenial

# Build variables
ENV     FILEBEAT_VERSION=1.2.3
ENV     FILEBEAT_URL=https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz

# Environment variables
ENV     FILEBEAT_HOME=/opt/filebeat
ENV     PATH=$PATH:${FILEBEAT_HOME}

WORKDIR /opt
# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    python \
    wget \
&& rm -rf /var/lib/apt/lists/*

ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
&& gosu nobody true

COPY     filebeat.yml ${FILEBEAT_HOME}/
RUN     curl -sL ${FILEBEAT_URL} | tar xz -C ${FILEBEAT_HOME}
RUN     mv ${FILEBEAT_HOME}/filebeat-${FILEBEAT_VERSION}-x86_64/* ${FILEBEAT_HOME}
RUN     rm -rf ${FILEBEAT_HOME}/filebeat-${FILEBEAT_VERSION}-x86_64

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-e", "-v", "-c", "/filebeat.yml", ""]
