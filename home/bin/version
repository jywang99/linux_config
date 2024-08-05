#!/bin/bash

function usage {
    echo "Usage: version.sh <name> [minor]"
    echo "  name:   name of the project."
    echo "  minor:  minor version number (0-99). Default is 0."
}

NAME=$1
if [ -z $NAME ]; then
    echo "Name must be provided."
    usage
    exit 1
fi

# must be 0-99
MINOR=$2
if [ -z $MINOR ]; then
    MINOR=0
elif [ $MINOR -lt 0 ] || [ $MINOR -gt 99 ]; then
    usage
    exit 1
fi

# Get current date components
YEAR=$(date +"%y")
WEEK_NUMBER=$(date +"%V")
DAY_OF_WEEK=$(date +"%u")

# Pad the argument to ensure it's always two digits
SUFFIX=$(printf "%02d" "$MINOR")

# Construct the date string
DATE_STRING="$YEAR.$WEEK_NUMBER$NAME$DAY_OF_WEEK.$SUFFIX"

# Print the result
echo $DATE_STRING

