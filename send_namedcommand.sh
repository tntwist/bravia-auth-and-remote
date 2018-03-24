#!/bin/sh

set -e

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
  echo "Usage of Sony Bravia IRCC Sender: $0 TV_IP IRCC_NAMED_COMMAND X-AUTH-PSK"
  exit 1
fi

available_commands=$(./print_ircc_codes.sh $1)
found_command=$( echo "$available_commands"  | grep -w -A 1 "$2" || :)

if [ "$found_command" = "" ]; then
	echo "No command with name $2 found."
	exit 1
fi

ircc_code=$(echo "$found_command" | grep "value" | sed 's/^ *//;s/ *$//' | tr -d '"' | sed 's/value: //')

cmd="<?xml version=\"1.0\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:X_SendIRCC xmlns:u=\"urn:schemas-sony-com:service:IRCC:1\"><IRCCCode>$ircc_code</IRCCCode></u:X_SendIRCC></s:Body></s:Envelope>"


code=$(curl -w "%{http_code}" --silent -XPOST http://$1/sony/IRCC -d "$cmd" -H 'Content-Type: text/xml; charset=UTF-8' -H 'SOAPACTION: "urn:schemas-sony-com:service:IRCC:1#X_SendIRCC"' -H "X-Auth-PSK: $3" -o /dev/null )

if [ "$code" = "200" ]; then
  echo "✓"
else
  echo "Command failed (HTTP_CODE: $code, try running it in a console)"
  exit 1
fi
