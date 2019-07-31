#!/usr/bin/env bash

USAGE="\nUsage: $0\n
[-v|--verbose <bool>]\n
[-h|--help <bool>]\n
[--save]\n
[--access-token <string>]\n
[--report-run-id <int>]\n
[--granularity <string> hour|day]\n
"

usage() { echo -e $USAGE 1>&2; exit 1; }

# read the options
OPTS=`getopt -o vh --long verbose,help,access-token:,report-run-id:,granularity:,save -n 'fb_insights_api_get_reports.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage ; exit 1 ; fi
eval set -- "$OPTS"

VERBOSE=false
HELP=false
ACCESS_TOKEN=""
SAVE=false
REPORT_RUN_ID=0
OUTPUT_FILE=""
GRANULARITY=""

# extract options and their arguments into variables.
for i
do
  case "$i"
  in
    -h|--help)
      usage ;;
    -v|--verbose)
      VERBOSE=true ;
      shift ;;
    --access-token)
      ACCESS_TOKEN="$2" ;
      shift 2 ;;
    --report-run-id)
      REPORT_RUN_ID="$2" ;
      shift 2 ;;
    --granularity)
      GRANULARITY="$2" ;
      shift 2 ;;
    --save)
      SAVE=true ;
      shift ;;
  esac
done

if [ $REPORT_RUN_ID == 0 ]
  then
    echo "$0: Provide --report-run-id" ; usage ; exit 1
fi
if [ "$GRANULARITY" == "" ]
  then
    echo "$0: Provide --granularity" ; usage ; exit 1
fi

if [ ! -d "./_tmp" ]
  then
    mkdir ./_tmp/
fi

OUTPUT_FILE="./_tmp/report_$REPORT_RUN_ID.$GRANULARITY.json"
if [ -f $OUTPUT_FILE ]
  then
    rm $OUTPUT_FILE
fi

CURL_REQUEST="GET"
CURL_NEXT=""
PAGING_CURSOR_BEFORE=""
CONTINUE=true
PAGING_NEXT=""
while $CONTINUE; do
    source sources/curl_fb_insights_api_get_report.sh
    echo "$CURL_RESPONSE" | jq --compact-output '.data | .[]' >> $OUTPUT_FILE

    PAGING_NEXT=`jq '.paging | select(.next != null) | .next' <<< "$CURL_RESPONSE"`

    if [ -z "$PAGING_NEXT" ]; then
        CONTINUE=false
        continue
    fi

    PAGING_CURSOR_AFTER=`jq '.paging | .cursors | .after' <<< $CURL_RESPONSE`

    echo PAGING_CURSOR_AFTER=$PAGING_CURSOR_AFTER
    CURL_NEXT="--data \"after=$PAGING_CURSOR_AFTER\""
done

if [ -f $OUTPUT_FILE ]
  then
    stat -l $OUTPUT_FILE
fi
