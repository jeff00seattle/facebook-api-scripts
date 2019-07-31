#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Results Parser: Export

import os
from pprintpp import pprint
import jinja2
import pandas as pd

def exportFilePrep(resultsFilePath, report, type):
    head, tail = os.path.split(resultsFilePath)
    filename = tail.split(".")[0]
    filepath = f"{head}/reports"

    reportFilePath = f"{filepath}/{filename}.{report}.{type}"
    os.remove(reportFilePath) if os.path.exists(reportFilePath) else None
    return reportFilePath


def exportResultsCSV(resultsFilePath, report, df):
    resultsFile = exportFilePrep(resultsFilePath, report, "csv")
    df.to_csv(resultsFile, sep=',', encoding='utf-8', index=True, float_format='%.2f')

    if os.path.exists(resultsFile):
        pprint(f"Results CSV: {resultsFile}")

    return df, resultsFile


def exportResultsExcel(resultsFilePath, report, df):
    resultsFile = exportFilePrep(resultsFilePath, report, "xlsx")
    df.to_excel(resultsFile, encoding='utf-8', index=True, float_format='%.2f')

    if os.path.exists(resultsFile):
        pprint(f"Results Excel: {resultsFile}")

    return df, resultsFile


def exportResultsTEX(resultsFilePath, report, df):
    resultsFile = exportFilePrep(resultsFilePath, report, "tex")
    with open(resultsFile, 'w') as tf:
        tf.write(df.to_latex())

    if os.path.exists(resultsFile):
        pprint(f"TEX: {resultsFile}")

    return df, resultsFile


def exportResultsHTML(resultsFilePath, report, df):
    reportFileTmpPath = exportFilePrep(resultsFilePath, f"{report}.tmp", "html")
    reportFilePath = exportFilePrep(resultsFilePath, report, "html")

    reportFileBase = os.path.basename(reportFilePath)

    html_template = """
    <!DOCTYPE html>
    <html lang=\"en\">
    <head>
    <meta charset=\"UTF-8\">
    <title>{{ results_title }}</title>
    <style>
        .dataframe { font-family: "Trebuchet MS", Arial, Helvetica, sans-serif; border-collapse: collapse; width: 100%; }
        .dataframe table {
            table-layout: fixed;
            border-collapse: collapse;
            overflow-y: auto;
            height: 200px;
            border-spacing: 0;
            width: 100%;
            min-width: 700px;
        }
        .dataframe td, .dataframe th {
            border: 1px solid #ddd;
            padding: 8px;
            font-size: 11px;
            white-space: nowrap;
            vertical-align: top;
            text-align: left;
        }
        .dataframe th { padding-top: 12px; padding-bottom: 12px; text-align: left; background-color: #52A55C; color: white; }
        .dataframe table td:first-child{ width: 50px; }
        .dataframe table table td:first-child{ width: 50px; }
        .dataframe tr:nth-child(even){background-color: #f2f2f2;}

    </style>
    </head>
    <body>
    <h2>{{ results_header }}</h2>
    {{ results_table }}
    </body>
    </html>
    """

    results_template = jinja2.Template(html_template)
    pd.set_option('display.max_colwidth', -1)

    results_template_vars = {
        "results_title": reportFileBase,
        "results_header": reportFileBase,
        "results_table": df.to_html(index=True, classes='dataframe')
    }
    rendered_html = results_template.render(results_template_vars)

    rendered_html = rendered_html.replace("&lt;", "<")
    rendered_html = rendered_html.replace("&gt;", ">")
    rendered_html = rendered_html.strip('\n')

    head, tail = os.path.split(resultsFilePath)
    filepath = f"{head}/reports"

    try:
        os.makedirs(filepath)
    except OSError:
        if not os.path.isdir(filepath):
            raise

    with open(reportFileTmpPath, 'w') as html:
        html.write(rendered_html)

    lst = []
    with open(reportFileTmpPath, 'r') as html:
        lines = html.readlines()
        for line in lines:
            line = line.replace('\n', '').replace('\r', '')
            line = line.replace("dataframe dataframe", "_xataframe").replace(".dataframe", "_sataframe").replace("dataframe", "").replace("_xataframe", "dataframe").replace("_sataframe", ".dataframe")
            lst.append(line)

    os.remove(reportFileTmpPath) if os.path.exists(reportFileTmpPath) else None

    with open(reportFilePath, 'w') as html:
        for line in lst:
            html.write(line)

    if os.path.exists(reportFilePath):
        pprint(f"HTML: {reportFilePath}")
