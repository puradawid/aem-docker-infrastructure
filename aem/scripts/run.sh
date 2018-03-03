#!/bin/bash
#
# This script configures the start information for this server.
#
# The following variables may be used to override the defaults.
# For one-time overrides the variable can be set as part of the command-line; e.g.,
#
#     % CQ_PORT=1234 ./start
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TCP port used for stop and status scripts
CQ_PORT=80

# hostname of the interface that this server should listen to
# CQ_HOST=

# show gui
CQ_GUI='false'

# do not show browser on startup
#CQ_NOBROWSER='true'

# do not redirect stdout/stderr (logs to console)
CQ_VERBOSE='false'

# do not fork the JVM
CQ_NOFORK='true'

# force forking the VM using recommended default memory settings
#CQ_FORK='true'

# additional arguments for the forked JVM
#CQ_FORKARGS=''

# runmode(s)
#CQ_RUNMODE=''

# defines the path under which the quickstart work folder is located
#CQ_BASEFOLDER=''

# low memory action
#CQ_LOWMEMACTION=''

# name of the jarfile
#CQ_JARFILE=''

# use jaas.config
# CQ_USE_JAAS='true'

# config for jaas
CQ_JAAS_CONFIG='etc/jaas.config'

# default JVM options
CQ_JVM_OPTS='-Xdebug -Dcom.sun.management.jmxremote.port=2000
  -Dcom.sun.management.jmxremote.authenticate=false
  -Dcom.sun.management.jmxremote.ssl=false
  -Xrunjdwp:transport=dt_socket,server=y,address=10000,suspend=n
  -server -Xmx2024m -XX:MaxPermSize=512M'

# file size limit (ulimit)
CQ_FILE_SIZE_LIMIT=8192

echo "Configuration for AEM instance done"

# source config file if provided
if [ -f $DIR/config ]; then
  echo "$DIR find config file"
  source $DIR/config
else
  echo "$DIR config file not found"
fi

# ------------------------------------------------------------------------------
# do not configure below this point
# ------------------------------------------------------------------------------

if [ $CQ_FILE_SIZE_LIMIT ]; then
	CURRENT_ULIMIT=`ulimit`
	if [ $CURRENT_ULIMIT != "unlimited" ]; then
		if [ $CURRENT_ULIMIT -lt $CQ_FILE_SIZE_LIMIT ]; then
			echo "ulimit ${CURRENT_ULIMIT} is too small (must be at least ${CQ_FILE_SIZE_LIMIT})"
			exit 1
		fi
	fi
fi

BIN_PATH=$(dirname $0)
cd $BIN_PATH/../..
START_OPTS='-use-control-port'
if [ $CQ_PORT ]; then
	START_OPTS="${START_OPTS} -p ${CQ_PORT}"
fi
if [ $CQ_GUI ]; then
	START_OPTS="${START_OPTS} -gui"
fi
if [ $CQ_NOBROWSER ]; then
	START_OPTS="${START_OPTS} -nobrowser"
fi
if [ $CQ_VERBOSE ]; then
	START_OPTS="${START_OPTS} -verbose"
fi
if [ $CQ_NOFORK ]; then
	START_OPTS="${START_OPTS} -nofork"
fi
if [ $CQ_FORK ]; then
	START_OPTS="${START_OPTS} -fork"
fi
if [ $CQ_FORKARGS ]; then
	START_OPTS="${START_OPTS} -forkargs ${CQ_FORKARGS}"
fi
if [ $CQ_RUNMODE ]; then
	START_OPTS="${START_OPTS} -r ${CQ_RUNMODE}"
fi
if [ $CQ_BASEFOLDER ]; then
	START_OPTS="${START_OPTS} -b ${CQ_BASEFOLDER}"
fi
if [ $CQ_LOWMEMACTION ]; then
	START_OPTS="${START_OPTS} -low-mem-action ${CQ_LOWMEMACTION}"
fi
if [ $CQ_HOST ]; then
    CQ_JVM_OPTS="${CQ_JVM_OPTS} -Dorg.apache.felix.http.host=${CQ_HOST}"
    START_OPTS="${START_OPTS} -a ${CQ_HOST}"
fi
if [ $CQ_USE_JAAS ]; then
    CQ_JVM_OPTS="${CQ_JVM_OPTS} -Djava.security.auth.login.config=${CQ_JAAS_CONFIG}"
fi
if [ -z $CQ_JARFILE ]; then
	CQ_JARFILE=`ls *.jar | head -1`
fi

if [ -z $JUST_TEST ]; then
  java $CQ_JVM_OPTS -jar $CQ_JARFILE $START_OPTS
else
  echo java $CQ_JVM_OPTS -jar $CQ_JARFILE $START_OPTS
fi
