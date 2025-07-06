# Use Java 18 base image
FROM eclipse-temurin:18-jdk

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and unzip Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.zip && \
    unzip apache-tomcat-10.1.7.zip && \
    rm apache-tomcat-10.1.7.zip && \
    mv apache-tomcat-10.1.7 /opt/tomcat

# ✅ Clean default webapps AFTER Tomcat is moved
RUN rm -rf /opt/tomcat/webapps/*

# ✅ Copy your WAR file to webapps
COPY ROOT.war /opt/tomcat/webapps/ROOT.war

# ✅ Optional: Check contents (for debug)
# RUN ls -la /opt/tomcat/webapps/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
