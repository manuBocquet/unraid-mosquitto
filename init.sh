#!/bin/sh

link () {
        source="$1"
        dest="$2"
        if [ -f "${source}" ] || [ -d "${source}" ] ; then
                if [ ! -e "${dest}" ] ; then
                        if [ -f "${source}" ]; then
                                rpath=$(dirname "${dest}")
                                if [ ! -d "${rpath}" ]; then
                                        mkdir -p "${rpath}"
                                fi
                        fi
                        mv "${source}" "${dest}"
                else
                        rm -rf "${source}"
                fi
        fi
        ln -s "${dest}" "${source}"
}

# config
link "/etc/mosquitto" "/config/etc/"

# /etc/syslog-ng/syslog-ng.conf
link "/etc/syslog-ng/syslog-ng.conf" "/config/etc/syslog-ng.conf"

mkdir -p /config/log

# Launch mosquito
exec /usr/local/sbin/mosquitto >/config/log/mosquitto.log 2>&1
