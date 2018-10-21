#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Results Parser

import os
import sys
import getopt
from pprintpp import pprint

if __name__ == '__main__':
    from py_sources import  (
        parseNDJSON,

        pandasJsonNormalizeDaily,

        exportResultsCSV,
        exportResultsHTML,
        exportResultsExcel,
    )
else:
    from .py_sources import  (
        parseNDJSON,

        pandasJsonNormalizeDaily,

        exportResultsCSV,
        exportResultsHTML,
        exportResultsExcel,
    )

def main(argv):
    generateCSV = False
    generateHTML = False
    generateExcel = False
    limit = 0

    verbose=False
    jsonReportFilePath = ''
    try:
        opts, args = getopt.getopt(argv, 'vhd:', ['verbose', 'help', 'report=', 'limit=', 'csv', 'html', 'excel'])
    except getopt.GetoptError:
        print(f"{os.path.basename(__file__)} --report <report_json_file>")
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(f"{os.path.basename(__file__)} --report <report_json_file>")
            sys.exit()
        elif opt in ("-v", "--verbose"):
            verbose = True
        elif opt in ("--limit"):
            limit = int(arg)
        elif opt in ("--csv"):
            generateCSV = True
        elif opt in ("--html"):
            generateHTML = True
        elif opt in ("--excel"):
            generateExcel = True
        elif opt in ("-r", "--report"):
            jsonReportFilePath = arg

    if verbose:
        pprint({
            "generateCSV": generateCSV,
            "generateHTML": generateHTML,
            "generateExcel": generateExcel,
        })

    if not os.path.isfile(jsonReportFilePath):
        print(f"Results: File is missing: {jsonReportFilePath}")
        sys.exit(1)
    if not os.access(jsonReportFilePath, os.R_OK):
        print(f"Results: File is not readable: {jsonReportFilePath}")
        sys.exit(1)

    if not generateCSV and not generateHTML and not generateExcel:
        generateCSV = True

    dataRaw, num_lines = parseNDJSON(jsonReportFilePath)
    pprint(f"Results Data: {jsonReportFilePath}, num lines: {num_lines}")

    if num_lines == 0 or not dataRaw:
        pprint("No results")
        sys.exit(0)



    if generateCSV:
        dfNormalized = pandasJsonNormalizeDaily(dataRaw, False, False, limit)
        exportResultsCSV(jsonReportFilePath, "normalized.daily", dfNormalized)
    if generateHTML:
        dfNormalizedHtml = pandasJsonNormalizeDaily(dataRaw, True, False, limit)
        exportResultsHTML(jsonReportFilePath, "normalized.daily", dfNormalizedHtml)
    if generateExcel:
        dfNormalizedExcel = pandasJsonNormalizeDaily(dataRaw, False, True, limit)
        exportResultsExcel(jsonReportFilePath, "normalized.daily", dfNormalizedExcel)


if __name__ == "__main__":
   main(sys.argv[1:])