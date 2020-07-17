# Use tomcat:latest base image
FROM tomcat:8.5-jre8

# Author
MAINTAINER CFMC <gtamanov@cfmc.ru>

# Information
LABEL version=1.0

# Update and upgrade the package repository(tomcat uses ubuntu base image)
# Upgrade operation also install Curl
RUN apt-get update && apt-get upgrade -y

# Install vim editor for editing files
RUN apt-get install vim -y

# Remove
RUN rm /usr/local/tomcat/webapps/host-manager/META-INF/context.xml && \
    rm /usr/local/tomcat/webapps/manager/META-INF/context.xml && \
    rm /usr/local/tomcat/conf/tomcat-users.xml && \
    rm /usr/local/tomcat/conf/context.xml

# Copy user-defined context.xml to allow global access for manager and host-manager
COPY /conf/context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY /conf/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Copy to conf
COPY /conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY /conf/context.xml /usr/local/tomcat/conf/context.xml