# cost/facebook_ads Scripts

These are bash scripts for querying the [Facebook Graph API](https://developers.facebook.com/docs/graph-api/).

## [Facebook Marketing API: Ad Accounts](https://developers.facebook.com/docs/graph-api/reference/user/adaccounts/)

```bash
./fb_marketing_api_ad_account_ids.sh --access-token '[REDACTED]'
```

```json
304100896716457
304103650049515
551150118378311

10155658451638372
10155658452123372
10155658452633372
10155658453093372
ACCOUNT_IDS_COUNT=122
```

## [Facebook Marketing API: Ad Account Advertisable Applications](https://developers.facebook.com/docs/marketing-api/reference/ad-account/advertisable_applications/)

### `./fb_marketing_api_ad_applications.sh`

```bash
./fb_marketing_api_ad_applications.sh --access-token '[REDACTED]' --account-id 513503292368998
```

```json
{
  "id": "117217775074755",
  "an_ad_space_limit": 4,
  "app_ad_debug_info": {
    "last_ios_install": "2018-01-17T23:28:57+0000",
    "last_android_install": "2017-08-14T21:09:00+0000",
    "ios_support_status": "YES",
    "android_support_status": "NO",
    "ios_installs_over_last_seven_days": 448,
    "android_installs_over_last_seven_days": 0,
    "ios_install_invalidation_schemes": [
      "fb117217775074755://",
      "adblite://",
      "fb569841383172272://",
      "makemoney://"
    ],
    "is_ocpm_enabled": true,
    "is_app_in_dev_mode": false,
    "is_app_child_app": false
  },
  "app_install_tracked": true,
  "business": {
    "id": "118941212034253",
    "name": "TUNE"
  },
  "category": "Entertainment",
  "context": {
    "id": "YXBwbGljYXRpb25fY29udGV4dDoxMTcyMTc3NzUwNzQ3NTUZD"
  },
  "default_share_mode": "share_sheet",
  "link": "https://www.facebook.com/games/?app_id=117217775074755",
  "name": "Atomic Dodge Ball Lite",
  "object_store_urls": {
    "itunes": "https://itunes.apple.com/app/id550854415"
  },
  "subcategory": "Other",
  "supported_platforms": [
    "IPHONE"
  ]
}

{
  "id": "469021223155888",
  "an_ad_space_limit": 4,
  "app_ad_debug_info": {
    "last_ios_install": "2013-07-16T22:56:24+0000",
    "last_android_install": "2018-01-17T21:12:06+0000",
    "ios_support_status": "NO",
    "android_support_status": "YES",
    "ios_installs_over_last_seven_days": 0,
    "android_installs_over_last_seven_days": 144,
    "last_ios_deferred_deep_link_call": "2018-01-15T02:39:55+0000",
    "last_android_deferred_deep_link_call": "2018-01-18T00:04:16+0000",
    "is_ocpm_enabled": true,
    "is_app_in_dev_mode": false,
    "is_app_child_app": false
  },
  "app_install_tracked": true,
  "category": "Entertainment",
  "context": {
    "id": "YXBwbGljYXRpb25fY29udGV4dDo0NjkwMjEyMjMxNTU4ODgZD"
  },
  "default_share_mode": "share_sheet",
  "description": "Meet new friends with Hello Chatty. We pick a random user for you to chat with one on one. ",
  "link": "http://hellochatty.co/",
  "name": "Hello Chatty",
  "object_store_urls": {
    "google_play": "http://play.google.com/store/apps/details?id=com.hellochatty",
    "fb_canvas": "http://hellochatty.co/"
  },
  "subcategory": "Other",
  "supported_platforms": [
    "WEB",
    "ANDROID"
  ]
}
```

### `./fb_marketing_api_ad_application_ids.sh`

```bash
./fb_marketing_api_ad_application_ids.sh --access-token '[REDACTED]' --account-id 513503292368998
```

```json
117217775074755
469021223155888
```

## [Facebook Marketing API: FB App](https://developers.facebook.com/docs/graph-api/reference/application/)

```bash
./fb_marketing_api_application.sh --access-token '[REDACTED]' --app-id 117217775074755
```

```json
{
  "id": "117217775074755",
  "an_ad_space_limit": 4,
  "app_ad_debug_info": {
    "last_ios_install": "2018-01-18T01:26:50+0000",
    "last_android_install": "2017-08-14T21:09:00+0000",
    "ios_support_status": "YES",
    "android_support_status": "NO",
    "ios_installs_over_last_seven_days": 449,
    "android_installs_over_last_seven_days": 0,
    "ios_install_invalidation_schemes": [
      "fb117217775074755://",
      "adblite://",
      "fb569841383172272://",
      "makemoney://"
    ],
    "is_ocpm_enabled": true,
    "is_app_in_dev_mode": false,
    "is_app_child_app": false
  },
  "app_install_tracked": true,
  "business": {
    "id": "118941212034253",
    "name": "TUNE"
  },
  "category": "Entertainment",
  "context": {
    "id": "YXBwbGljYXRpb25fY29udGV4dDoxMTcyMTc3NzUwNzQ3NTUZD"
  },
  "default_share_mode": "share_sheet",
  "link": "https://www.facebook.com/games/?app_id=117217775074755",
  "name": "Atomic Dodge Ball Lite",
  "object_store_urls": {
    "itunes": "https://itunes.apple.com/app/id550854415"
  },
  "subcategory": "Other",
  "supported_platforms": [
    "IPHONE"
  ]
}
```

## [Facebook Insights API](https://developers.facebook.com/docs/marketing-api/insights)

### Request starting job to generate report for Ad Account ID between 2 dates

```bash
./fb_insights_api_report_request.sh --access-token '[REDACTED]' --account-id 131134036968667 --verbose --start-date '2018-02-01' --end-date '2018-02-24'
```

#### Returns `report_run_id`

```json
{
  "report_run_id": "362879110860600"
}
```

### Request Status of Job using `report_run_id`

```bash
./fb_insights_api_get_report_status.sh --access-token '[REDACTED]' --report-run-id 362879110860600 --verbose
```

```json
{
  "id": "362879110860600",
  "account_id": "131134036968667",
  "time_ref": 1519680593,
  "time_completed": 1519680595,
  "async_status": "Job Completed",
  "async_percent_completion": 100,
  "date_start": "2018-02-01",
  "date_stop": "2018-02-24"
}
```

### Gather Completed report segments using `report_run_id`

```bash
./fb_insights_api_get_report.sh --access-token '[REDACTED]' --report-run-id 362879110860600 --verbose --save
```

#### Saved report segments to `./_tmp/report_${REPORT_RUN_ID}.json`

```json
{
  "data": [
    {
      "account_id": "131134036968667",
      "actions": [
        {
          "action_target_id": "1267401490056172",
          "action_type": "link_click",
          "value": "1"
        },
        {
          "action_target_id": "1267401490056172",
          "action_type": "page_engagement",
          "value": "1"
        },
        {
          "action_target_id": "1267401490056172",
          "action_type": "post_engagement",
          "value": "1"
        }
      ],
      "ad_id": "6068839961943",
      "ad_name": "Take Surveys - Get Rewarded",
      "adset_id": "6068839963343",
      "adset_name": "FB Page Lookalike",
      "campaign_id": "6068839963543",
      "campaign_name": "PA | AX | Lookalike",
      "date_start": "2018-02-01",
      "date_stop": "2018-02-24",
      "impressions": "98",
      "objective": "APP_INSTALLS",
      "spend": "0",
      "clicks": "1",
      "unique_clicks": "0",
      "reach": "0",
      "hourly_stats_aggregated_by_advertiser_time_zone": "00:00:00 - 00:59:59"
    },
    {
      "account_id": "131134036968667",
      "actions": [
        {
          "action_target_id": "148811898581809",
          "action_type": "post_reaction",
          "value": "1"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "page_engagement",
          "value": "1"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "post_engagement",
          "value": "1"
        }
      ],
      "ad_id": "6068829815343",
      "ad_name": "Take Surveys - Get Rewarded",
      "adset_id": "6068829814743",
      "adset_name": "HVU Lookalike",
      "campaign_id": "6068828436343",
      "campaign_name": "PA | IX | Lookalike",
      "date_start": "2018-02-01",
      "date_stop": "2018-02-24",
      "impressions": "10",
      "objective": "APP_INSTALLS",
      "spend": "0",
      "clicks": "0",
      "unique_clicks": "0",
      "reach": "0",
      "hourly_stats_aggregated_by_advertiser_time_zone": "00:00:00 - 00:59:59"
    },
```

## Request unique_click without hourly breakdown.

The following fields will not return data when using breakdown `hourly_stats_aggregated_by_advertiser_time_zone`:
- `reach`
- `unique_actions`
- `unique_clicks`

```bash
./fb_insights_api_method_get_no_breakdown.sh \
  --access-token '[REDACTED]' \
  --account-id 131134036968667 \
  --verbose \
  --start-date '2018-01-01' \
  --end-date '2018-01-01'
```

```json
{
  "data": [
   {
      "account_id": "131134036968667",
      "campaign_id": "6068828436343",
      "clicks": "414",
      "impressions": "57834",
      "reach": "55557",
      "unique_actions": [
        {
          "action_target_id": "222167777856434",
          "action_type": "app_custom_event",
          "value": "191"
        },
        {
          "action_target_id": "222167777856434",
          "action_type": "app_custom_event.fb_mobile_activate_app",
          "value": "190"
        },
        {
          "action_target_id": "222167777856434",
          "action_type": "app_custom_event.other",
          "value": "117"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "comment",
          "value": "5"
        },
        {
          "action_target_id": "1267394950056826",
          "action_type": "link_click",
          "value": "321"
        },
        {
          "action_target_id": "222167777856434",
          "action_type": "mobile_app_install",
          "value": "178"
        },
        {
          "action_target_id": "1267394950056826",
          "action_type": "page_engagement",
          "value": "321"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "page_engagement",
          "value": "175"
        },
        {
          "action_target_id": "1267394950056826",
          "action_type": "post_engagement",
          "value": "321"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "post_engagement",
          "value": "175"
        },
        {
          "action_target_id": "148811898581809",
          "action_type": "post_reaction",
          "value": "172"
        }
      ],
      "unique_clicks": "401",
      "date_start": "2018-01-01",
      "date_stop": "2018-01-01"
    }
  ],
  "paging": {
    "cursors": {
      "before": "MAZDZD",
      "after": "MjMZD"
    }
  }
}
```

### Parse Report

#### Daily
```bash
$ python3 fb_report_parser_daily.py --report ./_tmp/report_552572148501575.daily.json --csv --html
'Results Data: ./_tmp/report_552572148501575.daily.json, num lines: 2'
'Results CSV: ./_tmp/reports/report_552572148501575.normalized.daily.csv'
'HTML: ./_tmp/reports/report_552572148501575.normalized.daily.html'

$ gzip < ./_tmp/reports/report_552572148501575.normalized.daily.html > ./_tmp/reports/report_552572148501575.normalized.daily.html.gz
```


#### Hourly
```bash
$ python3 fb_report_parser_daily.py --report ./_tmp/report_201059323820168.hourly.json --csv --html
'Results Data: ./_tmp/report_201059323820168.hourly.json, num lines: 535'
'Results CSV: ./_tmp/reports/report_201059323820168.normalized.hourly.csv'
'HTML: ./_tmp/reports/report_201059323820168.normalized.hourly.html'

$ gzip < ./_tmp/reports/report_201059323820168.normalized.hourly.html > ./_tmp/reports/report_201059323820168.normalized.hourly.html.gz
```