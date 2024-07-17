#!/bin/bash

# USAGE: clouduploader /path/to/file.txt container-name [OPTION]...

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

az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINERNAME --name $NAME --file $NAME --auth-mode key --account-key $AZURE_STORAGE_KEY
echo $?

# cleanup copied file
rm "$NAME"

echo done
exit 0