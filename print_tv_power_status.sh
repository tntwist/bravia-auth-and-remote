#!/bin/sh

set -e

cd $(dirname $0)

if [ "$1" = "" ]; then
  echo "Usage: $0 <TV_IP>"
  exit 1
fi

curl --silent -XPOST http://$1/sony/system -d '{"method":"getPowerStatus","params":[],"id":10,"version":"1.0"}'  | python -m json.tool | grep "status" | sed 's/^ *//;s/ *$//' | tr -d '"' | sed 's/status: //'
