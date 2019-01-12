#!/bin/bash

# Because aliases are annoying

# TODO add quit subcommand, or maybe -q (--quit)

user="$ECS_USER"
host="$ECS_SERVER"

if [[ -z "$user" ]] || [[ -z "$host" ]]; then
    echo env var for username or host not set
    exit 1
fi

daemon_opts=""
ip_range="129.62.0.0/16"

numargs="$#"
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -a|--all)
            ip_range="0/0"
            ;;
        -d|--daemon)
            daemon_opts="--daemon"
            ;;
    esac

    numargs=$(( numargs - 1 ))
    shift
done

if [[ -n "$daemon_opts" ]]; then
    pidfile="$ECS_PIDFILE"
    if [[ -z "$pidfile" ]]; then
        pidfile="$( pwd )"/sshuttle.pid
        export ECS_PIDFILE="$pidfile"
    fi
    daemon_opts="$daemon_opts --pidfile=$pidfile"
fi

# Don't care to preserve empty strings here
sshuttle -r $user@$host $ip_range $daemon_opts

if [[ -n "$daemon_opts" ]]; then
    echo pid stored in $pidfile
fi
