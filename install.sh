#!/bin/bash

#Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail

#Set script configuration
ANALIZO_VERSION='1.17.0'
DATABASE_TYPE='POSTGRESQL'
DATABASE_URL='jdbc:postgresql://localhost:5432'
DATABASE_USER='kalibro'
DATABASE_PASSWORD='kalibro'
WEBAPPS_DIR='/var/lib/tomcat6/webapps'
TOMCAT_HOME='/usr/share/tomcat6'
KALIBRO_TOMCAT_HOME="${TOMCAT_HOME}/.kalibro"
KALIBRO_DIR="${KALIBRO_TOMCAT_HOME}"

#Kalibro dependencies (including Analizo)-sudo touch /etc/apt/sources.list.d/analizo.list
sudo bash -c "echo \"deb http://analizo.org/download/ ./\" > /etc/apt/sources.list.d/analizo.list"
sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=${ANALIZO_VERSION} tomcat6 tomcat6-common libtomcat6-java postgresql unzip

sudo -u postgres psql --set ON_ERROR_STOP=1 < db_bootstrap.sql

# Kalibro

tmpdir=$(mktemp -d)
trap 'rm -rf "${tmpdir}"' EXIT

wget https://downloads.sourceforge.net/project/kalibrometrics/KalibroService.tar.gz \
-O "${tmpdir}/KalibroService.tar.gz"
cp "${tmpdir}/KalibroService.tar.gz" "/var/tmp/KalibroService.tar.gz"

tar -xzf "${tmpdir}/KalibroService.tar.gz" -C "${tmpdir}"

sudo mkdir -p ${KALIBRO_DIR}

for d in ${KALIBRO_DIR}/{projects,logs}; do
  ! [ -d "${d}" ] && sudo mkdir -p ${d}
done

sudo chown -R :tomcat6 ${KALIBRO_DIR}
sudo chmod 'g+s,a+r,ug+w,o-w' -R ${KALIBRO_DIR}

echo | sudo tee ${KALIBRO_DIR}/kalibro.settings <<EOF
serviceSide: SERVER
clientSettings:
  serviceAddress: "http://localhost:8080/KalibroService/"
serverSettings:
  loadDirectory: ${KALIBRO_TOMCAT_HOME}/projects
  databaseSettings:
    databaseType: postgresql
    jdbcUrl: "${DATABASE_URL}/kalibro"
    username: "${DATABASE_USER}"
    password: "${DATABASE_PASSWORD}"
EOF

echo | sudo tee ${KALIBRO_DIR}/kalibro_test.settings <<EOF
serviceSide: SERVER
clientSettings:
  serviceAddress: "http://localhost:8080/KalibroService/"
serverSettings:
  loadDirectory: ${KALIBRO_TOMCAT_HOME}/tests/projects
  databaseSettings:
    databaseType: ${DATABASE_TYPE}
    jdbcUrl: "${DATABASE_URL}/kalibro_test"
    username: "${DATABASE_USER}"
    password: "${DATABASE_PASSWORD}"
EOF

if [ ! -d "${WEBAPPS_DIR}" ]; then
  sudo mkdir ${WEBAPPS_DIR}
  sudo chown :tomcat6 ${WEBAPPS_DIR}
  sudo chmod 664 -R ${WEBAPPS_DIR}
  sudo chmod +x ${WEBAPPS_DIR}
fi

sudo cp "${tmpdir}/KalibroService/KalibroService.war" "${WEBAPPS_DIR}/"

#Imports sample configuration

#CURRENT_DIR=$(pwd)
#cd /var/lib/tomcat6/webapps/KalibroService/WEB-INF/lib
#java -classpath "*" org.kalibro.ImportConfiguration ${CURRENT_DIR}/KalibroService/configs/Configuration.yml http://localhost:8080/KalibroService/

sudo service tomcat6 restart
