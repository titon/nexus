#!/usr/bin/env bash

mysql -unexus -psecret -e "CREATE DATABASE IF NOT EXISTS $1;";