#!/bin/bash

# ========================================
# Linux Log Monitoring & Error Detection
# ========================================

LOG_FILE="$1"
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/log_report.txt"
MONITOR_LOG="logs/monitor.log"


# ========================================
# Write monitoring activity to log
# ========================================

write_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$MONITOR_LOG"
}


# ========================================
# Validate input
# ========================================

validate_input() {

    if [ -z "$LOG_FILE" ]; then
        echo "Usage: $0 <log_file>"
        exit 3
    fi

    if [ ! -f "$LOG_FILE" ]; then
        echo "ERROR: Log file not found: $LOG_FILE"
        write_log "ERROR: Log file not found: $LOG_FILE"
        exit 3
    fi

    if [ ! -d "$REPORT_DIR" ]; then
        echo "ERROR: Report directory not found: $REPORT_DIR"
        write_log "ERROR: Report directory not found: $REPORT_DIR"
        exit 3
    fi
}


# ========================================
# Analyze log
# ========================================

analyze_log() {

    ERROR_COUNT=$(grep -ic "ERROR" "$LOG_FILE")
    WARNING_COUNT=$(grep -ic "WARNING" "$LOG_FILE")

    LATEST_EVENTS=$(tail -n 5 "$LOG_FILE")

    LATEST_ERRORS=$(grep -i "ERROR" "$LOG_FILE" | tail -n 3)

    LATEST_WARNINGS=$(grep -i "WARNING" "$LOG_FILE" | tail -n 3)
}


# ========================================
# Determine monitoring status
# ========================================

determine_status() {

    if [ "$ERROR_COUNT" -gt 0 ]; then
        STATUS="ERROR"

    elif [ "$WARNING_COUNT" -gt 0 ]; then
        STATUS="WARNING"

    else
        STATUS="OK"
    fi
}


# ========================================
# Generate report
# ========================================

generate_report() {

    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    cat > "$REPORT_FILE" <<EOF
========================================
 Linux Log Monitoring Report
========================================

Generated At : $TIMESTAMP
Log File     : $LOG_FILE

SUMMARY
-------
ERROR COUNT   : $ERROR_COUNT
WARNING COUNT : $WARNING_COUNT

LATEST EVENTS
-------------
$LATEST_EVENTS

LATEST ERRORS
-------------
$LATEST_ERRORS

LATEST WARNINGS
---------------
$LATEST_WARNINGS

STATUS
------
$STATUS
EOF
}


# ========================================
# Main program
# ========================================

main() {

    write_log "Monitoring started"

    validate_input

    write_log "Input validation completed"

    analyze_log

    write_log "Log analysis completed"

    determine_status

    write_log "Monitoring status: $STATUS"

    generate_report

    write_log "Report generated: $REPORT_FILE"

    echo "========================================"
    echo " Linux Log Monitoring"
    echo "========================================"
    echo
    echo "Log file : $LOG_FILE"
    echo "Report   : $REPORT_FILE"
    echo "Status   : $STATUS"
    echo
    echo "ERROR    : $ERROR_COUNT"
    echo "WARNING  : $WARNING_COUNT"
    echo

    if [ "$ERROR_COUNT" -gt 0 ]; then
        exit 2

    elif [ "$WARNING_COUNT" -gt 0 ]; then
        exit 1

    else
        exit 0
    fi
}


# ========================================
# Start program
# ========================================

main
