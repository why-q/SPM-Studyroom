FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# apt-get
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    netcat \
    lsof \
    gnupg2 \
    software-properties-common \
    maven \
    openjdk-8-jdk \
    gosu \
    sudo

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7B3B788A8D3785C

# Install MySQL 8.0
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.17-1_all.deb && \
    dpkg -i mysql-apt-config_0.8.17-1_all.deb && \
    apt-get update && \
    apt-get install -y mysql-community-server

EXPOSE 3306
ENV MYSQL_ROOT_PASSWORD=ye0401

# Move the bash
COPY reservation_demo.sql /docker-entrypoint-initdb.d/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy the source code and build the Spring Boot application
WORKDIR /app
COPY pom.xml .
COPY src ./src

# RUN mvn package -DskipTests

# Copy JAR
WORKDIR /app
COPY ./target/reserve_demo-0.0.1-SNAPSHOT.jar ./target/
RUN chmod +x /app/target/reserve_demo-0.0.1-SNAPSHOT.jar

# Expose the port the Spring Boot app runs on
EXPOSE 9099

ENTRYPOINT ["docker-entrypoint.sh"]

# CMD ["mysqld"]
