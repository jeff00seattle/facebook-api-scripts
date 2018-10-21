#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--access-token <string>]\n
[--report-run-id <int>]\n"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,report-run-id: -n 'fb_insights_api_get_report_status.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
REPORT_RUN_ID=0

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
    --report-run-id)
      REPORT_RUN_ID="$2" ;
      shift 2 ;;
  esac
done

CURL_REQUEST="GET"
source sources/curl_fb_insights_api_get_report_status.sh
jq '.' <<< $CURL_RESPONSE 2>/dev/null