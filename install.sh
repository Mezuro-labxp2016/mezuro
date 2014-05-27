#!/bin/bash
# Script to install Kalibro Service and dependencies on Ubuntu 12.04.
# It may work on Debian 6 but this is untested.
#
# This script assumes a sane enviroment with at least the following
# depedencies already installed and configured:
# 	-sudo
#	-wget
#	-tar
#	-coreutils

# Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail
IFS=$'\n\t'

# Set script configuration
ANALIZO_VERSION='1.17.0' # Version >1.17.0 needs Ubuntu 13.10/Debian 7
KALIBRO_DOWNLOAD_URL='https://downloads.sourceforge.net/project/kalibrometrics/KalibroService.tar.gz'
DATABASE_TYPE='POSTGRESQL'
DATABASE_URL='jdbc:postgresql://localhost:5432'
DATABASE_USER='kalibro'
DATABASE_PASSWORD='kalibro'
WEBAPPS_DIR='/var/lib/tomcat6/webapps'
TOMCAT_HOME='/usr/share/tomcat6'
KALIBRO_SERVICE_DIR="${WEBAPPS_DIR}/KalibroService"
KALIBRO_SERVICE_URL='http://localhost:8080/KalibroService/'
KALIBRO_HOME="${HOME}/.kalibro"

# Kalibro dependencies (including Analizo)
sudo bash -c "echo \"deb http://analizo.org/download/ ./\" > /etc/apt/sources.list.d/analizo.list"
sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=${ANALIZO_VERSION} tomcat6 tomcat6-common libtomcat6-java postgresql unzip
# Add Kalibro database configuration to PostgresSQL
sudo -u postgres psql --set ON_ERROR_STOP=1 < db_bootstrap.sql

# Kalibro installation
# Create temporary directory
tmpdir=$(mktemp -d)
# Clean up temporary directory on exit
function clean_up {
	rm -rf "${tmpdir}"
}
trap clean_up EXIT

# Download Kalibro
wget "${KALIBRO_DOWNLOAD_URL}" -O "${tmpdir}/KalibroService.tar.gz"

# Untar Kalibro
tar -xzf "${tmpdir}/KalibroService.tar.gz" -C "${tmpdir}"

# Create Kalibro directory structure on Home dir
mkdir -p ${KALIBRO_HOME}
for d in ${KALIBRO_HOME}/{projects,logs}; do
  ! [ -d "${d}" ] && mkdir -p ${d}
done

# Make tomcat6 user owner of Kalibro dir
sudo chown -R :tomcat6 ${KALIBRO_HOME}
sudo chmod 'g+s,a+r,ug+w,o-w' -R ${KALIBRO_HOME}

# Add Kalibro Service settings to Home
echo | tee ${KALIBRO_HOME}/kalibro.settings <<EOF
serviceSide: SERVER
clientSettings:
  serviceAddress: "http://localhost:8080/KalibroService/"
serverSettings:
  loadDirectory: ${KALIBRO_HOME}/projects
  databaseSettings:
    databaseType: postgresql
    jdbcUrl: "${DATABASE_URL}/kalibro"
    username: "${DATABASE_USER}"
    password: "${DATABASE_PASSWORD}"
EOF
echo | tee ${KALIBRO_HOME}/kalibro_test.settings <<EOF
serviceSide: SERVER
clientSettings:
  serviceAddress: "http://localhost:8080/KalibroService/"
serverSettings:
  loadDirectory: ${KALIBRO_HOME}/tests/projects
  databaseSettings:
    databaseType: ${DATABASE_TYPE}
    jdbcUrl: "${DATABASE_URL}/kalibro_test"
    username: "${DATABASE_USER}"
    password: "${DATABASE_PASSWORD}"
EOF

# Link Kalibro configuration to Tomcat
sudo ln -sf ${KALIBRO_HOME} ${TOMCAT_HOME}/.kalibro

# If Tomcat webapps dir doesn't exist, create it
if [ ! -d "${WEBAPPS_DIR}" ]; then
  sudo mkdir ${WEBAPPS_DIR}
  sudo chown :tomcat6 ${WEBAPPS_DIR}
  sudo chmod 664 -R ${WEBAPPS_DIR}
  sudo chmod +x ${WEBAPPS_DIR}
fi

# Install Kalibro Service application on Tomcat
sudo mkdir -p "${KALIBRO_SERVICE_DIR}"
sudo unzip "${tmpdir}/KalibroService/KalibroService.war" -d "${KALIBRO_SERVICE_DIR}"

# Imports sample configuration
pushd "${KALIBRO_SERVICE_DIR}/WEB-INF/lib"
java -classpath "*" org.kalibro.ImportConfiguration "${tmpdir}/KalibroService/configs/Configuration.yml" "${KALIBRO_SERVICE_URL}"
popd

# Restart Tomcat to start Kalibro Service
sudo service tomcat6 restart
