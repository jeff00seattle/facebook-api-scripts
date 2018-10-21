#  Makefile
#
#  Copyright (c) 2018 Tune, Inc
#  All rights reserved.
#

PYTHON3 := $(shell which python3)
PIP3    := $(shell which pip3)
PYTHON3_VERSION := $(shell $(PYTHON3) --version)

FB_REPORT_ID := $(report-run-id)
FB_REPORT_JSON := "_tmp/report_$(FB_REPORT_ID).json"

FB_REPORT_LIMIT := $(limit)

install-tools:
	@echo "======================================================"
	@echo install-tools
	@echo "======================================================"
	$(PIP3) install --upgrade pip
	$(PIP3) install --upgrade -r ../../../requirements-tools.txt

results: install-tools
	@echo "======================================================"
	@echo results --report $(FB_REPORT_JSON) --limit $(FB_REPORT_LIMIT)
	@echo "======================================================"
	@test -f $(FB_REPORT_JSON) || (echo "File $(FB_REPORT_JSON) missing!" ; exit 1)
	@ls -al $(FB_REPORT_JSON)
	@mkdir -p _tmp/reports
	@rm -fR _tmp/reports/*.csv
	@rm -fR _tmp/reports/*.html
	@rm -fR _tmp/reports/*.xlsx
	@$(PYTHON3) fb_report_parser.py --report "$(FB_REPORT_JSON)" --limit "$(FB_REPORT_LIMIT)" --csv --html --excel
	@ls -al _tmp/reports/*.csv 2>/dev/null
	@ls -al _tmp/reports/*.html 2>/dev/null
	@ls -al _tmp/reports/*.xlsx 2>/dev/null

list:
	cat Makefile | grep "^[a-z]" | awk '{print $$1}' | sed "s/://g" | sort
