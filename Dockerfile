FROM jenkins/jenkins:2.176.2-jdk11

LABEL maintainer="mark.earl.waite@gmail.com"

USER root

# For Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

RUN apt-get clean && apt-get update && apt-get dist-upgrade -y && apt-get install -y \
  build-essential \
  fontconfig \
  gcc-multilib \
  git-lfs \
  locales \
  lsb-release \
  make \
  procps \
  wget \
  && rm -rf /var/lib/apt/lists/* && git lfs install

# Enable en_US.UTF-8 locale and generate
RUN sed -i 's/. en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && ( [ -e /usr/share/locale/locale.alias ] || ln -s /etc/locale.alias /usr/share/locale/locale.alias ) \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8

USER jenkins

# $REF (defaults to `/usr/share/jenkins/ref/`) contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p ${REF}/init.groovy.d

# ADD ref /usr/share/jenkins/ref/

ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml

RUN git lfs install
