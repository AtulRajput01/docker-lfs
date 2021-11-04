FROM jenkins/jenkins:2.303.3

LABEL maintainer="mark.earl.waite@gmail.com"

USER root

# hadolint ignore=DL3008
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
  gnupg \
  make \
  procps \
  wget \
  && rm -rf /var/lib/apt/lists/*

USER jenkins

# Check that expected utilities are available in the image
RUN ps -ef | grep UID && git lfs version | grep git-lfs/ && wget -V 2>&1 | grep -i free

# $REF (defaults to `/usr/share/jenkins/ref/`) contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p "${REF}/init.groovy.d"

COPY --chown=jenkins:jenkins ref /usr/share/jenkins/ref/

ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml
