#!/bin/bash

#Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail

ANALIZO_VERSION=1.18.0

#Kalibro dependencies (including Analizo)
sudo apt-get update
sudo apt-get install tomcat6 tomcat6-common libtomcat6-java postgresql doxyparse sloccount libgraph-perl liblist-compare-perl libtest-class-perl libtest-exception-perl libyaml-perl libstatistics-descriptive-perl libstatistics-online-perl ruby libclass-accessor-perl unzip
wget http://analizo.org/download/analizo_${ANALIZO_VERSION}_all.deb
sudo dpkg -i analizo_${ANALIZO_VERSION}_all.deb

sudo -u postgres psql < db_bootstrap.sql

#Kalibro
USER_HOME=$(eval echo ~${SUDO_USER})
wget https://downloads.sourceforge.net/project/kalibrometrics/KalibroService.tar.gz
tar -xzf KalibroService.tar.gz
mkdir ${USER_HOME}/.kalibro
mkdir ${USER_HOME}/.kalibro/projects
printf "serviceSide: SERVER\nclientSettings:\n  serviceAddress: \"http://localhost:8080/KalibroService/\"\nserverSettings:\n  loadDirectory: /usr/share/tomcat6/.kalibro/projects\n  databaseSettings:\n    databaseType: POSTGRESQL\n    jdbcUrl: \"jdbc:postgresql://localhost:5432/kalibro\"\n    username: \"kalibro\"\n    password: \"kalibro\"\n" >> ${USER_HOME}/.kalibro/kalibro.settings
printf "serviceSide: SERVER\nclientSettings:\n  serviceAddress: \"http://localhost:8080/KalibroService/\"\nserverSettings:\n  loadDirectory: /usr/share/tomcat6/.kalibro/tests/projects\n  databaseSettings:\n    databaseType: POSTGRESQL\n    jdbcUrl: \"jdbc:postgresql://localhost:5432/kalibro_test\"\n    username: \"kalibro\"\n    password: \"kalibro\"\n" >> ${USER_HOME}/.kalibro/kalibro_test.settings
sudo chmod 777 -R ${USER_HOME}/.kalibro
sudo ln -s ${USER_HOME}/.kalibro /usr/share/tomcat6/.kalibro
sudo mkdir /var/lib/tomcat6/webapps/KalibroService/
sudo unzip KalibroService/KalibroService.war -d /var/lib/tomcat6/webapps/KalibroService/

#Imports sample configuration
CURRENT_DIR=$(pwd)
cd /var/lib/tomcat6/webapps/KalibroService/WEB-INF/lib
java -classpath "*" org.kalibro.ImportConfiguration ${CURRENT_DIR}/KalibroService/configs/Configuration.yml http://localhost:8080/KalibroService/

sudo chmod 777 -R ${USER_HOME}/.kalibro
sudo service tomcat6 restart
