FROM node:14.18.1-bullseye

LABEL maintainer="song22861@naver.com"

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y curl glib2.0-dev gpg libglu1-mesa-dev libglib2.0-dev libvips-dev libvips-tools nfs-common xvfb xz-utils expect \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /hello-aws-docker

COPY --chown=node:node package.json /hello-aws-docker/package.json

RUN npm install -g npm \
&& npm i -g @nestjs/cli \
&& npm install