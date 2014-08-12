#!/bin/sh
curl -v -X GET -H "X-Auth-Token: $TOKEN" $URL/$1
