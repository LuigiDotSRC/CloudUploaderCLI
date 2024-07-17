#!/bin/bash

# USAGE: clouduploader /path/to/file.txt container-name 


FILENAME=$1
CONTAINERNAME=$2
source .clouduploaderconfig 2> /dev/null

# local run:
source .env 2> /dev/null

if [ ! "$FILENAME" -o ! "$CONTAINERNAME" ]; then
    echo "USAGE: clouduploader /path/to/file.txt container-name"
    exit 1
fi

if [ ! -f $FILENAME ]; then
    echo "File does not exist" 
    exit 1
fi

if [ ! "$SUBSCRIPTION_ID" -o ! "$ACCOUNT_NAME" -o ! "$AZURE_STORAGE_KEY" ]; then
    echo ".clouduploaderconfig not configured correctly"
    exit 1
fi


# filename without ./ or ../ 
NAME=$(echo "$FILENAME" | sed -e 's@\.\./@@g' -e 's@\.\/@@g' -e 's@.*/@@')
cp "$FILENAME" "$NAME"

upld=$(az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINERNAME --name $NAME --file $NAME --auth-mode key --account-key $AZURE_STORAGE_KEY 2>&1) 

if echo "$upld" | grep -q "ErrorCode:ContainerNotFound"; then
    echo "Invalid container name"
    az storage container list --account-name $ACCOUNT_NAME --auth-mode key --account-key $AZURE_STORAGE_KEY | grep "name"
    exit 1
fi

if echo "$upld" | grep -q "ErrorCode:BlobAlreadyExists"; then
    echo -n "File: $NAME already exists in $CONTAINERNAME. Overwrite? (y/n default=y): "
    read input
    if [ ! "$input" ] || [ "$input" = "y" ]; then 
        az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINERNAME --name $NAME --file $NAME --auth-mode key --account-key $AZURE_STORAGE_KEY --overwrite
    fi
fi

# cleanup copied file
rm "$NAME"

if [ $? -eq 0 ]; then
    echo "Success!"
fi

exit 0