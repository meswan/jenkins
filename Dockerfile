FROM jenkins/jenkins:lts

USER root

ENV DOCKERVERSION=18.03.1-ce
ENV PATH="/usr/local/bin/gradle/gradle-6.1.1/bin:/usr/local/bin/maven/apache-maven-3.6.3/bin:${PATH}"

RUN mkdir -p /usr/local/bin/maven
RUN mkdir -p /usr/local/bin/gradle

RUN curl -fsSLO http://apache.forsale.plus/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
  && tar -xf apache-maven-3.6.3-bin.tar.gz -C /usr/local/bin/maven \
  && rm apache-maven-3.6.3-bin.tar.gz

RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN curl -fsSLO https://services.gradle.org/distributions/gradle-6.1.1-bin.zip \
    && unzip -d /usr/local/bin/gradle gradle-6.1.1-bin.zip && rm gradle-6.1.1-bin.zip
