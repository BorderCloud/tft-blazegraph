FROM centos/systemd

MAINTAINER "Karima Rafes" <karima.rafes@gmail.com>

#update the server
RUN yum -y update; yum clean all;

# Java
ARG JAVA_VERSION=1.8.0
RUN yum install -y java-$JAVA_VERSION-openjdk-devel git which
ENV JAVA_HOME /usr/lib/jvm/java

# Maven
ARG MAVEN_VERSION=3.3.9
ENV MAVEN_HOME /usr/share/maven
RUN mkdir -p $MAVEN_HOME /usr/share/maven/ref \
      && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
      | tar -xzC $MAVEN_HOME --strip-components=1 \
      && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

RUN git clone  --depth 1 -b BLAZEGRAPH_RELEASE_2_0_0 --single-branch https://github.com/blazegraph/database.git /opt/blazegraph \
    && cd /opt/blazegraph \
    && ./scripts/mavenInstall.sh

COPY startBlazegraphConfigTest.sh /opt/blazegraph/scripts
RUN chmod +x /opt/blazegraph/scripts/startBlazegraphConfigTest.sh
COPY blazegraph.service /etc/systemd/system
RUN systemctl enable blazegraph

#CMD ["./BLAZEGRAPH_RELEASE_2_0_0/scripts/startBlazegraph.sh"]
#EXPOSE 9999

#AEFFACER 10 ok

#COPY load.sh /opt/apache-jena-fuseki-3.6.0
#COPY jena.service /etc/systemd/system

#RUN mkdir /opt/apache-jena-fuseki-3.6.0/run
#COPY shiro.ini /opt/apache-jena-fuseki-3.6.0/run

#RUN chmod +x /opt/apache-jena-fuseki-3.6.0/load.sh

#RUN systemctl enable jena

EXPOSE 80
CMD ["/usr/sbin/init"]
