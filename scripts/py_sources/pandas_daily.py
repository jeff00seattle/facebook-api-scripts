#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Results Parser: Pandas

from pprintpp import pprint
import pandas as pd
import numpy as np
from .pandas_to_report import (
    df_nested_excel,
    df_nested_html_table
)

def pandasJsonNormalizeDaily(dataRaw, html=False, excel=False, limit=0):
    df = pd.io.json.json_normalize(dataRaw)
    df = df.replace(np.nan, '', regex=True)
    df = df.replace('\n', '', regex=True)

    column_sort = []

    cols = df.columns.tolist()
    index = 0
    if 'date_start' in cols:
        cols.insert(index, cols.pop(cols.index('date_start')))
        index += 1
        column_sort.append('date_start')
    if 'date_stop' in cols:
        cols.insert(index, cols.pop(cols.index('date_stop')))
        index += 1
        column_sort.append('date_stop')

    if 'account_id' in cols:
        cols.insert(index, cols.pop(cols.index('account_id')))
        index += 1
        column_sort.append('account_id')
    if 'account_name' in cols:
        cols.insert(index, cols.pop(cols.index('account_name')))
        index += 1
    if 'account_currency' in cols:
        cols.insert(index, cols.pop(cols.index('account_currency')))
        index += 1

    if 'campaign_id' in cols:
        cols.insert(index, cols.pop(cols.index('campaign_id')))
        index += 1
        column_sort.append('campaign_id')
    if 'campaign_name' in cols:
        cols.insert(index, cols.pop(cols.index('campaign_name')))
        index += 1
    if 'ad_id' in cols:
        cols.insert(index, cols.pop(cols.index('ad_id')))
        index += 1
        column_sort.append('ad_id')
    if 'ad_name' in cols:
        cols.insert(index, cols.pop(cols.index('ad_name')))
        index += 1
    if 'adset_id' in cols:
        cols.insert(index, cols.pop(cols.index('adset_id')))
        index += 1
        column_sort.append('adset_id')
    if 'adset_name' in cols:
        cols.insert(index, cols.pop(cols.index('adset_name')))
        index += 1
    if 'objective' in cols:
        cols.insert(index, cols.pop(cols.index('objective')))
        index += 1

    if 'spend' in cols:
        cols.insert(index, cols.pop(cols.index('spend')))
        index += 1
    if 'clicks' in cols:
        cols.insert(index, cols.pop(cols.index('clicks')))
        index += 1
    if 'unique_clicks' in cols:
        cols.insert(index, cols.pop(cols.index('unique_clicks')))
        index += 1
    if 'unique_ctr' in cols:
        cols.insert(index, cols.pop(cols.index('unique_ctr')))
        index += 1
    if 'impressions' in cols:
        cols.insert(index, cols.pop(cols.index('impressions')))
        index += 1
    if 'reach' in cols:
        cols.insert(index, cols.pop(cols.index('reach')))
        index += 1

    if 'actions' in cols:
        cols.insert(index, cols.pop(cols.index('actions')))
        index += 1
    if 'action_values' in cols:
        cols.insert(index, cols.pop(cols.index('action_values')))
        index += 1
    if 'unique_actions' in cols:
        cols.insert(index, cols.pop(cols.index('unique_actions')))
        index += 1
    if 'outbound_clicks' in cols:
        cols.insert(index, cols.pop(cols.index('outbound_clicks')))
        index += 1
    if 'unique_outbound_clicks' in cols:
        cols.insert(index, cols.pop(cols.index('unique_outbound_clicks')))
        index += 1

    df = df.reindex(columns=cols)

    df = df.sort_values(column_sort)

    if limit > 0:
        df = df[:limit]

    if html:
        if 'actions' in df:
            df['actions'] = df['actions'].apply(df_nested_html_table)
        if 'action_values' in df:
            df['action_values'] = df['action_values'].apply(df_nested_html_table)
        if 'unique_actions' in df:
            df['unique_actions'] = df['unique_actions'].apply(df_nested_html_table)
        if 'outbound_clicks' in df:
            df['outbound_clicks'] = df['outbound_clicks'].apply(df_nested_html_table)
        if 'unique_outbound_clicks' in df:
            df['unique_outbound_clicks'] = df['unique_outbound_clicks'].apply(df_nested_html_table)

    return df
