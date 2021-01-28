FROM node:13.6.0-alpine

ARG IMAGE_TITLE
ARG IMAGE_CREATE_DATE
ARG IMAGE_SOURCE_REVISION

ARG IMAGE_DESCRIPTION="Default description"
ARG IMAGE_VERSION="0.1.0"
ARG IMAGE_AUTHOR="Admir Trakic"
ARG IMAGE_URL="https://hub.docker.com/r/atrakic/hello-k8s/"
ARG IMAGE_DOCUMENTATION="https://github.com/atrakic/hello-k8s/README.md"
ARG IMAGE_VENDOR="Admir Trakic"
ARG IMAGE_LICENCES="MIT"
ARG IMAGE_SOURCE="https://github.com/atrakic/hello-k8s.git"

# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title=$IMAGE_TITLE \
      org.opencontainers.image.description=$IMAGE_DESCRIPTION \
      org.opencontainers.image.created=$IMAGE_CREATE_DATE \
      org.opencontainers.image.version=$IMAGE_VERSION \
      org.opencontainers.image.authors=$IMAGE_AUTHOR \
      org.opencontainers.image.url=$IMAGE_URL \
      org.opencontainers.image.documentation=$IMAGE_DOCUMENTATION \
      org.opencontainers.image.vendor=$IMAGE_VENDOR \
      org.opencontainers.image.licenses=$IMAGE_LICENCES \
      org.opencontainers.image.source=$IMAGE_SOURCE \
      org.opencontainers.image.revision=$IMAGE_SOURCE_REVISION 

ENV MESSAGE=$MESSAGE

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY app/server.js /usr/src/app

USER node
CMD [ "npm", "start" ]
