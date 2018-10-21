#!/usr/bin/env bash

if [ $ACCOUNT_ID == 0 ]
  then
    echo "$0: Provide --account-id" ; usage ; exit 1
fi

if [ -z "$ACCESS_TOKEN" ]
  then
    echo "$0: Provide --access-token" ; usage ; exit 1
fi


if [ -z "$START_DATE" ]
  then
    echo "$0: Provide --start-date" ; usage ; exit 1
fi

if [ -z "$END_DATE" ]
  then
    echo "$0: Provide --end-date" ; usage ; exit 1
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

source ../../../scripts/sources/url_encode.sh

source sources/fb_graph_api_base.sh
if [ -z "$FB_API_VERSION" ]
  then
    echo "$0: Failed to define FB_API_VERSION"
    exit 2
fi

BREAKDOWNS=`urlencode "['hourly_stats_aggregated_by_advertiser_time_zone']"`
ACTION_BREAKDOWNS=`urlencode "['action_type','action_target_id']"`

ACTION_ATTRIBUTION_WINDOWS=`urlencode "['default']"`
TIME_RANGE=`urlencode "{'since':'$START_DATE','until':'$END_DATE'}"`

# https://developers.facebook.com/docs/marketing-api/insights/fields/v2.12

FIELDS=""
#FIELDS+="account_currency"
FIELDS+="account_id"
#FIELDS+=",account_name"
#FIELDS+=",action_values"
#FIELDS+=",actions"
#FIELDS+=",ad_id"
#FIELDS+=",ad_name"
#FIELDS+=",adset_id"
#FIELDS+=",adset_name"
FIELDS+=",campaign_id"
#FIELDS+=",campaign_name"
FIELDS+=",clicks"
#FIELDS+=",cpc"
#FIELDS+=",cpm"
#FIELDS+=",cpp"
#FIELDS+=",ctr"
#FIELDS+=",date_start"
#FIELDS+=",date_stop"
#FIELDS+=",frequency"
FIELDS+=",impressions"
#FIELDS+=",inline_link_click_ctr"
#FIELDS+=",inline_link_clicks"
#FIELDS+=",inline_post_engagement"
#FIELDS+=",mobile_app_purchase_roas"
#FIELDS+=",objective"
#FIELDS+=",outbound_clicks"
#FIELDS+=",outbound_clicks_ctr"
FIELDS+=",reach"
#FIELDS+=",social_clicks"
#FIELDS+=",social_impressions"
#FIELDS+=",social_reach"
#FIELDS+=",social_spend"
#FIELDS+=",spend"
#FIELDS+=",total_action_value"
#FIELDS+=",total_actions"
#FIELDS+=",total_unique_actions"
FIELDS+=",unique_actions"
FIELDS+=",unique_clicks"
FIELDS+=",unique_ctr"
#FIELDS+=",unique_inline_link_click_ctr"
#FIELDS+=",unique_link_clicks_ctr"
#FIELDS+=",unique_outbound_clicks"
#FIELDS+=",unique_outbound_clicks_ctr"
#FIELDS+=",unique_social_clicks"
#FIELDS+=",video_p100_watched_actions"

CURL_CMD="curl \"https://graph.facebook.com/$FB_API_VERSION/act_$ACCOUNT_ID/insights\"
  --request $CURL_REQUEST
  $CURL_VERBOSE \
  --header \"Content-Type: application/json\"
  --connect-timeout 60
  --location
  --get
  --data \"access_token=$ACCESS_TOKEN\"
  --data \"action_attribution_windows=$ACTION_ATTRIBUTION_WINDOWS\"
  --data \"fields=$FIELDS\"
  --data \"action_report_time=impression\"
  --data \"include_headers=false\"
  --data \"level=ad\"
  --data \"limit=5000\"
  --data \"locale=en_US\"
  --data \"method=get\"
  --data \"pretty=0\"
  --data \"suppress_http_code=1\"
  --data \"time_range=$TIME_RANGE\"
  --data \"action_breakdowns=$ACTION_BREAKDOWNS\"
"

if [ $VERBOSE = true ]
  then
    echo CURL_CMD=$CURL_CMD
fi

CURL_RESPONSE=$(eval $CURL_CMD)