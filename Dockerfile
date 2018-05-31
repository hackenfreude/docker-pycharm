ARG OPENJDK_TAG=8u171-jdk

FROM buildpack-deps:stretch-curl as downloader

ARG PYCHARM_VERSION=2018.1.3

ADD https://download.jetbrains.com/python/pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256 pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256

ADD https://download.jetbrains.com/python/pycharm-community-${PYCHARM_VERSION}.tar.gz pycharm-community-${PYCHARM_VERSION}.tar.gz

RUN sha256sum -c pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256

RUN mkdir /opt/pycharm && tar -C /opt/pycharm --strip-components=1 -xvf pycharm-community-${PYCHARM_VERSION}.tar.gz


FROM openjdk:${OPENJDK_TAG} as pycharm

COPY --from=downloader /opt/pycharm /opt/pycharm

ENTRYPOINT ["/opt/pycharm/bin/pycharm.sh"]
