
# Use Java 18 base image
FROM eclipse-temurin:18-jdk

# Install dependencies to download and unzip Tomcat
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and unzip Apache Tomcat 10.1.24
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.zip && \
    unzip apache-tomcat-10.1.24.zip && \
    mv apache-tomcat-10.1.24 /opt/tomcat && \
    rm apache-tomcat-10.1.24.zip

# Clean default webapps
RUN rm -rf /opt/tomcat/webapps/*

# Copy your WAR file to Tomcat's webapps as ROOT.war
COPY ROOT.war /opt/tomcat/webapps/ROOT.war

# Expose port 8080 (Tomcat default)
EXPOSE 8080

# Start Tomcat server
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
