#!/usr/bin/env bash

CONFIG="server {
    listen 80;

    ###
    # Server
    ###

    server_name $1;
    root        $2;
    charset     utf-8;
    index       index.html index.php index.hh;
    sendfile    off;

    ###
    # Logging
    ###

    access_log off;
    error_log  /var/log/nginx/$1-error.log error;

    ###
    # Routing
    ###

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        log_not_found off;
        access_log off;
    }

    location ~ \.(hh|php)$ {
        fastcgi_keep_conn on;
        #fastcgi_pass               127.0.0.1:9000;
        fastcgi_pass                unix:/var/run/hhvm/hhvm.sock;
        fastcgi_index               index.php;
        fastcgi_param               SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_intercept_errors    off;
        fastcgi_buffer_size         16k;
        fastcgi_buffers             4 16k;
        include fastcgi_env_vars;
    }

    location ~ /\.ht {
        deny all;
    }

    ###
    # Errors
    ###

    error_page 404 /index.php;
}"

echo "$CONFIG" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"