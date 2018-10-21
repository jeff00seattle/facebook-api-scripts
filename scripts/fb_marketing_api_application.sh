#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n
[--app-id <int>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,app-id: -n 'fb_marketing_api_application.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
APP_ID=0


# extract options and their arguments into variables.
for i
do
  case "$i"
  in
    -v|--verbose)
      VERBOSE=true ;
      shift ;;
    -h|--help)
      usage ;;
    --access-token)
      ACCESS_TOKEN="$2" ;
      shift 2 ;;
    --app-id)
      APP_ID="$2" ;
      shift 2 ;;
  esac
done


if [ $VERBOSE = true ]
  then
    echo VERBOSE=$VERBOSE
    echo HELP=$HELP
    echo ACCESS_TOKEN=$ACCESS_TOKEN
    echo APP_ID=$APP_ID
    echo QUERY_STRING=$QUERY_STRING
fi

if [ $APP_ID == 0 ]
  then
    echo "$0: Provide --app-id" ; usage ; exit 1
fi

if [ -z "$ACCESS_TOKEN" ]
  then
    echo "$0: Provide --access-token" ; usage ; exit 1
fi

source sources/curl_fb_marketing_api_ad_application.sh
jq '.' <<< $CURL_RESPONSE 2>/dev/null