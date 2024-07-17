#!/bin/bash

FILENAME=$1
CONTAINERNAME=$2

if [ ! "$FILENAME" -o ! "$CONTAINERNAME" ]; then
    echo "USAGE: clouduploader /path/to/file.txt container-name"
    exit 1
fi

if [ ! -f $FILENAME ]; then
    echo "File does not exist" 
    exit 1
fi

if [ -f .env ]; then
    source .env
else 
    echo ".env file not found"
    exit 1
fi

if [ ! "$SUBSCRIPTION_ID" -o ! "$ACCOUNT_NAME" -o ! "$AZURE_STORAGE_KEY" ]; then
    echo ".env not configured correctly"
    exit 1
fi

exit 0 