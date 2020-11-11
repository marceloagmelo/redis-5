FROM registry.redhat.io/rhscl/redis-5-rhel7:latest

#ENV REDIS_DATADIR /var/lib/redis/data

COPY redis-master.conf ${HOME}/redis-master/redis.conf
COPY redis-slave.conf ${HOME}/redis-slave/redis.conf
COPY run.sh ${REDIS_PREFIX}/bin/run.sh
ADD scripts ${CONTAINER_SCRIPTS_PATH}

USER root

RUN rm -rf /etc/yum.repos.d/ubi.repo && \
    yum-config-manager --save --enable rhel-7-server-eus-rpms --releasever 7.7 && \
    yum clean all && yum update -y --releasever 7.7 && \
    yum install -y --releasever 7.7 net-tools hostname cronie gettext && \
    yum clean all && \
    rm -Rf /tmp/* && rm -Rf /var/tmp/* && \
    chown -R 1001:0 /var/lib/redis && \
    chmod -R 777 ${HOME}/redis-* && \
    chown -R 1001:0 ${HOME}

USER 1001

COPY Dockerfile $HOME/Dockerfile

CMD [ "run.sh" ]
