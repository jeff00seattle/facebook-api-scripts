#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n
[--account-id <int>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,account-id: -n 'fb_marketing_api_ad_applications.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
ACCOUNT_ID=0
LIMIT=0

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
    --account-id)
      ACCOUNT_ID="$2" ;
      shift 2 ;;
    --limit)
      LIMIT="$2" ;
      shift 2 ;;
  esac
done

if [ $LIMIT == 0 ]
  then
      LIMIT=500 ;
fi

if [ $VERBOSE = true ]
  then
    echo VERBOSE=$VERBOSE
    echo HELP=$HELP
    echo ACCESS_TOKEN=$ACCESS_TOKEN
    echo ACCOUNT_ID=$ACCOUNT_ID
fi

if [ $ACCOUNT_ID == 0 ]
  then
    echo "$0: Provide --account-id" ; usage ; exit 1
fi

if [ -z "$ACCESS_TOKEN" ]
  then
    echo "$0: Provide --access-token" ; usage ; exit 1
fi

if [ ! -d "./_tmp" ]
  then
    mkdir ./_tmp/
fi

OUTPUT_FILE="./_tmp/apps_$ACCOUNT_ID.json"
if [ -f $OUTPUT_FILE ]
  then
    rm $OUTPUT_FILE
fi

source sources/curl_fb_marketing_api_ad_applications.sh

APPLICATIONS=`jq '.data' <<< $CURL_RESPONSE`

APPS="["
APP_IDS=( $(jq '.[] | .id | tonumber' <<< $APPLICATIONS) )
for APP_ID in "${APP_IDS[@]}"
do
    source sources/curl_fb_marketing_api_ad_application.sh
    APP=`jq '.' <<< $CURL_RESPONSE`
    APPS+="$APP,"
done

if [ "${APPS: -1}" == "," ]
  then
    APPS="${APPS::-1}"
fi
APPS+="]"
echo "$APPS" >> $OUTPUT_FILE

if [ -f $OUTPUT_FILE ]
  then
    stat -l $OUTPUT_FILE
fi