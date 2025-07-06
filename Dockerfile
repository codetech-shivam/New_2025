# ✅ Base image: Java 18
FROM eclipse-temurin:18-jdk

# ✅ Install wget + unzip
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# ✅ Download and extract Tomcat 10.1.7 from the official archive
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.zip && \
    unzip apache-tomcat-10.1.7.zip && \
    mv apache-tomcat-10.1.7 /opt/tomcat && \
    rm apache-tomcat-10.1.7.zip

# ✅ Remove Tomcat default apps
RUN rm -rf /opt/tomcat/webapps/*

# ✅ Copy your app
COPY ROOT.war /opt/tomcat/webapps/ROOT.warS

# ✅ Make sure Tomcat runs on port 8080
EXPOSE 8080

# ✅ Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
