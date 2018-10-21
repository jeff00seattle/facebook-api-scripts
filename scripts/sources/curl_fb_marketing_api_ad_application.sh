#!/usr/bin/env bash

if [ $APP_ID == 0 ]
  then
    echo "$0: Provide --app-id" ; usage ; exit 1
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

FIELDS=""
FIELDS+="id"
FIELDS+=",an_ad_space_limit"
FIELDS+=",an_platforms"
FIELDS+=",app_ad_debug_info"
FIELDS+=",app_domains"
FIELDS+=",app_install_tracked"
FIELDS+=",app_name"
FIELDS+=",app_type"
FIELDS+=",business"
FIELDS+=",category"
FIELDS+=",client_config"
FIELDS+=",company"
FIELDS+=",configured_ios_sso"
FIELDS+=",context"
FIELDS+=",creator_uid"
FIELDS+=",default_share_mode"
FIELDS+=",description"
FIELDS+=",ios_bundle_id"
FIELDS+=",ipad_app_store_id"
FIELDS+=",iphone_app_store_id"
FIELDS+=",link"
FIELDS+=",name"
FIELDS+=",object_store_urls"
FIELDS+=",subcategory"
FIELDS+=",supported_platforms"


CURL_CMD="curl \"https://graph.facebook.com/$FB_API_VERSION/$APP_ID\"
  --request $CURL_REQUEST
  $CURL_VERBOSE
  --header \"Content-Type: application/json\"
  --connect-timeout 60
  --location
  --get
  --data \"access_token=$ACCESS_TOKEN\"
  --data \"fields=$FIELDS\"
"

if [ $VERBOSE = true ]
  then
    echo CURL_CMD=$CURL_CMD
fi

CURL_RESPONSE=$(eval $CURL_CMD)
