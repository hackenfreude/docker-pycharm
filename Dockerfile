FROM buildpack-deps:stretch-curl as downloader

ARG PYCHARM_VERSION=2018.2.4

ADD https://download.jetbrains.com/python/pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256 pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256

ADD https://download.jetbrains.com/python/pycharm-community-${PYCHARM_VERSION}.tar.gz pycharm-community-${PYCHARM_VERSION}.tar.gz

RUN sha256sum -c pycharm-community-${PYCHARM_VERSION}.tar.gz.sha256

RUN mkdir /opt/pycharm && tar -C /opt/pycharm --strip-components=1 -xvf pycharm-community-${PYCHARM_VERSION}.tar.gz


FROM python:3.7.1-stretch as pycharm

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install openjdk-8-jdk libcanberra-gtk-module libcanberra-gtk3-module

COPY --from=downloader /opt/pycharm /opt/pycharm

ENTRYPOINT ["/opt/pycharm/bin/pycharm.sh"]

