#!/bin/bash

url="https://hub.docker.com/v2/repositories/spikhalskiy/zerotier/tags/?page_size=25&page=1&ordering=last_updated"
key=".results"

function get_json_value()
{
  local json=$1
  local key=$2

  if [[ -z "$3" ]]; then
    local num=1
  else
    local num=$3
  fi

  local res=""
  for row in $(echo "${json}" | jq ${key} | jq -r '.[] | @base64'); do
  	_jq() {
    	echo ${row} | base64 --decode | jq -r ${1}
		}
    if [ $(_jq '.name') == "latest" ]; then
    	continue;
    fi
    res=$(_jq '.name')
    break;
	done
  echo ${res}
  return 200
}


COUNT=0
while (($COUNT < 5)); do
		RESP=$(curl -s ${url} )
    version=$(get_json_value  $RESP $key)
    if [[  -n "$version" ]]; then
        echo $version
        break
    else
        COUNT=$(( ${COUNT} + 1 ))
        sleep 1
        echo already waited ${COUNT} seconds...
    fi
done
