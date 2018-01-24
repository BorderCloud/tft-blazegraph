FROM centos/systemd

MAINTAINER "Big DG" <dim.ger@gmail.com>

ARG JAVA_VERSION=1.8.0
ARG MAVEN_VERSION=3.3.9

ENV JAVA_HOME /usr/lib/jvm/java
ENV MAVEN_HOME /usr/share/maven

RUN yum update -y
RUN yum install -y java-$JAVA_VERSION-openjdk-devel git which

RUN mkdir -p $MAVEN_HOME /usr/share/maven/ref \
      && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
      | tar -xzC $MAVEN_HOME --strip-components=1 \
      && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

# INSTALL BLAZEGRAPH_RELEASE_2_0_0
WORKDIR /BLAZEGRAPH_RELEASE_2_0_0
RUN git clone -b BLAZEGRAPH_RELEASE_2_0_0 --single-branch https://github.com/blazegraph/database.git BLAZEGRAPH_RELEASE_2_0_0
RUN cd BLAZEGRAPH_RELEASE_2_0_0 && ./scripts/mavenInstall.sh
RUN echo "Install ok"

CMD ["./BLAZEGRAPH_RELEASE_2_0_0/scripts/startBlazegraph.sh"]

EXPOSE 9999
