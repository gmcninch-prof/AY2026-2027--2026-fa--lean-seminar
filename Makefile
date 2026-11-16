COURSE_FILE  = lean-seminar-fall26.mlml
OUTPUT_DIR   = calendar
MD_FILES     = $(OUTPUT_DIR)/calendar.md $(OUTPUT_DIR)/lectures.md $(OUTPUT_DIR)/assignments.md
REPORT_TYPES = calendar,lectures,assignments,org

include $(HOME)/.local/bin/course.mk

