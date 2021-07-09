group "linux" {
  targets = [
    "alpine_jdk8",
    "centos7_jdk8",
    "centos8_jdk8",
    "debian_jdk8",
    "debian_jdk11",
    "debian_slim_jdk8",
  ]
}

group "linux-arm64" {
  targets = [
    "centos8_jdk8",
    "debian_jdk8",
    "debian_jdk11",
    "debian_slim_jdk8",
  ]
}

group "linux-s390x" {
  targets = [
    "debian_jdk11",
  ]
}

group "linux-ppc64le" {
  targets = [
    "centos8_jdk8",
    "debian_jdk8",
    "debian_jdk11",
    "debian_slim_jdk8",
  ]
}

group "windows" {
  targets = [
    "windows_1809_jdk11",
    "windows_2019_jdk11",
  ]
}

variable "JENKINS_VERSION" {
  default = "2.300"
}

variable "JENKINS_SHA" {
  default = "2f6aa548373b038af4fb6a4d6eaa5d13679510008f1712532732bf77c55b9670"
}

variable "REGISTRY" {
  default = "docker.io"
}

variable "JENKINS_REPO" {
  default = "jenkins/jenkins"
}

variable "LATEST_WEEKLY" {
  default = "false"
}

variable "LATEST_LTS" {
  default = "false"
}

variable "GIT_LFS_VERSION" {
  default = "2.13.3"
}

variable "PLUGIN_CLI_VERSION" {
  default = "2.10.0"
}

target "alpine_jdk8" {
  dockerfile = "8/alpine/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}-alpine",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:alpine" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-alpine" : "",
  ]
  platforms = ["linux/amd64"]
}

target "centos7_jdk8" {
  dockerfile = "8/centos/centos7/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}-centos7",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:centos7" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-centos7" : "",
  ]
  platforms = ["linux/amd64"]
}

target "centos8_jdk8" {
  dockerfile = "8/centos/centos8/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}-centos",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:centos" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-centos" : "",
  ]
  platforms = ["linux/amd64", "linux/ppc64le", "linux/arm64"]
}

target "debian_jdk8" {
  dockerfile = "8/debian/buster/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:latest" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts" : "",
  ]
  platforms = ["linux/amd64", "linux/ppc64le", "linux/arm64"]
}

target "debian_jdk11" {
  dockerfile = "11/debian/buster/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}-jdk11",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:jdk11" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-jdk11" : "",
  ]
  platforms = ["linux/amd64", "linux/ppc64le", "linux/arm64", "linux/s390x"]
}

target "debian_slim_jdk8" {
  dockerfile = "8/debian/buster-slim/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    GIT_LFS_VERSION = GIT_LFS_VERSION
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:${JENKINS_VERSION}-slim",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:slim" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-slim" : "",
  ]
  platforms = ["linux/amd64", "linux/ppc64le", "linux/arm64"]
}

# TODO update windows publishing script to use this file
target "windows_1809_jdk11" {
  dockerfile = "11/windows/windowsservercore-1809/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }

  tags = [
    "${REGISTRY}/${JENKINS_REPO}:jdk11-hotspot-windowsservercore-1809",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:windowsservercore-1809" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-windowsservercore-1809" : "",
  ]
}

# TODO update windows publishing script to use this file
target "windows_2019_jdk11" {
  dockerfile = "11/windows/windowsservercore-2019/hotspot/Dockerfile"
  context = "."
  args = {
    JENKINS_VERSION = JENKINS_VERSION
    JENKINS_SHA = JENKINS_SHA
    PLUGIN_CLI_VERSION = PLUGIN_CLI_VERSION
  }
  tags = [
    "${REGISTRY}/${JENKINS_REPO}:jdk11-hotspot-windowsservercore-2019",
    equal(LATEST_WEEKLY, "true") ? "${REGISTRY}/${JENKINS_REPO}:windowsservercore-2019" : "",
    equal(LATEST_LTS, "true") ? "${REGISTRY}/${JENKINS_REPO}:lts-windowsservercore-2019" : "",
  ]
}
