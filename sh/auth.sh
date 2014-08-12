#!/bin/sh
#-----------------------------------------------------------------
# run this script using command 
# $ . ./auth.sh 
# or
# $ source ./auth.sh 
# [to allow the script to set environment varibles]
#-----------------------------------------------------------------
curl -k -X 'POST' -v http://keystonec.library.ualberta.ca:5000/v2.0/tokens -d '{"auth":{"passwordCredentials":{"username": "admin", "password":"PB4di@CamLib210b"}, "tenantName":"demo"}}' -H 'Content-type: application/json' > auth.out.json
. ./jsonval.sh auth.out.json
echo done.