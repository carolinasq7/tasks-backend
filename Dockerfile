FROM tomcat:9.0.98-jdk11-corretto

ARG WAR_FILE
ARG CONTEXT

COPY ${WAR_FILE} /usr/local/tomcat/webapps/${CONTEXT}.war