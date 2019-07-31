#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n
[--account-id <int>]\n
[--start-date <string>]\n
[--end-date <string>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,account-id:,start-date:,end-date: -n 'fb_insights_api_method_get_daily.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
ACCOUNT_ID=0
START_DATE=""
END_DATE=""

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
    --start-date)
      START_DATE="$2" ;
      shift 2 ;;
    --end-date)
      END_DATE="$2" ;
      shift 2 ;;
  esac
done

CURL_REQUEST="POST"
source sources/curl_fb_insights_api_method_get_daily.sh
jq '.' <<< $CURL_RESPONSE 2>/dev/null
