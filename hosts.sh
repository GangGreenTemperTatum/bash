#!/usr/bin/env bash

set -e

HOSTS="${1:-/etc/hosts}"

add_hostname() {
    if ! grep -q $2 $HOSTS
    then
        echo "add_hostname: $1 $2"
        echo "$1 $2" >> $HOSTS
    fi
}

add_hostname "127.0.0.1" "localhost"
add_hostname "127.0.0.1" "etc"
add_hostname "127.0.0.1" "etc1"
add_hostname "127.0.0.1" "etc2"
add_hostname "127.0.0.1" "etc3"
