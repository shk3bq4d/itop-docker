#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
## Author: Jeff Malone, 20 Mar 2023
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

version() {
    grep -Po '(?<=^ARG ITOP_VERSION=)(\S+)' $DIR/base/Dockerfile
}

localtag() {
    echo itop:$(version)
}


remotetag() {
    echo shk3bq4d/$(localtag)
}

cd $DIR/base

docker ps &>/dev/null && SUDO="" || SUDO="sudo";
$SUDO docker build -t $(localtag) -t $(remotetag) .
$SUDO docker push $(remotetag)


echo EOF
exit 0

