#!/bin/sh
#
# caddy server

. /etc/service.subr

prog_dir="$(dirname "$(realpath "$0")")"

name="caddy"
version="2.4.6"
description="The Ultimate Server with Automatic HTTPS"
pidfile="/tmp/DroboApps/${name}/pid.txt"
logfile="/tmp/DroboApps/${name}/log.txt"
conffile=${prog_dir}/etc/Caddyfile
framework_version="2.1"
depends=""
webui=""

start()
{
  if [ ! -f $conffile ]; then
    cp ${conffile}.default ${conffile} > /dev/null 2>&1
  fi

  ./bin/caddy start --config=${conffile} --pidfile ${pidfile} >> ${logfile} 2>&1
}

_stop_service() {
  ./bin/caddy stop
  stop_service
}

case "$1" in
start)
        start_service
        ;;
stop)
        _stop_service
        ;;
restart)
        _stop_service
        sleep 3
        start_service
        ;;
status)
        status
        ;;
*)
        echo "Usage: $0 [start|stop|restart|status]"
        exit 1
        ;;
esac
