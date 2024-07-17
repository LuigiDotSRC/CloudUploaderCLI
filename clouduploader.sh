#!/bin/bash

# USAGE: clouduploader /path/to/file.txt container-name 

# TODO: if the file already exists, prompt user for overwrite

bash ./init_checks.sh $@ 
if [ ! $? -eq 0 ]; then 
    exit 1
fi

FILENAME=$1
CONTAINERNAME=$2
source .env

# filename without ./ or ../ 
NAME=$(echo "$FILENAME" | sed -e 's@\.\./@@g' -e 's@\.\/@@g' -e 's@.*/@@')
cp "$FILENAME" "$NAME"

upld=$(az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINERNAME --name $NAME --file $NAME --auth-mode key --account-key $AZURE_STORAGE_KEY 2>&1) 

if echo "$upld" | grep -q "ErrorCode:ContainerNotFound"; then
    echo "Invalid container name"
    az storage container list --account-name $ACCOUNT_NAME --auth-mode key --account-key $AZURE_STORAGE_KEY | grep "name"
    
fi

# cleanup copied file
rm "$NAME"

exit 0