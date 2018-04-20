#!/usr/bin/env bash

#
# Example how to deploy a DNS challenge using nsupdate
#

set -x

set -e
set -u
set -o pipefail

NSUPDATE="knsupdate -d -k /etc/letsencrypt/scripts/knot.key"
DNSSERVER="172.21.10"
TTL=10

case "$1" in
    "deploy_challenge")
        #printf "server %s\nupdate add _acme-challenge.%s. %d in TXT \"%s\"\nsend\n" "${DNSSERVER}" "${2}" "${TTL}" "${4}" | $NSUPDATE
        echo -e "server $DNSSERVER\nzone "${2}"\nupdate add _acme-challenge."${2}" $TTL in TXT "${4}"\nsend" | $NSUPDATE
        ;;
    "clean_challenge")
        echo -e "server $DNSSERVER\nzone "${2}"\nupdate delete _acme-challenge."${2}" $TTL in TXT "${4}"\nsend" | $NSUPDATE
        ;;
    "deploy_cert")
        # optional:
        # /path/to/deploy_cert.sh "$@"
        ;;
    "unchanged_cert")
        # do nothing for now
        ;;
    "startup_hook")
        # do nothing for now
        ;;
    "exit_hook")
        # do nothing for now
        ;;
esac

exit 0
