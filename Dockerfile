FROM jenkins/jenkins:2.332

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

# jenkins.war checksum, download will be validated using it
ARG JENKINS_SHA=fb40362f3a04e730cd82f8114440f19ffa12e86cb39dff234050ded2889808d8

ARG JENKINS_URL=https://home.markwaite.net/~mwaite/jenkins-builds/2.332.1-rc-2/jenkins.war

# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
USER root
RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -
USER jenkins

# $REF (defaults to `/usr/share/jenkins/ref/`) contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p "${REF}/init.groovy.d"

COPY --chown=jenkins:jenkins ref /usr/share/jenkins/ref/

ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml
