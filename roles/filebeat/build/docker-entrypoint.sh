#!/bin/bash

set -e

# Add filebeat as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- /opt/filebeat/filebeat "$@"
fi

# Run as user "root" if the command is "filebeat"
if [ "$1" = 'filebeat' ]; then
	set -- gosu root "$@"
fi

exec "$@"
