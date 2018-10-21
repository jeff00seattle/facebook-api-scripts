#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n
[--account-id <int>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,account-id: -n 'fb_marketing_api_ad_applications_all.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
ACCOUNT_ID=0
LIMIT=0
QUERY_STRING=""

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
    --limit)
      LIMIT="$2" ;
      shift 2 ;;
  esac
done

if [ $LIMIT == 0 ]
  then
      LIMIT=500 ;
      QUERY_STRING+="limit=$LIMIT&"
fi

if [ $VERBOSE = true ]
  then
    echo VERBOSE=$VERBOSE
    echo HELP=$HELP
    echo ACCESS_TOKEN=$ACCESS_TOKEN
    echo QUERY_STRING=$QUERY_STRING
fi

if [ -z "$ACCESS_TOKEN" ]
  then
    echo "$0: Provide --access-token" ; usage ; exit 1
fi

source sources/curl_fb_marketing_api_ad_accounts.sh

ACCOUNTS=`jq '.data' <<< $CURL_RESPONSE`
ACCOUNT_IDS=( $(jq '.[] | .account_id | tonumber' <<< $ACCOUNTS) )

for ACCOUNT_ID in "${ACCOUNT_IDS[@]}"
do
   APPLICATIONS=""
   APPS=""
   echo ACCOUNT_ID=$ACCOUNT_ID
   source sources/curl_fb_marketing_api_ad_applications.sh

   APPLICATIONS=`jq '.data' <<< $CURL_RESPONSE`
   APPS=( $(jq '.[]' <<< $APPLICATIONS) )

   for APP in "${APPS[@]}"
   do
       echo $APP
   done
done