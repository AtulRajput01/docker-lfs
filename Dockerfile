FROM jenkins/jenkins:2.277.1-lts

LABEL maintainer="mark.earl.waite@gmail.com"

USER root

# hadolint ignore=DL3008
RUN apt-get clean && apt-get update && apt-get dist-upgrade -y && apt-get install -y --no-install-recommends \
  procps \
  wget \
  && rm -rf /var/lib/apt/lists/*

USER jenkins

# $REF (defaults to `/usr/share/jenkins/ref/`) contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
COPY ref /usr/share/jenkins/ref/

ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml
