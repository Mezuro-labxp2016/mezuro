#!/bin/bash

#Kalibro dependencies (including Analizo)
sudo touch /etc/apt/sources.list.d/analizo.list
sudo bash -c "echo \"deb http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install openjdk-7-jdk postgresql doxyparse sloccount libgraph-perl liblist-compare-perl libtest-class-perl libtest-exception-perl libyaml-perl libstatistics-descriptive-perl libstatistics-online-perl ruby libclass-accessor-perl unzip
wget http://analizo.org/download/analizo_1.16.0_all.deb
sudo dpkg -i analizo_1.16.0_all.deb

sudo -u postgres psql < db_bootstrap.sql

#Kalibro user set up
useradd -m -U -s /bin/bash kalibro
sudo su kalibro
USER_HOME=$(eval echo ~${SUDO_USER})

#JBoss Web
http://downloads.jboss.org/jbossweb/2.1.9.GA/jboss-web-2.1.9.GA.tar.gz
tar -xzf jboss-web-2.1.9.GA.tar.gz
cd jboss-web-2.1.9.GA
http://downloads.jboss.org/jbossnative//2.0.10.GA/jboss-native-2.0.10-linux2-i64-ssl.tar.gz
tar -xzf jboss-native-2.0.10-linux2-i64-ssl.tar.gz
cd ..

#Kalibro

wget https://downloads.sourceforge.net/project/kalibrometrics/KalibroService.tar.gz
tar -xzf KalibroService.tar.gz
mkdir ${USER_HOME}/.kalibro
mkdir ${USER_HOME}/.kalibro/projects
printf "serviceSide: SERVER\nclientSettings:\n  serviceAddress: \"http://localhost:8080/KalibroService/\"\nserverSettings:\n  loadDirectory: /usr/share/tomcat6/.kalibro/projects\n  databaseSettings:\n    databaseType: POSTGRESQL\n    jdbcUrl: \"jdbc:postgresql://localhost:5432/kalibro\"\n    username: \"kalibro\"\n    password: \"kalibro\"\n" >> ${USER_HOME}/.kalibro/kalibro.settings
printf "serviceSide: SERVER\nclientSettings:\n  serviceAddress: \"http://localhost:8080/KalibroService/\"\nserverSettings:\n  loadDirectory: /usr/share/tomcat6/.kalibro/tests/projects\n  databaseSettings:\n    databaseType: POSTGRESQL\n    jdbcUrl: \"jdbc:postgresql://localhost:5432/kalibro_test\"\n    username: \"kalibro\"\n    password: \"kalibro\"\n" >> ${USER_HOME}/.kalibro/kalibro_test.settings
sudo chmod 777 -R ${USER_HOME}/.kalibro
sudo mkdir ${USER_HOME}/jboss-web-2.1.9.GA/webapps/KalibroService/
sudo unzip KalibroService/KalibroService.war -d ${USER_HOME}/jboss-web-2.1.9.GA/webapps/KalibroService/
./${USER_HOME}/jboss-web-2.1.9.GA/bin/startup.sh

#Imports sample configuration
CURRENT_DIR=$(pwd)
cd ${USER_HOME}/jboss-web-2.1.9.GA/webapps/KalibroService/WEB-INF/lib
java -classpath "*" org.kalibro.ImportConfiguration ${CURRENT_DIR}/KalibroService/configs/Configuration.yml http://localhost:8080/KalibroService/

sudo chmod 777 -R ${USER_HOME}/.kalibro
./${USER_HOME}/jboss-web-2.1.9.GA/bin/startup.sh
./${USER_HOME}/jboss-web-2.1.9.GA/bin/shutdown.sh