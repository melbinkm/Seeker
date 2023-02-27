#!/bin/bash

# Define default search paths and file patterns
default_search_paths=("/etc" "/home" "/var" "/usr/local")
default_file_patterns=("*.conf" "*.cfg" "*.passwd" "*.password" "*.key" "*.txt")

# Show help message
show_help() {
  echo "Usage: $(basename $0) [-h] [-p search_path] [-f file_pattern] [-r regex_pattern]"
  echo "Search for sensitive information in files."
  echo ""
  echo "  -h             Show this help message."
  echo "  -p search_path Specify the search path(s). (default: ${default_search_paths[@]})"
  echo "  -f file_pattern Specify the file pattern(s). (default: ${default_file_patterns[@]})"
  echo "  -r regex_pattern Specify the regular expression(s) to search for."
  echo ""
  exit 0
}

# Parse command-line arguments
while getopts ":hp:f:r:" opt; do
  case $opt in
    h) show_help ;;
    p) search_paths=("$OPTARG") ;;
    f) file_patterns=("$OPTARG") ;;
    r) regex=("$OPTARG") ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

# Set default search paths and file patterns if not specified
search_paths=${search_paths:-${default_search_paths[@]}}
file_patterns=${file_patterns:-${default_file_patterns[@]}}

# Use grep command to search for matching regular expressions in the specified search paths and file patterns
if [ -n "${regex}" ]; then
  grep_output=$(grep -rE "${regex[@]}" ${search_paths[@]/%/\/}${file_patterns[@]} 2>/dev/null)

  # Output any matches found
  if [ -n "$grep_output" ]; then
    echo "Sensitive information found in files:"
    echo "$grep_output"
  fi
else
  grep_output=$(grep -rE '\b(password|pass|passwd|secret|login)\b[\s:]+([^\s]+)' ${search_paths[@]/%/\/}${file_patterns[@]} 2>/dev/null)

  # Output any matches found
  if [ -n "$grep_output" ]; then
    echo "Sensitive information found in files:"
    echo "$grep_output"
  fi
fi
