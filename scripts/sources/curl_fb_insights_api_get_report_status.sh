#!/usr/bin/env bash

if [ $REPORT_RUN_ID == 0 ]
  then
    echo "$0: Provide --report-run-id" ; usage ; exit 1
fi

if [ -z "$ACCESS_TOKEN" ]
  then
    echo "$0: Provide --access-token" ; usage ; exit 1
fi

if [ -z "$CURL_REQUEST" ]
  then
    CURL_REQUEST="GET"
fi

CURL_VERBOSE=""
if [ $VERBOSE = true ]
  then
    CURL_VERBOSE=" --verbose"
fi

source sources/fb_graph_api_base.sh
if [ -z "$FB_API_VERSION" ]
  then
    echo "$0: Failed to define FB_API_VERSION"
    exit 2
fi

CURL_CMD="curl \"https://graph.facebook.com/$FB_API_VERSION/$REPORT_RUN_ID\"
  --request $CURL_REQUEST
  $CURL_VERBOSE \
  --header \"Content-Type: application/json\"
  --connect-timeout 60
  --location
  --get
  --data \"access_token=$ACCESS_TOKEN\"
"

if [ $VERBOSE = true ]
  then
    echo CURL_CMD=$CURL_CMD
fi

CURL_RESPONSE=$(eval $CURL_CMD)