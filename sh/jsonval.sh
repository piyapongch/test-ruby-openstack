#!/bin/sh
# parse json data and get property values
function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w -m 1 $prop`
    echo ${temp##*|}
}

# find token
json=`cat $1`
# set property name
prop='id'
#echo `jsonval`
eval id=(`jsonval`)
TOKEN=${id[1]}

# find url
# set property name
prop='internalURL'
#echo `jsonval`
eval url=(`jsonval`)
URL=${url[1]}

export TOKEN URL
echo TOKEN: $TOKEN
echo URL: $URL

