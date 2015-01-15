#!/usr/bin/env bash

sudo -i -u postgres

if psql -lqt | cut -d \| -f 1 | grep -w $1; then
    # DB exists
else
    createdb -O nexus $1
fi