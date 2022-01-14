FROM tomcat:9.0.56-jdk8-openjdk

ARG WAR_FILE
ARG CONTEXT

COPY tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
COPY tomcat-users.xsd /opt/tomcat/conf/tomcat-users.xsd
COPY context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml

COPY ${WAR_FILE} /usr/local/tomcat/webapps/${CONTEXT}.war