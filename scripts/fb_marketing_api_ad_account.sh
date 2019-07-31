#!/usr/bin/env bash

#https://developers.facebook.com/docs/marketing-api/reference/ad-account

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--ad-account-id <int>]\n
[--access-token <string>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,ad-account-id: -n 'fb_marketing_api_ad_account.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
AD_ACCOUNT_ID=0
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
    --ad-account-id)
      AD_ACCOUNT_ID=$2 ;
      shift 2 ;;
    --access-token)
      ACCESS_TOKEN="$2" ;
      shift 2 ;;
  esac
done

if [ $VERBOSE = true ]
  then
    echo VERBOSE=$VERBOSE
    echo HELP=$HELP
    echo ACCESS_TOKEN=$ACCESS_TOKEN
    echo LIMIT=$LIMIT
fi

source sources/curl_fb_marketing_api_ad_account.sh

jq '.' <<< $CURL_RESPONSE 2>/dev/null