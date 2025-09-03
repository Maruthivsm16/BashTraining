#!/bin/bash
crontab_cmd=$(which crontab)    # Check if crontab command exists
if [ -z "$crontab_cmd" ]; then
  echo "Error: crontab command not found!"
  exit 1
fi
case "$1" in 
  add)                                        
    if [ -z "$2" ]; then                 # Check if cron schedule and command are provided
      echo "usage: $0 missing arguments add  \"<cron schedule> <cmd>\"" 
      exit 1
    fi  
    (crontab -l 2>/dev/null; echo "$2") | crontab - # Append new job to crontab
    echo "job added: $2" ;;
  list)                                      # List current cron jobs
    echo "current cron jobs:"
    crontab -l 2>/dev/null || echo "No cron jobs found." ;;
  remove)                                    # Remove cron jobs matching a pattern
    if [ -z "$2" ]; then
      echo "usage: $0 missing arguments provide \"<pattern_to_match>\""
      exit 1
    fi
    crontab -l 2>/dev/null | grep -v "$2" | crontab -   # Remove jobs matching pattern
    echo "jobs matching '$2' removed." ;;
  *)
    echo "usage: $0 {add|list|remove} "  # Display usage if invalid option is provided
    exit 1
    ;;
esac
