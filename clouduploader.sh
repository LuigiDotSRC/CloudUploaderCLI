#!/bin/bash

# USAGE: clouduploader /path/to/file.txt

FILENAME=$1

# TODO: move all if statements to init_checks.sh 

if [ ! "$FILENAME" ]; then
    echo "USAGE: clouduploader /path/to/file.txt"
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

# filename without ./ or ../ 
NAME=$(echo "$FILENAME" | sed -e 's@\.\./@@g' -e 's@\.\/@@g' -e 's@.*/@@')
cp "$FILENAME" "$NAME"

# TODO: add container name param 
az storage blob upload --account-name $ACCOUNT_NAME --container-name files --name $NAME --file $NAME --auth-mode key --account-key $AZURE_STORAGE_KEY

# cleanup copied file
rm "$NAME"

echo done
exit 0