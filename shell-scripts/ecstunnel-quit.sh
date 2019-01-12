#!/bin/bash

DEFAULT_PIDFILE=sshuttle.pid
pidfile="$ECS_PIDFILE"

if [[ -z "$pidfile" ]]; then
    if [[ -f "$DEFAULT_PIDFILE" ]]; then
        pidfile="$DEFAULT_PIDFILE" 
    else
        echo sshuttle pidfile not found
        exit 1
    fi
fi

sudo kill -s KILL $( cat "$pidfile" )
rm "$pidfile"
