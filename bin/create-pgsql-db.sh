#!/usr/bin/env bash

export PGUSER=nexus
export PGPASSWORD=secret
export PGHOST=localhost

# http://stackoverflow.com/a/19399763/1244374

if [[ -z `psql -lqt | cut -d \| -f 1 | grep -w $1` ]]; then
    createdb -O nexus $1
fi