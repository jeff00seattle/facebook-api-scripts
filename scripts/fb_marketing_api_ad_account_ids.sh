#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,limit: -n 'fb_marketing_api_ad_account_ids.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
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
    --limit)
      LIMIT="$2" ;
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

source sources/curl_fb_marketing_api_ad_accounts.sh

ACCOUNTS=`jq '.data' <<< $CURL_RESPONSE`
ACCOUNT_IDS=( $( jq '.[] | .account_id | tonumber' <<< $ACCOUNTS ) )
ACCOUNT_IDS_SORTED=( $( printf "%s\n" "${ACCOUNT_IDS[@]}" | sort -n ) )

COUNTER=0
echo '====================================='
for ACCOUNT_ID in "${ACCOUNT_IDS_SORTED[@]}"
do
   COUNTER=$[$COUNTER +1]
   echo $ACCOUNT_ID
done
echo '====================================='
echo ACCOUNT_IDS_COUNT=$COUNTER
echo '====================================='