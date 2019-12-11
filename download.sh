#!/usr/bin/env bash
set -e

ID=$1
DIR=${OUTDIR:-"/var/hls"}
MINUTES=${2:-10}
OPTIONS=${3:-'-d'}
TIMEOUT=$(echo  $MINUTES*60 | bc)
pipenv run -- ./hlsproxy.py $OPTIONS -o "$DIR/${ID::2}/$ID" "https://openwebinars.net/academia/hls/$ID.m3u8" &
echo "Process $! will be killed after $TIMEOUT seconds"
sleep $TIMEOUT && kill -15 $!
echo "Sended SIGTERM to $!"
