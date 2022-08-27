#!/bin/bash

while getopts i:s:g:U:S:u:p:h flag
  do
    case "${flag}" in
      i) client_id=${OPTARG};;
      s) client_secret=${OPTARG};;
      g) grant_type=${OPTARG};;
      U) url=${OPTARG};;
      S) scope=${OPTARG};;
      u) username=${OPTARG};;
      p) password=${OPTARG};;
    esac
  done

data1="client_id=${client_id}"
data2="client_secret=${client_secret}"
data3="grant_type=${grant_type}"
data4="scope=${scope}"
data5="username=${username}"
data6="password=${password}"

response=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d $data1 -d $data2 -d $data3 -d $data4 -d $data5 -d $data6 $url)
access_token=$(echo ${response} | grep -o '"access_token": *"[^"]*"' | grep -o '"[^"]*"$' | tr -d '"')

if [ -z "$access_token" ]
then
        echo $response
else
        echo $access_token
fi
