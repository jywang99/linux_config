#!/bin/bash

FILE_NAME=$1
if [ -z "$FILE_NAME" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

PARENT_DIR=$(dirname $FILE_NAME)
if [ ! -d "$PARENT_DIR" ]; then
    echo "Parent directory does not exist: $PARENT_DIR"
    exit 1
fi

wl-paste > $FILE_NAME

if [ ! -s "$FILE_NAME" ]; then
    rm $FILE_NAME
    echo "File is empty, deleted: $FILE_NAME"
fi

