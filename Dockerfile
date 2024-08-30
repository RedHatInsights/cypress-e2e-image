FROM quay.io/fedora/fedora:42
# FROM cypress/included:10.11.0
# We goota run as root because npm will install some binaries requried to run the cypress env
USER root
# install browser dependencies
RUN dnf install -y xorg-x11-server-Xvfb gtk2-devel gtk3-devel git libnotify-devel GConf2 nss libXScrnSaver alsa-lib nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# install yarn and verify node version
RUN npm --version \
  && npm install -g yarn@latest --force \
  && yarn --version \
  && node -p process.versions \
  && node -p 'module.paths' \
  && echo  " node version:    $(node -v) \n" \
    "npm version:     $(npm -v) \n" \
    "yarn version:    $(yarn -v) \n" \
    "user:            $(whoami) \n"
# override cypress cache because repository code will be loaded as volume
ENV CYPRESS_CACHE_FOLDER="/cypress_cache" 
# The cache folder has to be accessible by all because repository code will be loaded as volume
RUN mkdir -m 777 $CYPRESS_CACHE_FOLDER
RUN useradd -ms /bin/bash tester && \
    mkdir -p /e2e && \
    chown -R tester:tester /e2e

USER tester

WORKDIR /e2e

ENTRYPOINT [""]
