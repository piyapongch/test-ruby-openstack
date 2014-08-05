#!/bin/sh
# run this script using command . ./auth.sh or source ./auth.sh
# to allow the script to set environment varibles
curl -k -X 'POST' -v http://129.128.119.164:5000/v2.0/tokens -d '{"auth":{"passwordCredentials":{"username": "dptester", "password":"Pb-Ds4CamLib"}, "tenantName":"DPTest"}}' -H 'Content-type: application/json' > auth.out.json
. ./jsonval.sh auth.out.json
echo done.