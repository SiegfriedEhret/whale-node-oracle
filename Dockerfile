FROM node:8

LABEL maintainer="siegfried@ehret.me" \
    version="1.0"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    libaio1 \
    build-essential \
    unzip \
    curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p opt/oracle

ADD ./oracle/linux/ .

RUN unzip instantclient-basic-linux.x64-12.2.0.1.0.zip -d /opt/oracle \
  && unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /opt/oracle  \
  && mv /opt/oracle/instantclient_12_2 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install && npm cache clean --force
ONBUILD COPY . /usr/src/app

CMD [ "npm", "start" ]