#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Results Parser: Pandas

import pandas as pd

def df_nested_html_table(values):
    if values == '':
        return values

    json_values = values
    df_row_values = pd.io.json.json_normalize(json_values)
    df_row_values = df_row_values.replace("\n", "", regex=True)
    df_row_values = df_row_values.sort_values(df_row_values.columns[0], ascending=False)
    html_row_table = df_row_values.to_html(index=False)

    return html_row_table.replace('\n', '').replace('\r', '')


def df_nested_excel(values):
    if values == '':
        return values

    json_values = values
    df_row_values = pd.io.json.json_normalize(json_values)
    df_row_values = df_row_values.replace("\n", "", regex=True)
    df_row_values = df_row_values.sort_values(df_row_values.columns[0], ascending=False)
    excel_row_table = df_row_values.to_excel(encoding='utf-8', index=False, float_format='%.2f')

    return excel_row_table.replace('\n', '').replace('\r', '')
